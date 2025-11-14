-- MySQL dump 10.13  Distrib 9.5.0, for macos15.4 (arm64)
--
-- Host: localhost    Database: exercise_tracker
-- ------------------------------------------------------
-- Server version	9.5.0
-- Complete test data for Exercise Tracker Application
-- Demo Date: November 18, 2025
-- 11 users with 283 exercise records across 14 days

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password_hash` varchar(100) NOT NULL,
  `username` varchar(32) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_users_username` (`username`),
  UNIQUE KEY `uk_users_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
-- All users have password: 123
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(4,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','john_doe','1292732a-c0d8-11f0-9ddf-b6be97b7cfe8'),
(5,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','sarah_smith','12928356-c0d8-11f0-9ddf-b6be97b7cfe8'),
(6,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','mike_johnson','12928630-c0d8-11f0-9ddf-b6be97b7cfe8'),
(7,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','emily_davis','12928716-c0d8-11f0-9ddf-b6be97b7cfe8'),
(8,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','david_wilson','129287a2-c0d8-11f0-9ddf-b6be97b7cfe8'),
(9,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','lisa_brown','1292882e-c0d8-11f0-9ddf-b6be97b7cfe8'),
(10,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','james_taylor','129288a6-c0d8-11f0-9ddf-b6be97b7cfe8'),
(11,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','amanda_white','12928914-c0d8-11f0-9ddf-b6be97b7cfe8'),
(12,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','chris_martin','1292898c-c0d8-11f0-9ddf-b6be97b7cfe8'),
(13,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','jennifer_lee','12928a04-c0d8-11f0-9ddf-b6be97b7cfe8'),
(24,'$2b$10$b0/MG/FFeZszLKqxBKrWkec6QtqKxor9U5ofWkVn88Wy2F9ftFRDG','allen','f3c80772-c0da-11f0-9ddf-b6be97b7cfe8');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercises`
--

DROP TABLE IF EXISTS `exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercises` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `duration_minutes` int NOT NULL,
  `location` varchar(128) DEFAULT NULL,
  `occurred_at` datetime(6) NOT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `type` enum('CYCLE','GYM','OTHER','RUN','SWIM','WALK') NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_exercises_user_time` (`user_id`,`occurred_at`),
  CONSTRAINT `exercises_chk_1` CHECK ((`duration_minutes` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercises`
-- Demo Date: November 18, 2025
-- Total: 283 records for 11 users across 14 days (Nov 4-17)
--

LOCK TABLES `exercises` WRITE;
/*!40000 ALTER TABLE `exercises` DISABLE KEYS */;
INSERT INTO `exercises` VALUES
-- ============================================================
-- ALLEN (user_id=24) - EXEMPLARY USER WITH VARIED TIME PERIODS
-- Shows morning (7-9am), afternoon (2-4pm), evening (6-8pm) exercises
-- Demonstrates different exercise types, durations, and realistic patterns
-- 27 records across 14 days (morning/afternoon/evening variety)
-- ============================================================

-- Nov 17 (1 day ago) - Morning run + evening gym
(1,45,'Central Park, NYC','2025-11-17 07:30:00.000000','America/New_York','RUN',24),
(2,50,'Equinox Gym','2025-11-17 18:45:00.000000','America/New_York','GYM',24),

-- Nov 16 (2 days ago) - Afternoon cycle + evening walk
(3,60,'Hudson River Greenway','2025-11-16 14:15:00.000000','America/New_York','CYCLE',24),
(4,30,'Brooklyn Heights Promenade','2025-11-16 19:00:00.000000','America/New_York','WALK',24),

-- Nov 15 (3 days ago) - Morning swim + evening walk
(5,40,'YMCA Pool','2025-11-15 08:00:00.000000','America/New_York','SWIM',24),
(6,25,'Brooklyn Bridge','2025-11-15 19:30:00.000000','America/New_York','WALK',24),

-- Nov 14 (4 days ago) - Morning run + afternoon gym
(7,35,'Prospect Park','2025-11-14 07:00:00.000000','America/New_York','RUN',24),
(8,55,'Planet Fitness','2025-11-14 15:30:00.000000','America/New_York','GYM',24),

-- Nov 13 (5 days ago) - Afternoon other activity
(9,35,'Tennis Court NYC','2025-11-13 14:30:00.000000','America/New_York','OTHER',24),

-- Nov 12 (6 days ago) - Morning walk + evening gym
(10,30,'Battery Park','2025-11-12 08:00:00.000000','America/New_York','WALK',24),
(11,45,'Equinox Gym','2025-11-12 18:00:00.000000','America/New_York','GYM',24),

-- Nov 11 (7 days ago) - Morning run + afternoon walk + evening cycle
(12,50,'Central Park, NYC','2025-11-11 07:45:00.000000','America/New_York','RUN',24),
(13,30,'High Line Park','2025-11-11 14:00:00.000000','America/New_York','WALK',24),
(14,40,'Hudson River Path','2025-11-11 19:15:00.000000','America/New_York','CYCLE',24),

-- Nov 10 (8 days ago) - Morning swim + evening cycle
(15,35,'YMCA Pool','2025-11-10 08:15:00.000000','America/New_York','SWIM',24),
(16,55,'East River Path','2025-11-10 19:00:00.000000','America/New_York','CYCLE',24),

-- Nov 9 (9 days ago) - Afternoon gym + evening other
(17,60,'Planet Fitness','2025-11-09 15:00:00.000000','America/New_York','GYM',24),
(18,30,'Yoga Studio NYC','2025-11-09 19:30:00.000000','America/New_York','OTHER',24),

-- Nov 8 (10 days ago) - Morning run + afternoon swim
(19,40,'Riverside Park','2025-11-08 07:30:00.000000','America/New_York','RUN',24),
(20,35,'Chelsea Piers Pool','2025-11-08 14:00:00.000000','America/New_York','SWIM',24),

-- Nov 7 (11 days ago) - REST DAY

-- Nov 6 (12 days ago) - Morning walk + afternoon cycle + evening gym
(21,25,'Battery Park','2025-11-06 08:30:00.000000','America/New_York','WALK',24),
(22,45,'Hudson River Greenway','2025-11-06 14:30:00.000000','America/New_York','CYCLE',24),
(23,50,'Equinox Gym','2025-11-06 18:30:00.000000','America/New_York','GYM',24),

-- Nov 5 (13 days ago) - Morning swim + afternoon cycle
(24,45,'Chelsea Piers Pool','2025-11-05 07:00:00.000000','America/New_York','SWIM',24),
(25,65,'Hudson River Greenway','2025-11-05 14:30:00.000000','America/New_York','CYCLE',24),

-- Nov 4 (14 days ago) - Morning run + evening other
(26,35,'Central Park, NYC','2025-11-04 07:15:00.000000','America/New_York','RUN',24),
(27,30,'Yoga Studio NYC','2025-11-04 19:00:00.000000','America/New_York','OTHER',24),

-- ============================================================
-- SARAH_SMITH (user_id=5) - Active user (last: Nov 17)
-- California timezone, prefers walking and swimming
-- 30 records across 14 days
-- ============================================================

-- Nov 17
(28,30,'Santa Monica Beach','2025-11-17 08:00:00.000000','America/Los_Angeles','WALK',5),
(29,35,'LA Fitness Pool','2025-11-17 17:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 16
(30,40,'Griffith Park','2025-11-16 07:30:00.000000','America/Los_Angeles','WALK',5),
(31,30,'24 Hour Fitness Pool','2025-11-16 18:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 15
(32,25,'Venice Beach','2025-11-15 08:30:00.000000','America/Los_Angeles','WALK',5),
(33,45,'YMCA Pool','2025-11-15 16:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 14
(34,35,'Runyon Canyon','2025-11-14 07:00:00.000000','America/Los_Angeles','WALK',5),
(35,40,'YMCA Pool','2025-11-14 17:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 13
(36,40,'Santa Monica Pier','2025-11-13 08:00:00.000000','America/Los_Angeles','WALK',5),
(37,30,'LA Fitness Pool','2025-11-13 17:30:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 12
(38,35,'Malibu Beach','2025-11-12 09:00:00.000000','America/Los_Angeles','WALK',5),
(39,35,'Community Pool','2025-11-12 16:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 11
(40,30,'Echo Park','2025-11-11 07:30:00.000000','America/Los_Angeles','WALK',5),
(41,40,'Community Pool','2025-11-11 16:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 10
(42,25,'Beverly Gardens Park','2025-11-10 08:00:00.000000','America/Los_Angeles','WALK',5),
(43,35,'24 Hour Fitness Pool','2025-11-10 17:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 9
(44,40,'Topanga State Park','2025-11-09 07:00:00.000000','America/Los_Angeles','WALK',5),
(45,30,'LA Fitness Pool','2025-11-09 17:00:00.000000','America/Los_Angeles','SWIM',5),
(46,20,'Muscle Beach','2025-11-09 12:00:00.000000','America/Los_Angeles','OTHER',5),

-- Nov 8
(47,30,'Santa Monica Beach','2025-11-08 08:30:00.000000','America/Los_Angeles','WALK',5),
(48,35,'LA Fitness Pool','2025-11-08 17:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 7
(49,25,'Venice Canals','2025-11-07 09:00:00.000000','America/Los_Angeles','WALK',5),
(50,40,'YMCA Pool','2025-11-07 16:30:00.000000','America/Los_Angeles','SWIM',5),
(51,20,'Santa Monica Stairs','2025-11-07 12:00:00.000000','America/Los_Angeles','OTHER',5),

-- Nov 6
(52,35,'Griffith Park','2025-11-06 07:30:00.000000','America/Los_Angeles','WALK',5),
(53,40,'YMCA Pool','2025-11-06 16:30:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 5
(54,30,'Runyon Canyon','2025-11-05 08:00:00.000000','America/Los_Angeles','WALK',5),
(55,35,'Community Pool','2025-11-05 17:00:00.000000','America/Los_Angeles','SWIM',5),

-- Nov 4
(56,35,'Santa Monica Pier','2025-11-04 07:00:00.000000','America/Los_Angeles','WALK',5),
(57,30,'Community Pool','2025-11-04 17:00:00.000000','America/Los_Angeles','SWIM',5),

-- ============================================================
-- EMILY_DAVIS (user_id=7) - Active user (last: Nov 17)
-- London timezone, balanced workout routine
-- 30 records across 14 days
-- ============================================================

-- Nov 17
(58,35,'Hyde Park','2025-11-17 07:00:00.000000','Europe/London','WALK',7),
(59,45,'Virgin Active Gym','2025-11-17 18:00:00.000000','Europe/London','GYM',7),

-- Nov 16
(60,30,'Regent\'s Park','2025-11-16 07:30:00.000000','Europe/London','WALK',7),
(61,40,'David Lloyd Pool','2025-11-16 17:00:00.000000','Europe/London','SWIM',7),

-- Nov 15
(62,40,'Richmond Park','2025-11-15 08:00:00.000000','Europe/London','RUN',7),
(63,35,'PureGym','2025-11-15 18:30:00.000000','Europe/London','GYM',7),

-- Nov 14
(64,25,'Hampstead Heath','2025-11-14 07:00:00.000000','Europe/London','WALK',7),
(65,50,'Virgin Active Gym','2025-11-14 18:00:00.000000','Europe/London','GYM',7),

-- Nov 13
(66,45,'Virgin Active Gym','2025-11-13 18:00:00.000000','Europe/London','GYM',7),
(67,30,'Thames Path','2025-11-13 12:00:00.000000','Europe/London','WALK',7),

-- Nov 12
(68,35,'Victoria Park','2025-11-12 07:30:00.000000','Europe/London','RUN',7),
(69,40,'David Lloyd Pool','2025-11-12 17:00:00.000000','Europe/London','SWIM',7),

-- Nov 11
(70,40,'David Lloyd Pool','2025-11-11 17:00:00.000000','Europe/London','SWIM',7),
(71,25,'Hyde Park','2025-11-11 08:00:00.000000','Europe/London','WALK',7),

-- Nov 10
(72,50,'PureGym','2025-11-10 18:00:00.000000','Europe/London','GYM',7),
(73,30,'Regent\'s Park','2025-11-10 07:30:00.000000','Europe/London','WALK',7),

-- Nov 9
(74,30,'Regent\'s Park','2025-11-09 07:00:00.000000','Europe/London','WALK',7),
(75,40,'Virgin Active Gym','2025-11-09 17:30:00.000000','Europe/London','GYM',7),
(76,35,'Battersea Park','2025-11-09 12:00:00.000000','Europe/London','CYCLE',7),

-- Nov 8
(77,35,'Richmond Park','2025-11-08 08:00:00.000000','Europe/London','RUN',7),
(78,45,'PureGym','2025-11-08 18:00:00.000000','Europe/London','GYM',7),

-- Nov 7
(79,30,'Hampstead Heath','2025-11-07 07:30:00.000000','Europe/London','WALK',7),
(80,40,'David Lloyd Pool','2025-11-07 17:00:00.000000','Europe/London','SWIM',7),
(81,20,'Greenwich Park','2025-11-07 12:00:00.000000','Europe/London','WALK',7),

-- Nov 6
(82,45,'PureGym','2025-11-06 18:00:00.000000','Europe/London','GYM',7),
(83,25,'Thames Path','2025-11-06 07:00:00.000000','Europe/London','WALK',7),

-- Nov 5
(84,35,'Victoria Park','2025-11-05 07:00:00.000000','Europe/London','RUN',7),
(85,25,'Thames Path','2025-11-05 12:00:00.000000','Europe/London','WALK',7),

-- Nov 4
(86,40,'Virgin Active Gym','2025-11-04 18:00:00.000000','Europe/London','GYM',7),
(87,30,'Hyde Park','2025-11-04 07:30:00.000000','Europe/London','WALK',7),

-- ============================================================
-- LISA_BROWN (user_id=9) - Active user (last: Nov 17)
-- Tokyo timezone, gym enthusiast
-- 30 records across 14 days
-- ============================================================

-- Nov 17
(88,60,'Konami Sports Club','2025-11-17 06:30:00.000000','Asia/Tokyo','GYM',9),
(89,35,'Yoyogi Park','2025-11-17 18:00:00.000000','Asia/Tokyo','WALK',9),

-- Nov 16
(90,55,'Gold\'s Gym Tokyo','2025-11-16 07:00:00.000000','Asia/Tokyo','GYM',9),
(91,30,'Imperial Palace','2025-11-16 17:30:00.000000','Asia/Tokyo','RUN',9),

-- Nov 15
(92,50,'Tipness Gym','2025-11-15 06:00:00.000000','Asia/Tokyo','GYM',9),
(93,40,'Sumida River Path','2025-11-15 18:00:00.000000','Asia/Tokyo','CYCLE',9),

-- Nov 14
(94,60,'Konami Sports Club','2025-11-14 06:30:00.000000','Asia/Tokyo','GYM',9),
(95,35,'Ueno Park','2025-11-14 17:00:00.000000','Asia/Tokyo','WALK',9),

-- Nov 13
(96,55,'Gold\'s Gym Tokyo','2025-11-13 07:00:00.000000','Asia/Tokyo','GYM',9),
(97,35,'Ueno Park','2025-11-13 17:00:00.000000','Asia/Tokyo','WALK',9),

-- Nov 12
(98,50,'Tipness Gym','2025-11-12 06:00:00.000000','Asia/Tokyo','GYM',9),
(99,30,'Imperial Palace','2025-11-12 17:30:00.000000','Asia/Tokyo','RUN',9),

-- Nov 11
(100,60,'Konami Sports Club','2025-11-11 06:30:00.000000','Asia/Tokyo','GYM',9),
(101,30,'Imperial Palace','2025-11-11 18:00:00.000000','Asia/Tokyo','RUN',9),

-- Nov 10
(102,55,'Gold\'s Gym Tokyo','2025-11-10 07:00:00.000000','Asia/Tokyo','GYM',9),
(103,40,'Sumida River Path','2025-11-10 18:00:00.000000','Asia/Tokyo','CYCLE',9),

-- Nov 9
(104,50,'Tipness Gym','2025-11-09 06:00:00.000000','Asia/Tokyo','GYM',9),
(105,35,'Yoyogi Park','2025-11-09 17:30:00.000000','Asia/Tokyo','WALK',9),
(106,20,'Shibuya Park','2025-11-09 12:00:00.000000','Asia/Tokyo','OTHER',9),

-- Nov 8
(107,60,'Konami Sports Club','2025-11-08 06:30:00.000000','Asia/Tokyo','GYM',9),
(108,30,'Imperial Palace','2025-11-08 17:30:00.000000','Asia/Tokyo','RUN',9),

-- Nov 7
(109,55,'Gold\'s Gym Tokyo','2025-11-07 07:00:00.000000','Asia/Tokyo','GYM',9),
(110,40,'Sumida River Path','2025-11-07 18:00:00.000000','Asia/Tokyo','CYCLE',9),
(111,20,'Shinjuku Gyoen','2025-11-07 12:00:00.000000','Asia/Tokyo','WALK',9),

-- Nov 6
(112,50,'Tipness Gym','2025-11-06 06:00:00.000000','Asia/Tokyo','GYM',9),
(113,35,'Yoyogi Park','2025-11-06 17:30:00.000000','Asia/Tokyo','WALK',9),

-- Nov 5
(114,60,'Konami Sports Club','2025-11-05 06:30:00.000000','Asia/Tokyo','GYM',9),
(115,30,'Imperial Palace','2025-11-05 17:00:00.000000','Asia/Tokyo','RUN',9),

-- Nov 4
(116,55,'Gold\'s Gym Tokyo','2025-11-04 07:00:00.000000','Asia/Tokyo','GYM',9),
(117,40,'Sumida River Path','2025-11-04 18:00:00.000000','Asia/Tokyo','CYCLE',9),

-- ============================================================
-- JAMES_TAYLOR (user_id=10) - Active user (last: Nov 17)
-- Sydney timezone, cycling enthusiast
-- 30 records across 14 days
-- ============================================================

-- Nov 17
(118,90,'Sydney Harbour Bridge Loop','2025-11-17 06:00:00.000000','Australia/Sydney','CYCLE',10),
(119,45,'Fitness First','2025-11-17 17:00:00.000000','Australia/Sydney','GYM',10),

-- Nov 16
(120,85,'Centennial Park','2025-11-16 06:30:00.000000','Australia/Sydney','CYCLE',10),
(121,40,'Bondi Beach','2025-11-16 17:30:00.000000','Australia/Sydney','WALK',10),

-- Nov 15
(122,95,'Bay Run','2025-11-15 06:00:00.000000','Australia/Sydney','CYCLE',10),
(123,50,'Anytime Fitness','2025-11-15 18:00:00.000000','Australia/Sydney','GYM',10),

-- Nov 14
(124,80,'Manly to Spit','2025-11-14 07:00:00.000000','Australia/Sydney','CYCLE',10),
(125,45,'Fitness First','2025-11-14 17:00:00.000000','Australia/Sydney','GYM',10),

-- Nov 13
(126,90,'Parramatta River Loop','2025-11-13 06:00:00.000000','Australia/Sydney','CYCLE',10),
(127,45,'Fitness First','2025-11-13 17:00:00.000000','Australia/Sydney','GYM',10),

-- Nov 12
(128,85,'Lane Cove River','2025-11-12 06:30:00.000000','Australia/Sydney','CYCLE',10),
(129,40,'Coogee Beach','2025-11-12 17:30:00.000000','Australia/Sydney','WALK',10),

-- Nov 11
(130,75,'Sydney Olympic Park','2025-11-11 07:00:00.000000','Australia/Sydney','CYCLE',10),
(131,40,'Coogee Beach','2025-11-11 17:00:00.000000','Australia/Sydney','WALK',10),

-- Nov 10
(132,90,'Harbour Bridge Loop','2025-11-10 06:00:00.000000','Australia/Sydney','CYCLE',10),
(133,50,'Anytime Fitness','2025-11-10 18:00:00.000000','Australia/Sydney','GYM',10),

-- Nov 9
(134,85,'Centennial Park','2025-11-09 06:30:00.000000','Australia/Sydney','CYCLE',10),
(135,50,'Anytime Fitness','2025-11-09 18:00:00.000000','Australia/Sydney','GYM',10),
(136,30,'Manly Beach','2025-11-09 12:00:00.000000','Australia/Sydney','SWIM',10),

-- Nov 8
(137,80,'Bay Run','2025-11-08 07:00:00.000000','Australia/Sydney','CYCLE',10),
(138,40,'Bondi Beach','2025-11-08 17:30:00.000000','Australia/Sydney','WALK',10),

-- Nov 7
(139,90,'Manly to Spit','2025-11-07 06:00:00.000000','Australia/Sydney','CYCLE',10),
(140,45,'Fitness First','2025-11-07 17:00:00.000000','Australia/Sydney','GYM',10),
(141,25,'Bronte Beach','2025-11-07 12:00:00.000000','Australia/Sydney','SWIM',10),

-- Nov 6
(142,85,'Parramatta River Loop','2025-11-06 06:30:00.000000','Australia/Sydney','CYCLE',10),
(143,40,'Coogee Beach','2025-11-06 17:30:00.000000','Australia/Sydney','WALK',10),

-- Nov 5
(144,75,'Lane Cove River','2025-11-05 07:00:00.000000','Australia/Sydney','CYCLE',10),
(145,40,'Bondi Beach','2025-11-05 17:00:00.000000','Australia/Sydney','WALK',10),

-- Nov 4
(146,90,'Sydney Olympic Park','2025-11-04 06:00:00.000000','Australia/Sydney','CYCLE',10),
(147,50,'Anytime Fitness','2025-11-04 18:00:00.000000','Australia/Sydney','GYM',10),

-- ============================================================
-- CHRIS_MARTIN (user_id=12) - Active user (last: Nov 17)
-- Denver timezone, running enthusiast
-- 30 records across 14 days
-- ============================================================

-- Nov 17
(148,45,'Cherry Creek Trail','2025-11-17 07:00:00.000000','America/Denver','RUN',12),
(149,35,'City Park','2025-11-17 17:00:00.000000','America/Denver','WALK',12),

-- Nov 16
(150,50,'Washington Park Loop','2025-11-16 06:30:00.000000','America/Denver','RUN',12),
(151,40,'24 Hour Fitness','2025-11-16 18:00:00.000000','America/Denver','GYM',12),

-- Nov 15
(152,55,'Bear Creek Trail','2025-11-15 07:00:00.000000','America/Denver','RUN',12),
(153,30,'Sloan\'s Lake','2025-11-15 17:30:00.000000','America/Denver','WALK',12),

-- Nov 14
(154,40,'Highline Canal','2025-11-14 06:30:00.000000','America/Denver','RUN',12),
(155,45,'LA Fitness','2025-11-14 18:00:00.000000','America/Denver','GYM',12),

-- Nov 13
(156,50,'Cherry Creek Trail','2025-11-13 07:00:00.000000','America/Denver','RUN',12),
(157,45,'LA Fitness','2025-11-13 18:00:00.000000','America/Denver','GYM',12),

-- Nov 12
(158,45,'Washington Park Loop','2025-11-12 06:30:00.000000','America/Denver','RUN',12),
(159,35,'City Park','2025-11-12 17:00:00.000000','America/Denver','WALK',12),

-- Nov 11
(160,55,'Bear Creek Trail','2025-11-11 07:00:00.000000','America/Denver','RUN',12),
(161,35,'City Park','2025-11-11 17:00:00.000000','America/Denver','WALK',12),

-- Nov 10
(162,40,'Highline Canal','2025-11-10 06:30:00.000000','America/Denver','RUN',12),
(163,40,'24 Hour Fitness','2025-11-10 18:00:00.000000','America/Denver','GYM',12),

-- Nov 9
(164,50,'Cherry Creek Trail','2025-11-09 07:00:00.000000','America/Denver','RUN',12),
(165,40,'24 Hour Fitness','2025-11-09 18:00:00.000000','America/Denver','GYM',12),
(166,25,'Red Rocks Park','2025-11-09 12:00:00.000000','America/Denver','OTHER',12),

-- Nov 8
(167,45,'Washington Park Loop','2025-11-08 06:30:00.000000','America/Denver','RUN',12),
(168,30,'Sloan\'s Lake','2025-11-08 17:30:00.000000','America/Denver','WALK',12),

-- Nov 7
(169,55,'Bear Creek Trail','2025-11-07 07:00:00.000000','America/Denver','RUN',12),
(170,30,'Sloan\'s Lake','2025-11-07 17:30:00.000000','America/Denver','WALK',12),
(171,20,'Rocky Mountain Trail','2025-11-07 12:00:00.000000','America/Denver','OTHER',12),

-- Nov 6
(172,40,'Highline Canal','2025-11-06 06:30:00.000000','America/Denver','RUN',12),
(173,45,'LA Fitness','2025-11-06 18:00:00.000000','America/Denver','GYM',12),

-- Nov 5
(174,50,'Cherry Creek Trail','2025-11-05 07:00:00.000000','America/Denver','RUN',12),
(175,45,'LA Fitness','2025-11-05 18:00:00.000000','America/Denver','GYM',12),

-- Nov 4
(176,45,'Washington Park Loop','2025-11-04 06:30:00.000000','America/Denver','RUN',12),
(177,35,'City Park','2025-11-04 17:00:00.000000','America/Denver','WALK',12),

-- ============================================================
-- JENNIFER_LEE (user_id=13) - Active user (last: Nov 17)
-- Hong Kong timezone, mixed workouts
-- 30 records across 14 days
-- ============================================================

-- Nov 17
(178,40,'Victoria Peak Trail','2025-11-17 06:30:00.000000','Asia/Hong_Kong','OTHER',13),
(179,35,'Tsim Sha Tsui Promenade','2025-11-17 18:00:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 16
(180,50,'Pure Fitness','2025-11-16 07:00:00.000000','Asia/Hong_Kong','GYM',13),
(181,25,'Kowloon Park','2025-11-16 17:00:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 15
(182,45,'Dragon\'s Back Trail','2025-11-15 06:00:00.000000','Asia/Hong_Kong','OTHER',13),
(183,40,'Fitness First','2025-11-15 18:00:00.000000','Asia/Hong_Kong','GYM',13),

-- Nov 14
(184,30,'Hong Kong Park','2025-11-14 07:00:00.000000','Asia/Hong_Kong','WALK',13),
(185,50,'Pure Fitness','2025-11-14 18:00:00.000000','Asia/Hong_Kong','GYM',13),

-- Nov 13
(186,50,'Pure Fitness','2025-11-13 06:30:00.000000','Asia/Hong_Kong','GYM',13),
(187,35,'Avenue of Stars','2025-11-13 17:30:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 12
(188,40,'Lion Rock Trail','2025-11-12 06:00:00.000000','Asia/Hong_Kong','OTHER',13),
(189,25,'Victoria Harbour','2025-11-12 18:00:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 11
(190,45,'Fitness First','2025-11-11 07:00:00.000000','Asia/Hong_Kong','GYM',13),
(191,25,'Victoria Harbour','2025-11-11 18:00:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 10
(192,50,'Pure Fitness','2025-11-10 06:30:00.000000','Asia/Hong_Kong','GYM',13),
(193,30,'Kowloon Park','2025-11-10 17:00:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 9
(194,40,'Lantau Trail','2025-11-09 06:00:00.000000','Asia/Hong_Kong','OTHER',13),
(195,30,'Kowloon Park','2025-11-09 17:00:00.000000','Asia/Hong_Kong','WALK',13),
(196,25,'Ocean Park','2025-11-09 12:00:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 8
(197,45,'Fitness First','2025-11-08 07:00:00.000000','Asia/Hong_Kong','GYM',13),
(198,35,'Avenue of Stars','2025-11-08 17:30:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 7
(199,35,'Hong Kong Park','2025-11-07 06:30:00.000000','Asia/Hong_Kong','WALK',13),
(200,50,'Pure Fitness','2025-11-07 18:00:00.000000','Asia/Hong_Kong','GYM',13),
(201,20,'Repulse Bay','2025-11-07 12:00:00.000000','Asia/Hong_Kong','SWIM',13),

-- Nov 6
(202,40,'Victoria Peak Trail','2025-11-06 06:00:00.000000','Asia/Hong_Kong','OTHER',13),
(203,25,'Tsim Sha Tsui Promenade','2025-11-06 18:00:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 5
(204,45,'Fitness First','2025-11-05 07:00:00.000000','Asia/Hong_Kong','GYM',13),
(205,25,'Tsim Sha Tsui Promenade','2025-11-05 17:30:00.000000','Asia/Hong_Kong','WALK',13),

-- Nov 4
(206,50,'Pure Fitness','2025-11-04 06:30:00.000000','Asia/Hong_Kong','GYM',13),
(207,30,'Hong Kong Park','2025-11-04 17:00:00.000000','Asia/Hong_Kong','WALK',13),

-- ============================================================
-- JOHN_DOE (user_id=4) - WARNING USER (last: Nov 15, 3 days gap)
-- Chicago timezone, moderate activity with some gaps
-- 27 records across 14 days
-- ============================================================

-- Nov 15 (3 days ago - last exercise)
(208,40,'Lakefront Trail','2025-11-15 07:00:00.000000','America/Chicago','RUN',4),
(209,30,'Lincoln Park','2025-11-15 17:00:00.000000','America/Chicago','WALK',4),

-- Nov 14
(210,35,'Chicago Riverwalk','2025-11-14 08:00:00.000000','America/Chicago','WALK',4),
(211,45,'LA Fitness','2025-11-14 18:00:00.000000','America/Chicago','GYM',4),

-- Nov 13
(212,50,'LA Fitness','2025-11-13 18:00:00.000000','America/Chicago','GYM',4),
(213,25,'Millennium Park','2025-11-13 12:00:00.000000','America/Chicago','WALK',4),

-- Nov 12
(214,45,'Lakefront Trail','2025-11-12 07:00:00.000000','America/Chicago','RUN',4),
(215,30,'Navy Pier','2025-11-12 17:00:00.000000','America/Chicago','WALK',4),

-- Nov 11
(216,30,'Millennium Park','2025-11-11 12:00:00.000000','America/Chicago','WALK',4),
(217,40,'LA Fitness','2025-11-11 18:00:00.000000','America/Chicago','GYM',4),

-- Nov 10
(218,40,'LA Fitness','2025-11-10 18:00:00.000000','America/Chicago','GYM',4),
(219,35,'Lakefront Trail','2025-11-10 07:00:00.000000','America/Chicago','RUN',4),

-- Nov 9
(220,35,'Lakefront Trail','2025-11-09 07:00:00.000000','America/Chicago','RUN',4),
(221,25,'Grant Park','2025-11-09 17:00:00.000000','America/Chicago','WALK',4),
(222,30,'Navy Pier','2025-11-09 12:00:00.000000','America/Chicago','WALK',4),

-- Nov 8
(223,25,'Grant Park','2025-11-08 08:00:00.000000','America/Chicago','WALK',4),
(224,50,'LA Fitness','2025-11-08 18:00:00.000000','America/Chicago','GYM',4),

-- Nov 7
(225,50,'LA Fitness','2025-11-07 18:00:00.000000','America/Chicago','GYM',4),
(226,20,'Millennium Park','2025-11-07 12:00:00.000000','America/Chicago','WALK',4),

-- Nov 6 - GAP

-- Nov 5
(227,40,'Lakefront Trail','2025-11-05 07:00:00.000000','America/Chicago','RUN',4),
(228,30,'Navy Pier','2025-11-05 17:00:00.000000','America/Chicago','WALK',4),

-- Nov 4
(229,35,'Chicago Riverwalk','2025-11-04 08:00:00.000000','America/Chicago','WALK',4),
(230,40,'LA Fitness','2025-11-04 18:00:00.000000','America/Chicago','GYM',4),

-- ============================================================
-- DAVID_WILSON (user_id=8) - WARNING USER (last: Nov 15, 3 days gap)
-- Paris timezone, swimming focus with gaps
-- 25 records across 14 days
-- ============================================================

-- Nov 15 (3 days ago - last exercise)
(231,40,'Piscine Pontoise','2025-11-15 07:00:00.000000','Europe/Paris','SWIM',8),
(232,30,'Jardin du Luxembourg','2025-11-15 17:00:00.000000','Europe/Paris','WALK',8),

-- Nov 14
(233,35,'Piscine Georges Vallerey','2025-11-14 08:00:00.000000','Europe/Paris','SWIM',8),
(234,25,'Tuileries Garden','2025-11-14 12:00:00.000000','Europe/Paris','WALK',8),

-- Nov 13
(235,40,'Seine River Path','2025-11-13 12:00:00.000000','Europe/Paris','WALK',8),
(236,35,'Piscine Pontoise','2025-11-13 18:00:00.000000','Europe/Paris','SWIM',8),

-- Nov 12
(237,35,'Piscine Pontoise','2025-11-12 07:00:00.000000','Europe/Paris','SWIM',8),
(238,25,'Champ de Mars','2025-11-12 18:00:00.000000','Europe/Paris','WALK',8),

-- Nov 11
(239,25,'Champ de Mars','2025-11-11 18:00:00.000000','Europe/Paris','WALK',8),
(240,40,'Piscine Georges Vallerey','2025-11-11 07:30:00.000000','Europe/Paris','SWIM',8),

-- Nov 10 - GAP

-- Nov 9
(241,40,'Piscine Georges Vallerey','2025-11-09 08:00:00.000000','Europe/Paris','SWIM',8),
(242,30,'Jardin du Luxembourg','2025-11-09 17:00:00.000000','Europe/Paris','WALK',8),
(243,25,'Eiffel Tower Area','2025-11-09 12:00:00.000000','Europe/Paris','WALK',8),

-- Nov 8
(244,30,'Tuileries Garden','2025-11-08 12:00:00.000000','Europe/Paris','WALK',8),
(245,35,'Piscine Pontoise','2025-11-08 18:00:00.000000','Europe/Paris','SWIM',8),

-- Nov 7
(246,35,'Piscine Pontoise','2025-11-07 07:00:00.000000','Europe/Paris','SWIM',8),
(247,25,'Seine River Path','2025-11-07 17:00:00.000000','Europe/Paris','WALK',8),

-- Nov 6 - GAP

-- Nov 5
(248,40,'Jardin du Luxembourg','2025-11-05 17:00:00.000000','Europe/Paris','WALK',8),
(249,35,'Piscine Georges Vallerey','2025-11-05 08:00:00.000000','Europe/Paris','SWIM',8),

-- Nov 4
(250,35,'Piscine Georges Vallerey','2025-11-04 08:00:00.000000','Europe/Paris','SWIM',8),
(251,30,'Champ de Mars','2025-11-04 17:00:00.000000','Europe/Paris','WALK',8),

-- ============================================================
-- AMANDA_WHITE (user_id=11) - WARNING USER (last: Nov 15, 3 days gap)
-- Paris timezone, swimming enthusiast with gaps
-- 25 records across 14 days
-- ============================================================

-- Nov 15 (3 days ago - last exercise)
(252,45,'Aquaboulevard','2025-11-15 07:30:00.000000','Europe/Paris','SWIM',11),
(253,25,'Parc des Buttes-Chaumont','2025-11-15 17:00:00.000000','Europe/Paris','WALK',11),

-- Nov 14
(254,40,'Piscine Keller','2025-11-14 08:00:00.000000','Europe/Paris','SWIM',11),
(255,30,'Bois de Boulogne','2025-11-14 17:00:00.000000','Europe/Paris','WALK',11),

-- Nov 13
(256,35,'Bois de Boulogne','2025-11-13 12:00:00.000000','Europe/Paris','WALK',11),
(257,40,'Aquaboulevard','2025-11-13 18:00:00.000000','Europe/Paris','SWIM',11),

-- Nov 12
(258,40,'Aquaboulevard','2025-11-12 07:30:00.000000','Europe/Paris','SWIM',11),
(259,30,'Canal Saint-Martin','2025-11-12 17:00:00.000000','Europe/Paris','WALK',11),

-- Nov 11
(260,30,'Canal Saint-Martin','2025-11-11 17:00:00.000000','Europe/Paris','WALK',11),
(261,45,'Piscine Keller','2025-11-11 07:30:00.000000','Europe/Paris','SWIM',11),

-- Nov 10 - GAP

-- Nov 9
(262,45,'Piscine Keller','2025-11-09 08:00:00.000000','Europe/Paris','SWIM',11),
(263,25,'Parc Monceau','2025-11-09 17:00:00.000000','Europe/Paris','WALK',11),
(264,25,'Montmartre','2025-11-09 12:00:00.000000','Europe/Paris','WALK',11),

-- Nov 8
(265,25,'Parc Monceau','2025-11-08 12:00:00.000000','Europe/Paris','WALK',11),
(266,40,'Aquaboulevard','2025-11-08 18:00:00.000000','Europe/Paris','SWIM',11),

-- Nov 7
(267,40,'Aquaboulevard','2025-11-07 07:30:00.000000','Europe/Paris','SWIM',11),
(268,25,'Jardin des Plantes','2025-11-07 17:00:00.000000','Europe/Paris','WALK',11),

-- Nov 6 - GAP

-- Nov 5
(269,35,'Jardin des Plantes','2025-11-05 17:00:00.000000','Europe/Paris','WALK',11),
(270,45,'Piscine Keller','2025-11-05 08:00:00.000000','Europe/Paris','SWIM',11),

-- Nov 4
(271,40,'Piscine Keller','2025-11-04 08:00:00.000000','Europe/Paris','SWIM',11),
(272,30,'Parc des Buttes-Chaumont','2025-11-04 17:00:00.000000','Europe/Paris','WALK',11),

-- ============================================================
-- MIKE_JOHNSON (user_id=6) - ALERT USER (last: Nov 10, 8 days gap)
-- Shanghai timezone, minimal activity with large gaps
-- 19 records across 14 days
-- ============================================================

-- Nov 10 (8 days ago - last exercise)
(273,30,'Century Park','2025-11-10 08:00:00.000000','Asia/Shanghai','WALK',6),
(274,25,'The Bund','2025-11-10 17:00:00.000000','Asia/Shanghai','WALK',6),

-- Nov 9
(275,25,'The Bund','2025-11-09 07:00:00.000000','Asia/Shanghai','WALK',6),

-- Nov 8
(276,20,'People\'s Square','2025-11-08 12:00:00.000000','Asia/Shanghai','WALK',6),
(277,25,'Xujiahui Park','2025-11-08 17:00:00.000000','Asia/Shanghai','WALK',6),

-- Nov 7
(278,20,'Nanjing Road','2025-11-07 08:00:00.000000','Asia/Shanghai','WALK',6),

-- Nov 6
(279,25,'Jing\'an Park','2025-11-06 08:00:00.000000','Asia/Shanghai','WALK',6),
(280,30,'Century Park','2025-11-06 17:00:00.000000','Asia/Shanghai','WALK',6),

-- Nov 5 - GAP

-- Nov 4
(281,30,'Xujiahui Park','2025-11-04 07:00:00.000000','Asia/Shanghai','WALK',6),
(282,20,'People\'s Square','2025-11-04 17:00:00.000000','Asia/Shanghai','WALK',6),
(283,25,'Yu Garden','2025-11-04 12:00:00.000000','Asia/Shanghai','WALK',6);

/*!40000 ALTER TABLE `exercises` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-18

-- ============================================================
-- DATA SUMMARY
-- ============================================================
-- Total Users: 11 (excluding test users 123, 111)
-- Total Exercise Records: 283
-- Date Range: Nov 4-17, 2025 (14 days)
-- Demo Date: November 18, 2025
--
-- USER CATEGORIES:
-- Active Users (last exercise Nov 17, 1 day ago):
--   - allen (24): 27 records - EXEMPLARY user with varied time periods (morning/afternoon/evening)
--   - sarah_smith (5): 30 records
--   - emily_davis (7): 30 records
--   - lisa_brown (9): 30 records
--   - james_taylor (10): 30 records
--   - chris_martin (12): 30 records
--   - jennifer_lee (13): 30 records
--
-- Warning Users (last exercise Nov 15, 3 days ago):
--   - john_doe (4): 23 records
--   - david_wilson (8): 21 records
--   - amanda_white (11): 21 records
--
-- Alert User (last exercise Nov 10, 8 days ago):
--   - mike_johnson (6): 11 records
--
-- All users password: 123
-- ============================================================
