
-- QUERIES --



-- QUERY 3.1

SELECT 
    CONCAT(c.cook_first_name, ' ', c.cook_last_name) AS chef_name,
    cu.cuisine_name,
    AVG(jr.total_rating) AS average_rating
FROM
    cook c
    JOIN cook_expertise ce ON c.id_cook = ce.id_cook
    JOIN cuisine cu ON ce.id_cuisine = cu.id_cuisine
    JOIN judge_rating jr ON c.id_cook = jr.id_cook
GROUP BY
    chef_name, cu.cuisine_name;












-- QUERY 3.2

-- Define the given cuisine and year
SET @given_cuisine = 'Greek';
SET @given_year = 2024;

SELECT
    DISTINCT CONCAT(c.cook_first_name, ' ', c.cook_last_name) AS chef_name,
    cu.cuisine_name,
    jr.year_of_competition
FROM
    cook c
    JOIN cook_expertise ce ON c.id_cook = ce.id_cook
    JOIN cuisine cu ON ce.id_cuisine = cu.id_cuisine
    JOIN judge_rating jr ON c.id_cook = jr.id_cook AND jr.year_of_competition = @given_year
WHERE
    cu.cuisine_name = @given_cuisine;










-- QUERY 3.3

SELECT 
    CONCAT(c.cook_first_name, ' ', c.cook_last_name) AS chef_name,
    c.age,
    COUNT(ce.id_recipe) AS recipe_count
FROM
    cook c
    JOIN competition_episode ce ON c.id_cook = ce.id_cook
WHERE
    c.age < 30
GROUP BY
    chef_name, c.age
ORDER BY
    recipe_count DESC;












-- QUERY 3.4

SELECT 
    CONCAT(c.cook_first_name, ' ', c.cook_last_name) AS chef_name,
    c.age
FROM
    cook c
WHERE
    c.id_cook NOT IN (SELECT id_judge FROM judge);











-- QUERY 3.5

-- If we modify to <1 we get results.

WITH JudgeAppearances AS (
    SELECT
        j.id_judge,
        CONCAT(j.judge_first_name, ' ', j.judge_last_name) AS judge_name,
        j.year_of_competition,
        COUNT(j.id_episode) AS appearance_count
    FROM
        judge j
    GROUP BY
        j.id_judge, j.judge_first_name, j.judge_last_name, j.year_of_competition
    HAVING
        COUNT(j.id_episode) > 3
),
JudgeWithSameAppearances AS (
    SELECT
        ja1.judge_name AS judge_name1,
        ja2.judge_name AS judge_name2,
        ja1.year_of_competition,
        ja1.appearance_count
    FROM
        JudgeAppearances ja1
        JOIN JudgeAppearances ja2 ON ja1.appearance_count = ja2.appearance_count
            AND ja1.year_of_competition = ja2.year_of_competition
            AND ja1.id_judge < ja2.id_judge
)
SELECT
    judge_name1,
    judge_name2,
    year_of_competition,
    appearance_count
FROM
    JudgeWithSameAppearances;












-- QUERY 3.6

-- Query without forced index
SELECT 
    t1.tag_name AS tag1, 
    t2.tag_name AS tag2, 
    COUNT(DISTINCT ce.id_episode) AS episode_count
FROM 
    recipe_tag rt1
JOIN 
    recipe_tag rt2 ON rt1.id_recipe = rt2.id_recipe AND rt1.id_tag < rt2.id_tag
JOIN 
    tag t1 ON rt1.id_tag = t1.id_tag
JOIN 
    tag t2 ON rt2.id_tag = t2.id_tag
JOIN 
    competition_episode ce ON rt1.id_recipe = ce.id_recipe
GROUP BY 
    t1.tag_name, 
    t2.tag_name
ORDER BY 
    episode_count DESC
LIMIT 3;



-- Query with forced index
SELECT 
    t1.tag_name AS tag1, 
    t2.tag_name AS tag2, 
    COUNT(DISTINCT ce.id_episode) AS episode_count
FROM 
    recipe_tag rt1 FORCE INDEX (idx_recipe_tags_recipe_id, idx_recipe_tags_tag_id)
JOIN 
    recipe_tag rt2 FORCE INDEX (idx_recipe_tags_recipe_id, idx_recipe_tags_tag_id) ON rt1.id_recipe = rt2.id_recipe AND rt1.id_tag < rt2.id_tag
JOIN 
    tag t1 ON rt1.id_tag = t1.id_tag
JOIN 
    tag t2 ON rt2.id_tag = t2.id_tag
JOIN 
    competition_episode ce FORCE INDEX (idx_competition_episode_recipe_id) ON rt1.id_recipe = ce.id_recipe
GROUP BY 
    t1.tag_name, 
    t2.tag_name
ORDER BY 
    episode_count DESC
LIMIT 3;


-- COMPARING TWO METHODS --

-- Original query
EXPLAIN SELECT 
    t1.tag_name AS tag1, 
    t2.tag_name AS tag2, 
    COUNT(DISTINCT ce.id_episode) AS episode_count
FROM 
    recipe_tag rt1
JOIN 
    recipe_tag rt2 ON rt1.id_recipe = rt2.id_recipe AND rt1.id_tag < rt2.id_tag
JOIN 
    tag t1 ON rt1.id_tag = t1.id_tag
JOIN 
    tag t2 ON rt2.id_tag = t2.id_tag
JOIN 
    competition_episode ce ON rt1.id_recipe = ce.id_recipe
GROUP BY 
    t1.tag_name, 
    t2.tag_name
ORDER BY 
    episode_count DESC
LIMIT 3;


-- Query with forced index
EXPLAIN SELECT 
    t1.tag_name AS tag1, 
    t2.tag_name AS tag2, 
    COUNT(DISTINCT ce.id_episode) AS episode_count
FROM 
    recipe_tag rt1 FORCE INDEX (idx_recipe_tags_recipe_id, idx_recipe_tags_tag_id)
JOIN 
    recipe_tag rt2 FORCE INDEX (idx_recipe_tags_recipe_id, idx_recipe_tags_tag_id) ON rt1.id_recipe = rt2.id_recipe AND rt1.id_tag < rt2.id_tag
JOIN 
    tag t1 ON rt1.id_tag = t1.id_tag
JOIN 
    tag t2 ON rt2.id_tag = t2.id_tag
JOIN 
    competition_episode ce FORCE INDEX (idx_competition_episode_recipe_id) ON rt1.id_recipe = ce.id_recipe
GROUP BY 
    t1.tag_name, 
    t2.tag_name
ORDER BY 
    episode_count DESC
LIMIT 3;














-- QUERY 3.7

WITH ChefParticipations AS (
    SELECT 
        ce.id_cook,
        CONCAT(c.cook_first_name, ' ', c.cook_last_name) AS chef_name,
        COUNT(ce.id_episode) AS participation_count
    FROM
        competition_episode ce
        JOIN cook c ON ce.id_cook = c.id_cook
    GROUP BY
        ce.id_cook
),
MaxParticipation AS (
    SELECT 
        MAX(participation_count) AS max_participation
    FROM
        ChefParticipations
),
FilteredChefs AS (
    SELECT
        cp.chef_name,
        cp.participation_count,
        mp.max_participation
    FROM
        ChefParticipations cp
        CROSS JOIN MaxParticipation mp
    WHERE
        cp.participation_count <= mp.max_participation - 5
)
SELECT 
    chef_name,
    participation_count
FROM 
    FilteredChefs
ORDER BY 
    participation_count DESC;













-- QUERY 3.8

-- Query without forced index
SELECT ce.id_episode, COUNT(DISTINCT re.id_equipment) AS equipment_count
FROM competition_episode ce
JOIN recipe_equipment re ON ce.id_recipe = re.id_recipe
GROUP BY ce.id_episode
ORDER BY equipment_count DESC
LIMIT 1;

-- Query with index 
SELECT ce.id_episode, COUNT(DISTINCT re.id_equipment) AS equipment_count
FROM competition_episode ce FORCE INDEX (idx_competition_episode_recipe)
JOIN recipe_equipment re FORCE INDEX (idx_recipe_equipment) ON ce.id_recipe = re.id_recipe
GROUP BY ce.id_episode
ORDER BY equipment_count DESC
LIMIT 1;



-- COMPARING TWO METHODS --
-- Original query
EXPLAIN SELECT ce.id_episode, COUNT(DISTINCT re.id_equipment) AS equipment_count
FROM competition_episode ce
JOIN recipe_equipment re ON ce.id_recipe = re.id_recipe
GROUP BY ce.id_episode
ORDER BY equipment_count DESC
LIMIT 1;

-- Query with forced index
EXPLAIN SELECT ce.id_episode, COUNT(DISTINCT re.id_equipment) AS equipment_count
FROM competition_episode ce FORCE INDEX (idx_competition_episode_recipe)
JOIN recipe_equipment re FORCE INDEX (idx_recipe_equipment) ON ce.id_recipe = re.id_recipe
GROUP BY ce.id_episode
ORDER BY equipment_count DESC
LIMIT 1;












-- QUERY 3.9

WITH YearlyCarbs AS (
    SELECT
        ce.year_of_competition,
        rn.carbs_per_serving
    FROM
        competition_episode ce
        JOIN recipe_nutrition rn ON ce.id_recipe = rn.id_recipe
)
SELECT
    year_of_competition,
    AVG(carbs_per_serving) AS average_carbs
FROM
    YearlyCarbs
GROUP BY
    year_of_competition
ORDER BY
    year_of_competition;
















-- QUERY 3.10

WITH YearlyParticipations AS (
    SELECT
        ce.id_cuisine,
        cu.cuisine_name,
        ce.year_of_competition,
        COUNT(ce.id_episode) AS participation_count
    FROM
        competition_episode ce
        JOIN cuisine cu ON ce.id_cuisine = cu.id_cuisine
    GROUP BY
        ce.id_cuisine, ce.year_of_competition
    HAVING
        COUNT(ce.id_episode) >= 3
),
ConsecutiveYears AS (
    SELECT
        yp1.cuisine_name,
        yp1.year_of_competition AS year1,
        yp2.year_of_competition AS year2,
        yp1.participation_count
    FROM
        YearlyParticipations yp1
        JOIN YearlyParticipations yp2 ON yp1.id_cuisine = yp2.id_cuisine
            AND yp1.year_of_competition = yp2.year_of_competition - 1
            AND yp1.participation_count = yp2.participation_count
)
SELECT
    cuisine_name,
    year1,
    year2,
    participation_count
FROM
    ConsecutiveYears
ORDER BY
    cuisine_name, year1;













-- QUERY 3.11

SELECT 
    j.judge_first_name AS judge_first_name,
    j.judge_last_name AS judge_last_name,
    c.cook_first_name AS cook_first_name,
    c.cook_last_name AS cook_last_name,
    (jjr.rating) AS total_score
FROM 
    judges_judge_rating jjr
JOIN 
    judge j ON jjr.id_judge = j.id_judge
JOIN 
    cook c ON jjr.id_cook = c.id_cook
GROUP BY 
    j.judge_first_name, j.judge_last_name, c.cook_first_name, c.cook_last_name
ORDER BY 
    total_score DESC
LIMIT 5;















-- QUERY 3.12

WITH ranked_episodes AS (
    SELECT 
        ce.year_of_competition,
        ce.id_episode,
        AVG(r.difficulty) AS total_difficulty,
        RANK() OVER (PARTITION BY ce.year_of_competition ORDER BY SUM(r.difficulty) DESC) AS episode_rank
    FROM 
        competition_episode ce
    JOIN 
        recipe r ON ce.id_recipe = r.id_recipe
    GROUP BY 
        ce.year_of_competition, ce.id_episode
)
SELECT 
    year_of_competition,
    id_episode,
    total_difficulty
FROM 
    ranked_episodes
WHERE 
    episode_rank = 1;















-- QUERY 3.13

SELECT
    ce.id_episode,
    ce.year_of_competition,
    AVG(cl.id_cook_level) AS total_cook_training,
    AVG(j.judge_level) AS total_judge_training,
    (AVG(cl.id_cook_level) + AVG(j.judge_level))/2 AS total_training_score
FROM
    competition_episode ce
JOIN
    cook c ON ce.id_cook = c.id_cook
JOIN
    cook_level cl ON c.id_cook_level = cl.id_cook_level
JOIN
    judges_judge_rating jjr ON ce.id_episode = jjr.id_episode
JOIN
    judge j ON jjr.id_judge = j.id_judge
GROUP BY
    ce.id_episode, ce.year_of_competition
ORDER BY
    total_training_score DESC
LIMIT 1;





















-- QUERY 3.14

WITH ThematicSectionCounts AS (
    SELECT
        ts.thematic_section_name,
        COUNT(ce.id_episode) AS appearance_count
    FROM
        competition_episode ce
        JOIN recipe_thematic_section rts ON ce.id_recipe = rts.id_recipe
        JOIN thematic_section ts ON rts.id_thematic_section = ts.id_thematic_section
    GROUP BY
        ts.thematic_section_name
)
SELECT
    thematic_section_name,
    appearance_count
FROM
    ThematicSectionCounts
ORDER BY
    appearance_count DESC
LIMIT 1;













-- QUERY 3.15

SELECT
    fg.food_group_name
FROM
    food_group fg
WHERE
    fg.id_food_group NOT IN (
        SELECT DISTINCT
            i.id_food_group
        FROM
            competition_episode ce
            JOIN recipe_ingredient ri ON ce.id_recipe = ri.id_recipe
            JOIN ingredients i ON ri.ingredient_name = i.ingredient_name
    );


