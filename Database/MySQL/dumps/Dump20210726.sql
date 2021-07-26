CREATE DATABASE  IF NOT EXISTS `marketplace` /*!80016 DEFAULT ENCRYPTION='N' */;
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
-- Table structure for table `address_info`
--

DROP TABLE IF EXISTS `address_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_info` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `address_street` varchar(255) NOT NULL,
  `address_city` varchar(50) NOT NULL,
  `address_state` varchar(50) NOT NULL,
  `address_zip` varchar(9) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `address_id_UNIQUE` (`address_id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_info`
--

LOCK TABLES `address_info` WRITE;
/*!40000 ALTER TABLE `address_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL,
  `buyer_user_name` varchar(50) NOT NULL,
  `payment_method_id` int DEFAULT NULL,
  `shipping_info_id` int DEFAULT NULL,
  `is_cancelled` bit(1) NOT NULL DEFAULT b'0',
  `is_shipped` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`),
  KEY `fk_buyer_user_name_idx` (`buyer_user_name`),
  KEY `fk_payment_method_id_idx` (`payment_method_id`),
  KEY `fk_shipping_info_id_idx` (`shipping_info_id`),
  CONSTRAINT `fk_buyer_user_name` FOREIGN KEY (`buyer_user_name`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_shipping_info_id` FOREIGN KEY (`shipping_info_id`) REFERENCES `shipping_info` (`shipping_info_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_product_id_idx` (`product_id`),
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_method` (
  `payment_method_id` int NOT NULL AUTO_INCREMENT,
  `payment_method_type` varchar(50) DEFAULT 'card',
  `account_number` blob NOT NULL,
  `account_owner_name` blob NOT NULL,
  `account_security_code` blob,
  `billing_address_id` int NOT NULL,
  `is_locked` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`payment_method_id`),
  UNIQUE KEY `payment_method_id_UNIQUE` (`payment_method_id`),
  KEY `billing_address_id_idx` (`billing_address_id`),
  CONSTRAINT `billing_address_id` FOREIGN KEY (`billing_address_id`) REFERENCES `address_info` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `is_removed` bit(1) NOT NULL DEFAULT b'0',
  `product_name` varchar(255) NOT NULL,
  `product_category` varchar(50) NOT NULL,
  `product_description` text,
  `product_image_link` text,
  `unit_price` decimal(65,2) NOT NULL,
  `initial_quantity` int NOT NULL DEFAULT '1',
  `remaining_quantity` int DEFAULT NULL,
  `seller_username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`),
  KEY `fk_seller_user_name_idx` (`seller_username`),
  CONSTRAINT `fk_seller_username` FOREIGN KEY (`seller_username`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,_binary '\0','x','automobile','asadsa',NULL,1.00,1,1,NULL),(2,_binary '\0','x','automobile','asadsa',NULL,1.00,2,3,NULL),(3,_binary '\0','furniture1','Furniture','asa','uploads\\img\\1627253600167flash.jpg',1.00,1,1,NULL),(4,_binary '\0','furniture2','Furniture','adxzcx','uploads\\img\\1627253694784StaticElectricity.png',2.00,2,2,NULL),(5,_binary '\0','furniture3','Furniture','f3','uploads\\img\\1627254260666magicarp.jpg',3.00,3,3,NULL),(6,_binary '\0','furniture4','Furniture','f4','',4.00,4,4,NULL),(7,_binary '\0','electronics1','electronics','E1','uploads\\img\\1627281088326StaticElectricity.png',1.00,1,1,'user2');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_info`
--

DROP TABLE IF EXISTS `shipping_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_info` (
  `shipping_info_id` int NOT NULL AUTO_INCREMENT,
  `shipping_to_name` varchar(255) NOT NULL,
  `shipping_address_id` int NOT NULL,
  `shipping_contact_phone` char(10) DEFAULT NULL,
  PRIMARY KEY (`shipping_info_id`),
  UNIQUE KEY `shipping_info_id_UNIQUE` (`shipping_info_id`),
  KEY `fk_shipping_address_id_idx` (`shipping_address_id`),
  CONSTRAINT `fk_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `address_info` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_info`
--

LOCK TABLES `shipping_info` WRITE;
/*!40000 ALTER TABLE `shipping_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_info` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin',_binary '^�H�\�(qQ\�\�o�\�)\'s`=\rj��\�*\�rB\�',_binary '',_binary '\0',NULL,'khoaho@my.unt.edu',NULL,'Khoa','Ho',NULL,NULL),('admin1',_binary '���\�n\�\�:b��\�\�?]Z���\��:\�l�',_binary '',_binary '\0',NULL,'khoaho@my.unt.edu','1234567890','First','Admin',NULL,NULL),('admin2',_binary '���\�n\�\�:b��\�\�?]Z���\��:\�l�',_binary '',_binary '\0',NULL,'khoaho@my.unt.edu','123456','Second','Admin',NULL,NULL),('user1',_binary '���\�n\�\�:b��\�\�?]Z���\��:\�l�',_binary '\0',_binary '\0',NULL,'khoaho@my.unt.edu','65789','F006','L006',NULL,NULL),('user2',_binary '���\�n\�\�:b��\�\�?]Z���\��:\�l�',_binary '\0',_binary '\0',NULL,'khoaho@my.unt.edu','987654321','Second','User',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'marketplace'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-26 14:03:19
