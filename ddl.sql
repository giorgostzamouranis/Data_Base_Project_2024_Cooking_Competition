-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: data_base_project_2024
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `competition_episode`
--

DROP TABLE IF EXISTS `competition_episode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competition_episode` (
  `id_episode` int unsigned NOT NULL,
  `year_of_competition` int unsigned DEFAULT NULL,
  `id_cuisine` int unsigned NOT NULL,
  `id_cook` int unsigned NOT NULL,
  `id_recipe` int unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_episode`,`id_cuisine`,`id_cook`,`id_recipe`),
  KEY `idx_competition_episode_recipe` (`id_recipe`),
  KEY `idx_competition_episode_recipe_id` (`id_recipe`),
  KEY `idx_competition_episode_cook_id` (`id_cook`),
  KEY `idx_competition_episode_id` (`id_episode`),
  KEY `idx_competition_episode_year` (`year_of_competition`),
  KEY `idx_competition_episode_cuisine_id` (`id_cuisine`),
  KEY `idx_competition_episode_year_episode` (`year_of_competition`,`id_episode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cook`
--

DROP TABLE IF EXISTS `cook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cook` (
  `id_cook` int unsigned NOT NULL AUTO_INCREMENT,
  `cook_first_name` varchar(50) NOT NULL,
  `cook_last_name` varchar(50) NOT NULL,
  `phone_number` bigint NOT NULL,
  `birth_date` date NOT NULL,
  `age` int DEFAULT NULL,
  `experience` int NOT NULL,
  `id_cook_level` int NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cook`),
  KEY `idx_cook_id` (`id_cook`),
  KEY `idx_cook_age` (`age`),
  KEY `idx_cook_cook_level` (`id_cook_level`),
  CONSTRAINT `cook_ibfk_1` FOREIGN KEY (`id_cook_level`) REFERENCES `cook_level` (`id_cook_level`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_cook_insert` BEFORE INSERT ON `cook` FOR EACH ROW BEGIN
    SET NEW.age = YEAR(CURDATE()) - YEAR(NEW.birth_date);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insert_in_cook_trigger` BEFORE INSERT ON `cook` FOR EACH ROW BEGIN
    DECLARE phone_exists INT;

    
    SELECT COUNT(*) INTO phone_exists 
    FROM cook 
    WHERE phone_number = NEW.phone_number;

    
    IF phone_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Duplicate phone number is not allowed.';
    END IF;

    
    SET NEW.age = YEAR(CURDATE()) - YEAR(NEW.birth_date);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_cook_update` BEFORE UPDATE ON `cook` FOR EACH ROW BEGIN
    SET NEW.age = YEAR(CURDATE()) - YEAR(NEW.birth_date);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_cook_trigger` BEFORE UPDATE ON `cook` FOR EACH ROW BEGIN
    DECLARE phone_exists INT;

    
    SELECT COUNT(*) INTO phone_exists 
    FROM cook 
    WHERE phone_number = NEW.phone_number AND id_cook <> OLD.id_cook;

    
    IF phone_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Duplicate phone number is not allowed.';
    END IF;

    
    SET NEW.age = YEAR(CURDATE()) - YEAR(NEW.birth_date);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cook_expertise`
--

DROP TABLE IF EXISTS `cook_expertise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cook_expertise` (
  `id_cook` int unsigned NOT NULL AUTO_INCREMENT,
  `id_cuisine` int unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cook`,`id_cuisine`),
  KEY `idx_cook_expertise_cook_id` (`id_cook`),
  KEY `idx_cook_expertise_cuisine_id` (`id_cuisine`),
  CONSTRAINT `cook_expertise_ibfk_1` FOREIGN KEY (`id_cook`) REFERENCES `cook` (`id_cook`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cook_expertise_ibfk_2` FOREIGN KEY (`id_cuisine`) REFERENCES `cuisine` (`id_cuisine`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cook_level`
--

DROP TABLE IF EXISTS `cook_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cook_level` (
  `id_cook_level` int NOT NULL,
  `cook_level_title` varchar(50) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cook_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuisine`
--

DROP TABLE IF EXISTS `cuisine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuisine` (
  `id_cuisine` int unsigned NOT NULL AUTO_INCREMENT,
  `cuisine_name` varchar(50) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cuisine`),
  KEY `idx_cuisine_id` (`id_cuisine`),
  KEY `idx_cuisine_name` (`cuisine_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `episode_participation`
--

DROP TABLE IF EXISTS `episode_participation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode_participation` (
  `id_episode` int unsigned NOT NULL,
  `id_cook` int unsigned NOT NULL,
  `id_recipe` int unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_episode`,`id_cook`,`id_recipe`),
  KEY `id_cook` (`id_cook`),
  KEY `id_recipe` (`id_recipe`),
  CONSTRAINT `episode_participation_ibfk_1` FOREIGN KEY (`id_episode`) REFERENCES `competition_episode` (`id_episode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `episode_participation_ibfk_2` FOREIGN KEY (`id_cook`) REFERENCES `cook` (`id_cook`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `episode_participation_ibfk_3` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id_equipment` int unsigned NOT NULL AUTO_INCREMENT,
  `equipment_name` varchar(50) DEFAULT NULL,
  `equipment_manual` varchar(200) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_equipment`),
  UNIQUE KEY `unique_equipment_name` (`equipment_name`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insert_in_equipment_trigger` BEFORE INSERT ON `equipment` FOR EACH ROW BEGIN
    DECLARE equipment_exists INT;

    
    SELECT COUNT(*) INTO equipment_exists 
    FROM equipment 
    WHERE equipment_name = NEW.equipment_name;

    
    IF equipment_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Duplicate equipment name is not allowed.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_equipment_trigger` BEFORE UPDATE ON `equipment` FOR EACH ROW BEGIN
    DECLARE equipment_exists INT;

    
    SELECT COUNT(*) INTO equipment_exists 
    FROM equipment 
    WHERE equipment_name = NEW.equipment_name AND id_equipment <> OLD.id_equipment;

    
    IF equipment_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Duplicate equipment name is not allowed.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `food_group`
--

DROP TABLE IF EXISTS `food_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_group` (
  `id_food_group` int unsigned NOT NULL AUTO_INCREMENT,
  `food_group_name` varchar(50) NOT NULL,
  `food_group_description` varchar(100) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_food_group`),
  KEY `idx_food_group_id` (`id_food_group`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `id_ingredient` int unsigned NOT NULL AUTO_INCREMENT,
  `ingredient_name` varchar(50) NOT NULL,
  `id_food_group` int unsigned NOT NULL,
  `ingredient_calories` int NOT NULL,
  `fat_per_100g` decimal(5,2) NOT NULL,
  `protein_per_100g` decimal(5,2) NOT NULL,
  `carbs_per_100g` decimal(5,2) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_ingredient`),
  UNIQUE KEY `ingredient_name` (`ingredient_name`),
  KEY `idx_ingredients_name` (`ingredient_name`),
  KEY `idx_ingredients_food_group_id` (`id_food_group`),
  CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`id_food_group`) REFERENCES `food_group` (`id_food_group`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `judge`
--

DROP TABLE IF EXISTS `judge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `judge` (
  `id_judge` int unsigned NOT NULL,
  `id_episode` int unsigned NOT NULL,
  `judge_first_name` varchar(50) NOT NULL,
  `judge_last_name` varchar(50) NOT NULL,
  `judge_phone_number` bigint NOT NULL,
  `judge_birth_date` date NOT NULL,
  `judge_age` int DEFAULT NULL,
  `judge_experience` int NOT NULL,
  `judge_level` int NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `year_of_competition` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_episode`,`id_judge`),
  KEY `idx_judge_id` (`id_judge`),
  KEY `idx_judge_year` (`year_of_competition`),
  KEY `idx_judge_episode_id` (`id_episode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_judge_insert` BEFORE INSERT ON `judge` FOR EACH ROW BEGIN
    SET NEW.judge_age = YEAR(CURDATE()) - YEAR(NEW.judge_birth_date);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_judge_update` BEFORE UPDATE ON `judge` FOR EACH ROW BEGIN
    SET NEW.judge_age = YEAR(CURDATE()) - YEAR(NEW.judge_birth_date);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `judge_rating`
--

DROP TABLE IF EXISTS `judge_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `judge_rating` (
  `id_episode` int unsigned NOT NULL,
  `id_cook` int unsigned NOT NULL,
  `judge1_rating` int unsigned DEFAULT NULL,
  `judge2_rating` int unsigned DEFAULT NULL,
  `judge3_rating` int unsigned DEFAULT NULL,
  `total_rating` int GENERATED ALWAYS AS (((`judge1_rating` + `judge2_rating`) + `judge3_rating`)) STORED,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `year_of_competition` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_episode`,`id_cook`),
  KEY `idx_judge_rating_cook_id` (`id_cook`),
  KEY `idx_judge_rating_year` (`year_of_competition`),
  CONSTRAINT `judge_rating_ibfk_1` FOREIGN KEY (`id_episode`) REFERENCES `competition_episode` (`id_episode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `judge_rating_ibfk_2` FOREIGN KEY (`id_cook`) REFERENCES `cook` (`id_cook`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `check_judge1_rating` CHECK ((`judge1_rating` between 1 and 5)),
  CONSTRAINT `check_judge2_rating` CHECK ((`judge2_rating` between 1 and 5)),
  CONSTRAINT `check_judge3_rating` CHECK ((`judge3_rating` between 1 and 5)),
  CONSTRAINT `judge_rating_chk_1` CHECK ((`judge1_rating` between 1 and 5)),
  CONSTRAINT `judge_rating_chk_2` CHECK ((`judge2_rating` between 1 and 5)),
  CONSTRAINT `judge_rating_chk_3` CHECK ((`judge3_rating` between 1 and 5)),
  CONSTRAINT `judge_rating_chk_4` CHECK ((`total_rating` between 3 and 15)),
  CONSTRAINT `judge_rating_chk_5` CHECK ((`judge1_rating` between 1 and 5)),
  CONSTRAINT `judge_rating_chk_6` CHECK ((`judge2_rating` between 1 and 5)),
  CONSTRAINT `judge_rating_chk_7` CHECK ((`judge3_rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `judges_judge_rating`
--

DROP TABLE IF EXISTS `judges_judge_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `judges_judge_rating` (
  `id_episode` int unsigned NOT NULL,
  `id_cook` int unsigned NOT NULL,
  `id_judge` int unsigned NOT NULL,
  `rating_number` int unsigned NOT NULL,
  `rating` int unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `year_of_competition` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_episode`,`id_cook`,`rating_number`),
  KEY `idx_judges_judge_rating_judge` (`id_judge`),
  KEY `idx_judges_judge_rating_cook` (`id_cook`),
  KEY `idx_judges_judge_rating_episode` (`id_episode`),
  CONSTRAINT `judges_judge_rating_ibfk_1` FOREIGN KEY (`id_episode`) REFERENCES `competition_episode` (`id_episode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `judges_judge_rating_ibfk_2` FOREIGN KEY (`id_cook`) REFERENCES `cook` (`id_cook`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `judges_judge_rating_chk_1` CHECK ((`rating_number` between 1 and 3)),
  CONSTRAINT `judges_judge_rating_chk_2` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meal_type`
--

DROP TABLE IF EXISTS `meal_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal_type` (
  `id_meal_type` int unsigned NOT NULL AUTO_INCREMENT,
  `meal_type_name` varchar(50) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_meal_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `id_recipe` int unsigned NOT NULL AUTO_INCREMENT,
  `recipe_name` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `id_cuisine` int unsigned NOT NULL,
  `difficulty` int NOT NULL,
  `recipe_description` varchar(150) DEFAULT NULL,
  `preparation_time` int DEFAULT NULL,
  `execution_time` int NOT NULL,
  `recipe_time` int NOT NULL,
  `tip1` varchar(100) DEFAULT NULL,
  `tip2` varchar(100) DEFAULT NULL,
  `tip3` varchar(100) DEFAULT NULL,
  `servings` int NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_recipe`),
  UNIQUE KEY `recipe_name` (`recipe_name`),
  KEY `fk_constraint_cuisine` (`id_cuisine`),
  KEY `idx_recipe_id` (`id_recipe`),
  CONSTRAINT `fk_constraint_cuisine` FOREIGN KEY (`id_cuisine`) REFERENCES `cuisine` (`id_cuisine`),
  CONSTRAINT `check_id_cuisine` CHECK ((`id_cuisine` between 1 and 20))
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insert_in_recipe_trigger` BEFORE INSERT ON `recipe` FOR EACH ROW BEGIN
    DECLARE recipe_exists INT;

    
    SELECT COUNT(*) INTO recipe_exists 
    FROM recipe 
    WHERE recipe_name = NEW.recipe_name;

    
    IF recipe_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Duplicate recipe name is not allowed.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_recipe_trigger` BEFORE UPDATE ON `recipe` FOR EACH ROW BEGIN
    DECLARE recipe_exists INT;

    
    SELECT COUNT(*) INTO recipe_exists 
    FROM recipe 
    WHERE recipe_name = NEW.recipe_name AND id_recipe <> OLD.id_recipe;

    
    IF recipe_exists > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Duplicate recipe name is not allowed.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `recipe_equipment`
--

DROP TABLE IF EXISTS `recipe_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_equipment` (
  `id_recipe` int unsigned NOT NULL,
  `id_equipment` int unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_recipe`,`id_equipment`),
  KEY `recipe_equipment_ibfk_2` (`id_equipment`),
  KEY `idx_recipe_equipment` (`id_recipe`,`id_equipment`),
  CONSTRAINT `recipe_equipment_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `recipe_equipment_ibfk_2` FOREIGN KEY (`id_equipment`) REFERENCES `equipment` (`id_equipment`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_recipe_equipment_trigger` BEFORE DELETE ON `recipe_equipment` FOR EACH ROW BEGIN
    DECLARE equipment_count INT;
    DECLARE recipe_count INT;

    
    SELECT COUNT(*) INTO equipment_count 
    FROM recipe_equipment 
    WHERE id_equipment = OLD.id_equipment AND id_recipe != OLD.id_recipe;

    
    SELECT COUNT(*) INTO recipe_count 
    FROM recipe_equipment 
    WHERE id_recipe = OLD.id_recipe AND id_equipment != OLD.id_equipment;

    
    IF equipment_count = 0 THEN
        DELETE FROM equipment WHERE id_equipment = OLD.id_equipment;
    END IF;

    
    IF recipe_count = 0 THEN
        DELETE FROM recipe WHERE id_recipe = OLD.id_recipe;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `recipe_ingredient`
--

DROP TABLE IF EXISTS `recipe_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_ingredient` (
  `id_recipe` int unsigned NOT NULL,
  `amount` int NOT NULL,
  `is_main` tinyint(1) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ingredient_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_recipe`,`ingredient_name`),
  KEY `idx_recipe_ingredient_recipe_id` (`id_recipe`),
  KEY `idx_recipe_ingredient_name` (`ingredient_name`),
  CONSTRAINT `recipe_ingredient_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `recipe_ingredient_ibfk_2` FOREIGN KEY (`ingredient_name`) REFERENCES `ingredients` (`ingredient_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `is_main_ingridient_of_recipe` CHECK ((`is_main` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_meal_type`
--

DROP TABLE IF EXISTS `recipe_meal_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_meal_type` (
  `id_recipe` int unsigned NOT NULL AUTO_INCREMENT,
  `id_meal_type` int unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_recipe`,`id_meal_type`),
  KEY `id_meal_type` (`id_meal_type`),
  CONSTRAINT `recipe_meal_type_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `recipe_meal_type_ibfk_2` FOREIGN KEY (`id_meal_type`) REFERENCES `meal_type` (`id_meal_type`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_nutrition`
--

DROP TABLE IF EXISTS `recipe_nutrition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_nutrition` (
  `id_recipe` int unsigned NOT NULL,
  `fat_per_serving` decimal(10,2) DEFAULT NULL,
  `protein_per_serving` decimal(10,2) DEFAULT NULL,
  `carbs_per_serving` decimal(10,2) DEFAULT NULL,
  `calories_per_serving` decimal(10,2) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_recipe`),
  KEY `idx_recipe_nutrition_recipe_id` (`id_recipe`),
  CONSTRAINT `recipe_nutrition_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_tag`
--

DROP TABLE IF EXISTS `recipe_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_tag` (
  `id_recipe` int unsigned NOT NULL AUTO_INCREMENT,
  `id_tag` int unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_recipe`,`id_tag`),
  KEY `idx_recipe_tags_recipe_id` (`id_recipe`),
  KEY `idx_recipe_tags_tag_id` (`id_tag`),
  CONSTRAINT `fk_id_recipe` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_id_tag` FOREIGN KEY (`id_tag`) REFERENCES `tag` (`id_tag`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_thematic_section`
--

DROP TABLE IF EXISTS `recipe_thematic_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_thematic_section` (
  `id_recipe` int unsigned NOT NULL,
  `id_thematic_section` int unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_recipe`,`id_thematic_section`),
  KEY `idx_recipe_thematic_section_thematic_id` (`id_thematic_section`),
  KEY `idx_recipe_thematic_section_recipe_id` (`id_recipe`),
  CONSTRAINT `recipe_thematic_section_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `recipe_thematic_section_ibfk_2` FOREIGN KEY (`id_thematic_section`) REFERENCES `thematic_section` (`id_thematic_section`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `steps`
--

DROP TABLE IF EXISTS `steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `steps` (
  `id_recipe` int unsigned NOT NULL,
  `step_description` varchar(250) NOT NULL,
  `step_number` int NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `id_recipe` (`id_recipe`),
  CONSTRAINT `steps_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id_tag` int unsigned NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(50) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `thematic_section`
--

DROP TABLE IF EXISTS `thematic_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thematic_section` (
  `id_thematic_section` int unsigned NOT NULL,
  `thematic_section_name` varchar(50) NOT NULL,
  `thematic_section_description` varchar(200) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_thematic_section`),
  UNIQUE KEY `thematic_section_name` (`thematic_section_name`),
  KEY `idx_thematic_section_id` (`id_thematic_section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `winner`
--

DROP TABLE IF EXISTS `winner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `winner` (
  `id_episode` int unsigned NOT NULL,
  `id_cook` int unsigned NOT NULL,
  `year_of_competition` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_episode`,`id_cook`),
  KEY `id_cook` (`id_cook`),
  CONSTRAINT `winner_ibfk_1` FOREIGN KEY (`id_episode`) REFERENCES `competition_episode` (`id_episode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `winner_ibfk_2` FOREIGN KEY (`id_cook`) REFERENCES `cook` (`id_cook`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'data_base_project_2024'
--

--
-- Dumping routines for database 'data_base_project_2024'
--
/*!50003 DROP FUNCTION IF EXISTS `CheckConsecutiveAppearances` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CheckConsecutiveAppearances`(entity_id INT, entity_type VARCHAR(10), current_episode INT) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE count_appearances INT;
    
    IF entity_type = 'cook' THEN
        SELECT COUNT(*) INTO count_appearances
        FROM competition_episode
        WHERE id_cook = entity_id AND id_episode BETWEEN current_episode - 3 AND current_episode - 1;
    ELSEIF entity_type = 'recipe' THEN
        SELECT COUNT(*) INTO count_appearances
        FROM competition_episode
        WHERE id_recipe = entity_id AND id_episode BETWEEN current_episode - 3 AND current_episode - 1;
    ELSEIF entity_type = 'cuisine' THEN
        SELECT COUNT(*) INTO count_appearances
        FROM competition_episode
        WHERE id_cuisine = entity_id AND id_episode BETWEEN current_episode - 3 AND current_episode - 1;
    ELSEIF entity_type = 'judge' THEN
        SELECT COUNT(*) INTO count_appearances
        FROM judge
        WHERE id_judge = entity_id AND id_episode BETWEEN current_episode - 3 AND current_episode - 1;
    END IF;

    RETURN count_appearances < 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalculateRecipeNutrition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateRecipeNutrition`(IN recipe_id INT)
BEGIN
    DECLARE total_calories DECIMAL(10, 2) DEFAULT 0;
    DECLARE total_fat DECIMAL(10, 2) DEFAULT 0;
    DECLARE total_protein DECIMAL(10, 2) DEFAULT 0;
    DECLARE total_carbs DECIMAL(10, 2) DEFAULT 0;
    DECLARE total_servings INT DEFAULT 0;

    
    SELECT 
        SUM((ri.amount / 100) * i.ingredient_calories),
        SUM((ri.amount / 100) * i.fat_per_100g),
        SUM((ri.amount / 100) * i.protein_per_100g),
        SUM((ri.amount / 100) * i.carbs_per_100g)
    INTO 
        total_calories, total_fat, total_protein, total_carbs
    FROM 
        recipe_ingredient ri
    JOIN 
        ingredients i ON ri.ingredient_name = i.ingredient_name
    WHERE 
        ri.id_recipe = recipe_id;

    
    SELECT servings INTO total_servings FROM recipe WHERE id_recipe = recipe_id;

    
    SET total_calories = total_calories / total_servings;
    SET total_fat = total_fat / total_servings;
    SET total_protein = total_protein / total_servings;
    SET total_carbs = total_carbs / total_servings;

    
    INSERT INTO recipe_nutrition (id_recipe, fat_per_serving, protein_per_serving, carbs_per_serving, calories_per_serving)
    VALUES (recipe_id, total_fat, total_protein, total_carbs, total_calories)
    ON DUPLICATE KEY UPDATE
        fat_per_serving = VALUES(fat_per_serving),
        protein_per_serving = VALUES(protein_per_serving),
        carbs_per_serving = VALUES(carbs_per_serving),
        calories_per_serving = VALUES(calories_per_serving);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DetermineWinners` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetermineWinners`(IN competitionYear INT)
BEGIN

    SET @competition_year = competitionYear;
    
    CREATE TEMPORARY TABLE temp_winners AS
    SELECT 
        jr.id_episode,
        jr.id_cook,
        jr.total_rating,
        c.id_cook_level
    FROM 
        judge_rating jr
        JOIN cook c ON jr.id_cook = c.id_cook
    WHERE 
        jr.year_of_competition = competitionYear AND (jr.id_episode, jr.total_rating) IN (
            SELECT 
                id_episode, 
                MAX(total_rating)
            FROM 
                judge_rating
            GROUP BY 
                id_episode
        );

    
    CREATE TEMPORARY TABLE temp_winners2 AS
    SELECT 
        jr.id_episode,
        jr.id_cook,
        jr.total_rating,
        c.id_cook_level
    FROM 
        judge_rating jr
        JOIN cook c ON jr.id_cook = c.id_cook
    WHERE 
        jr.year_of_competition = competitionYear AND (jr.id_episode, jr.total_rating) IN (
            SELECT 
                id_episode, 
                MAX(total_rating)
            FROM 
                judge_rating
            GROUP BY 
                id_episode
        );

    
    CREATE TEMPORARY TABLE final_winners AS
    SELECT 
        id_episode,
        id_cook,
        total_rating,
        id_cook_level
    FROM 
        temp_winners
    WHERE 
        (id_episode, id_cook_level) IN (
            SELECT 
                id_episode, 
                MIN(id_cook_level)
            FROM 
                temp_winners2
            GROUP BY 
                id_episode
        );

    
    INSERT INTO winner (id_episode, id_cook, year_of_competition)
    SELECT 
        id_episode, 
        id_cook,
        @competition_year
    FROM 
        (
            SELECT 
                id_episode, 
                id_cook,
                ROW_NUMBER() OVER (PARTITION BY id_episode ORDER BY RAND()) AS row_num
            FROM 
                final_winners
        ) AS ranked_winners
    WHERE 
        row_num = 1;

    
    DROP TEMPORARY TABLE IF EXISTS temp_winners;
    DROP TEMPORARY TABLE IF EXISTS final_winners;
    DROP TEMPORARY TABLE IF EXISTS temp_winners2;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FillJudgeRatings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FillJudgeRatings`()
BEGIN
    
    INSERT INTO judge_rating (id_episode, id_cook, judge1_rating, judge2_rating, judge3_rating, year_of_competition)
    SELECT
        ce.id_episode,
        ce.id_cook,
        FLOOR(1 + RAND() * 5),
        FLOOR(1 + RAND() * 5),
        FLOOR(1 + RAND() * 5),
        ce.year_of_competition
    FROM
        competition_episode ce;

    
    INSERT INTO judges_judge_rating (id_episode, id_cook, id_judge, rating_number, rating, year_of_competition)
    SELECT
        ce.id_episode,
        ce.id_cook,
        j.id_judge,
        rn.rating_number,
        CASE rn.rating_number
            WHEN 1 THEN jr.judge1_rating
            WHEN 2 THEN jr.judge2_rating
            WHEN 3 THEN jr.judge3_rating
        END,
        ce.year_of_competition
    FROM
        competition_episode ce
        JOIN judge j ON ce.id_episode = j.id_episode
        CROSS JOIN (SELECT 1 AS rating_number UNION SELECT 2 UNION SELECT 3) rn
        JOIN judge_rating jr ON ce.id_episode = jr.id_episode AND ce.id_cook = jr.id_cook
    WHERE
        (rn.rating_number = 1 AND j.id_judge = (SELECT id_judge FROM judge WHERE id_episode = ce.id_episode LIMIT 1))
        OR (rn.rating_number = 2 AND j.id_judge = (SELECT id_judge FROM judge WHERE id_episode = ce.id_episode LIMIT 1 OFFSET 1))
        OR (rn.rating_number = 3 AND j.id_judge = (SELECT id_judge FROM judge WHERE id_episode = ce.id_episode LIMIT 1 OFFSET 2));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerateEpisodesForSeasons` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateEpisodesForSeasons`()
BEGIN
    DECLARE ep INT DEFAULT 11;
    DECLARE season_year INT DEFAULT 2025;

    WHILE ep <= 50 DO
        
        SET season_year = 2024 + FLOOR((ep - 1) / 10);

        SET @episode_id = ep;
        
        
        DROP TEMPORARY TABLE IF EXISTS temp_cuisines;
        CREATE TEMPORARY TABLE temp_cuisines AS
        SELECT DISTINCT @episode_id AS episode_id, id_cuisine
        FROM cuisine
        WHERE CheckConsecutiveAppearances(id_cuisine, 'cuisine', @episode_id)
        ORDER BY RAND()
        LIMIT 10;

        
        DROP TEMPORARY TABLE IF EXISTS temp_cooks;
        CREATE TEMPORARY TABLE temp_cooks AS
        SELECT DISTINCT @episode_id AS episode_id, ce.id_cook, ce.id_cuisine
        FROM cook_expertise ce
        JOIN (
            SELECT id_cuisine, MIN(id_cook) AS id_cook
            FROM (
                SELECT ce1.id_cuisine, ce1.id_cook, ROW_NUMBER() OVER (PARTITION BY ce1.id_cuisine ORDER BY RAND()) as rn
                FROM cook_expertise ce1
                WHERE ce1.id_cuisine IN (SELECT id_cuisine FROM temp_cuisines)
                  AND CheckConsecutiveAppearances(ce1.id_cook, 'cook', @episode_id)
            ) as ranked_ce
            WHERE rn = 1
            GROUP BY id_cuisine
        ) as unique_cooks
        ON ce.id_cuisine = unique_cooks.id_cuisine AND ce.id_cook = unique_cooks.id_cook;

        
        DROP TEMPORARY TABLE IF EXISTS temp_recipes;
        CREATE TEMPORARY TABLE temp_recipes AS
        SELECT id_recipe, id_cuisine 
        FROM (
            SELECT r.id_recipe, r.id_cuisine, ROW_NUMBER() OVER (PARTITION BY r.id_cuisine ORDER BY RAND()) as rn
            FROM recipe r
            WHERE r.id_cuisine IN (SELECT id_cuisine FROM temp_cuisines)
              AND CheckConsecutiveAppearances(r.id_recipe, 'recipe', @episode_id)
        ) as ranked_recipes
        WHERE ranked_recipes.rn = 1;

        
        DROP TEMPORARY TABLE IF EXISTS temp_judges;
        CREATE TEMPORARY TABLE temp_judges AS
        SELECT DISTINCT c.id_cook AS id_judge, c.cook_first_name AS judge_first_name, c.cook_last_name AS judge_last_name, c.phone_number AS judge_phone_number, c.birth_date AS judge_birth_date, c.age AS judge_age, c.experience AS judge_experience, c.id_cook_level AS judge_level
        FROM cook c
        WHERE id_cook NOT IN (SELECT id_cook FROM temp_cooks)
          AND CheckConsecutiveAppearances(c.id_cook, 'judge', @episode_id)
        ORDER BY RAND()
        LIMIT 3;

        
        INSERT INTO competition_episode (id_episode, id_cuisine, id_cook, id_recipe)
        SELECT DISTINCT @episode_id, tc.id_cuisine, tc.id_cook, tr.id_recipe
        FROM temp_cooks tc
        JOIN temp_recipes tr ON tc.id_cuisine = tr.id_cuisine;
        
        
        INSERT INTO judge (id_episode, id_judge, judge_first_name, judge_last_name, judge_phone_number, judge_birth_date, judge_age, judge_experience, judge_level)
        SELECT @episode_id, tj.id_judge, tj.judge_first_name, tj.judge_last_name, tj.judge_phone_number, tj.judge_birth_date, tj.judge_age, tj.judge_experience, tj.judge_level
        FROM temp_judges tj;

        
        UPDATE judge
        SET year_of_competition = season_year;
    
        
        UPDATE competition_episode
        SET year_of_competition = season_year;

        
        
        SET ep = ep + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerateEpisodesForYear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateEpisodesForYear`(IN competitionYear INT)
BEGIN
    DECLARE ep INT DEFAULT 1;

    WHILE ep <= 10 DO
        SET @episode_id = ep;
        
        
        DROP TEMPORARY TABLE IF EXISTS temp_cuisines;
        CREATE TEMPORARY TABLE temp_cuisines AS
        SELECT DISTINCT @episode_id AS episode_id, id_cuisine
        FROM cuisine
        WHERE CheckConsecutiveAppearances(id_cuisine, 'cuisine', @episode_id)
        ORDER BY RAND()
        LIMIT 10;

        
        DROP TEMPORARY TABLE IF EXISTS temp_cooks;
        CREATE TEMPORARY TABLE temp_cooks AS
        SELECT DISTINCT @episode_id AS episode_id, ce.id_cook, ce.id_cuisine
        FROM cook_expertise ce
        JOIN (
            SELECT id_cuisine, MIN(id_cook) AS id_cook
            FROM (
                SELECT ce1.id_cuisine, ce1.id_cook, ROW_NUMBER() OVER (PARTITION BY ce1.id_cuisine ORDER BY RAND()) as rn
                FROM cook_expertise ce1
                WHERE ce1.id_cuisine IN (SELECT id_cuisine FROM temp_cuisines)
                  AND CheckConsecutiveAppearances(ce1.id_cook, 'cook', @episode_id)
            ) as ranked_ce
            WHERE rn = 1
            GROUP BY id_cuisine
        ) as unique_cooks
        ON ce.id_cuisine = unique_cooks.id_cuisine AND ce.id_cook = unique_cooks.id_cook;

        
        DROP TEMPORARY TABLE IF EXISTS temp_recipes;
        CREATE TEMPORARY TABLE temp_recipes AS
        SELECT id_recipe, id_cuisine 
        FROM (
            SELECT r.id_recipe, r.id_cuisine, ROW_NUMBER() OVER (PARTITION BY r.id_cuisine ORDER BY RAND()) as rn
            FROM recipe r
            WHERE r.id_cuisine IN (SELECT id_cuisine FROM temp_cuisines)
              AND CheckConsecutiveAppearances(r.id_recipe, 'recipe', @episode_id)
        ) as ranked_recipes
        WHERE ranked_recipes.rn = 1;

        
        DROP TEMPORARY TABLE IF EXISTS temp_judges;
        CREATE TEMPORARY TABLE temp_judges AS
        SELECT DISTINCT c.id_cook AS id_judge, c.cook_first_name AS judge_first_name, c.cook_last_name AS judge_last_name, c.phone_number AS judge_phone_number, c.birth_date AS judge_birth_date, c.age AS judge_age, c.experience AS judge_experience, c.id_cook_level AS judge_level
        FROM cook c
        WHERE id_cook NOT IN (SELECT id_cook FROM temp_cooks)
          AND CheckConsecutiveAppearances(c.id_cook, 'judge', @episode_id)
        ORDER BY RAND()
        LIMIT 3;

        

        
        INSERT INTO judge (id_episode, id_judge, judge_first_name, judge_last_name, judge_phone_number, judge_birth_date, judge_age, judge_experience, judge_level)
        SELECT @episode_id, tj.id_judge, tj.judge_first_name, tj.judge_last_name, tj.judge_phone_number, tj.judge_birth_date, tj.judge_age, tj.judge_experience, tj.judge_level
        FROM temp_judges tj;


        
        UPDATE judge
        SET year_of_competition = competitionYear;
        
        
        SET ep = ep + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateAllRecipesNutrition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAllRecipesNutrition`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE rec_id INT;
    DECLARE cur CURSOR FOR SELECT id_recipe FROM recipe;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO rec_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        CALL CalculateRecipeNutrition(rec_id);
    END LOOP;

    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-26 23:18:14
