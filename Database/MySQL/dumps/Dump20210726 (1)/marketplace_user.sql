CREATE DATABASE  IF NOT EXISTS `marketplace` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `marketplace`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: marketplace
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `user_password` blob NOT NULL,
  `is_admin` bit(1) NOT NULL DEFAULT b'0',
  `is_locked` bit(1) NOT NULL DEFAULT b'0',
  `locked_until_date` datetime DEFAULT NULL,
  `email_address` varchar(255) NOT NULL,
  `phone_number` char(10) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `default_address_id` int DEFAULT NULL,
  `payment_reception_method_id` int DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `user_name_UNIQUE` (`username`),
  KEY `fk_address_id_idx` (`default_address_id`),
  KEY `fk_payment_reception_method_id_idx` (`payment_reception_method_id`),
  CONSTRAINT `fk_address_id` FOREIGN KEY (`default_address_id`) REFERENCES `address_info` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_reception_method_id` FOREIGN KEY (`payment_reception_method_id`) REFERENCES `payment_method` (`payment_method_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin',_binary '^àHò\⁄(qQ\–\Âoç\∆)\'s`=\rj´Ω\÷*\ÔrB\ÿ',_binary '',_binary '\0',NULL,'khoaho@my.unt.edu',NULL,'Khoa','Ho',NULL,NULL),('admin1',_binary 'çñû\Ôn\ \”¬ö:bíÄ\ÊÜ\œ?]ZÜØÛ\ í:\‹lí',_binary '',_binary '\0',NULL,'khoaho@my.unt.edu','1234567890','First','Admin',NULL,NULL),('admin2',_binary 'çñû\Ôn\ \”¬ö:bíÄ\ÊÜ\œ?]ZÜØÛ\ í:\‹lí',_binary '',_binary '\0',NULL,'khoaho@my.unt.edu','123456','Second','Admin',NULL,NULL),('user1',_binary 'çñû\Ôn\ \”¬ö:bíÄ\ÊÜ\œ?]ZÜØÛ\ í:\‹lí',_binary '\0',_binary '\0',NULL,'khoaho@my.unt.edu','65789','F006','L006',NULL,NULL),('user2',_binary 'çñû\Ôn\ \”¬ö:bíÄ\ÊÜ\œ?]ZÜØÛ\ í:\‹lí',_binary '\0',_binary '\0',NULL,'khoaho@my.unt.edu','987654321','Second','User',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-26 10:12:51
