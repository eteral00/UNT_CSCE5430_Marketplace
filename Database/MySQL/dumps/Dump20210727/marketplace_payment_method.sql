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
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_method` (
  `payment_method_id` int NOT NULL AUTO_INCREMENT,
  `payment_method_type` varchar(50) DEFAULT 'account',
  `account_number` blob NOT NULL,
  `account_owner_name` blob NOT NULL,
  `account_security_code` blob,
  `account_expire_date` date DEFAULT NULL,
  `billing_address_id` int DEFAULT NULL,
  `is_locked` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`payment_method_id`),
  UNIQUE KEY `payment_method_id_UNIQUE` (`payment_method_id`),
  KEY `billing_address_id_idx` (`billing_address_id`),
  CONSTRAINT `billing_address_id` FOREIGN KEY (`billing_address_id`) REFERENCES `address_info` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` VALUES (1,'account',_binary '–\ïn\Ê\ÓÂš:b’€\æ†\Ï?]Z†¯ó\Ê’:\Ül’',_binary 'Œiv\åµA½\é½M\îß±g©\ÈsüK¸¨o*´H©',NULL,'2021-09-01',NULL,_binary '\0'),(2,'account',_binary 'Œiv\åµA½\é½M\îß±g©\ÈsüK¸¨o*´H©',_binary '–\ïn\Ê\ÓÂš:b’€\æ†\Ï?]Z†¯ó\Ê’:\Ül’',NULL,'2021-07-27',NULL,_binary '\0'),(3,'account',_binary 'Œiv\åµA½\é½M\îß±g©\ÈsüK¸¨o*´H©',_binary '–\ïn\Ê\ÓÂš:b’€\æ†\Ï?]Z†¯ó\Ê’:\Ül’',NULL,'2021-07-27',NULL,_binary '\0'),(4,'account',_binary '–\ïn\Ê\ÓÂš:b’€\æ†\Ï?]Z†¯ó\Ê’:\Ül’',_binary 'Œiv\åµA½\é½M\îß±g©\ÈsüK¸¨o*´H©',NULL,'2021-07-01',NULL,_binary '\0'),(5,'',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U','2021-07-27',1,_binary '\0'),(6,'',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U','2021-07-27',1,_binary '\0'),(7,'',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U',_binary '\ã°\ÄB˜üšûôÈ™o¹$\'®A\äd›“L¤•™xR¸U','2021-07-27',NULL,_binary '\0');
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-27 15:50:25
