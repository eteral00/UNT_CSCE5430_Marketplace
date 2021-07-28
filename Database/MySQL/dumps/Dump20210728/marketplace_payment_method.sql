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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` VALUES (1,'account',_binary '���\�n\�\�:b��\�\�?]Z���\��:\�l�',_binary '�iv\�A�\��M\�߱g�\�s�K��o*�H�',NULL,'2021-09-01',NULL,_binary '\0'),(2,'account',_binary '�iv\�A�\��M\�߱g�\�s�K��o*�H�',_binary '���\�n\�\�:b��\�\�?]Z���\��:\�l�',NULL,'2021-07-27',NULL,_binary '\0'),(3,'account',_binary '�iv\�A�\��M\�߱g�\�s�K��o*�H�',_binary '���\�n\�\�:b��\�\�?]Z���\��:\�l�',NULL,'2021-07-27',NULL,_binary '\0'),(4,'account',_binary '���\�n\�\�:b��\�\�?]Z���\��:\�l�',_binary '�iv\�A�\��M\�߱g�\�s�K��o*�H�',NULL,'2021-07-01',NULL,_binary '\0'),(5,'',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U','2021-07-27',1,_binary '\0'),(6,'',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U','2021-07-27',1,_binary '\0'),(7,'',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U',_binary '\�\�B�����șo�$\'�A\�d��L���xR�U','2021-07-27',NULL,_binary '\0'),(8,'',_binary 'Ë\�\�\��_��\�\�j�&�2S��\0d�\rD�?\�',_binary '�Ӕ\�\�]�z�,K�b�ͭm�\�\�_���\\\Z&w�',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',NULL,_binary '\0'),(9,'',_binary 'O-�!:r}\�\�uK��\�\�99�*d_`t\�&$',_binary 't\\\�8\��-��B\��?�ݿ.�j^�sK5\0��s',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',NULL,_binary '\0'),(10,'',_binary 'O-�!:r}\�\�uK��\�\�99�*d_`t\�&$',_binary 't\\\�8\��-��B\��?�ݿ.�j^�sK5\0��s',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',NULL,_binary '\0'),(11,'',_binary 'g\�ì\�T���&\��Q\�4.X\�MV+UkQ}�\�a2',_binary '\�w�\�L\�\�	C\n4\�\'�P�iH>E�\��W�ท\�',_binary 'H�9)�t�S«�J��39\�D�7u\�T�U(','2021-07-31',NULL,_binary '\0'),(12,'',_binary 'Ѱ\�\�\�\�\�\n�GK<d\��{x�uz{�?\�p٬��A',_binary '[��*�Ȃ��g��&���k&�����	`g\��\r',_binary '�gB�\�\\v\�\�U�g�6#ȳ��E��x\�\�F�','2021-07-31',NULL,_binary '\0'),(13,'',_binary 'Ѱ\�\�\�\�\�\n�GK<d\��{x�uz{�?\�p٬��A',_binary '[��*�Ȃ��g��&���k&�����	`g\��\r',_binary '�gB�\�\\v\�\�U�g�6#ȳ��E��x\�\�F�','2021-07-31',NULL,_binary '\0'),(14,'',_binary '����F\��_�[\�w,�ek\�m�v:U\�\�\�y�',_binary '\�.\��u�L\�oͦ}ݠ\\\�oߓ�{U�,��\�\"',_binary '1�5��eg�\��\�D\�4y�\\V�\�R�\��M�-\�','2021-07-31',26,_binary '\0'),(15,'',_binary '�@��%x�\��\���\"��j\�r�]�x]�M\0I',_binary '_\�$b_j�j̘\�\��IK�u�Cա�͸',_binary '�gB�\�\\v\�\�U�g�6#ȳ��E��x\�\�F�','2021-07-31',27,_binary '\0'),(16,'',_binary '3�2�p9��$\�uCf�\�6o\�}\�xI�',_binary '_\�$b_j�j̘\�\��IK�u�Cա�͸',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',28,_binary '\0'),(17,'',_binary 'Ϯ&(�\�.\Z�f�w G�\�{S�\�\�X\�c\0',_binary 'P�AbL%䓪\���2�ţ���\�5�9�n?\�|VZ�',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',29,_binary '\0'),(18,'',_binary '�\�\�\\詰$Ax�(\�l,\�8W#�jk��X\�\�\�\n',_binary '\�.\��u�L\�oͦ}ݠ\\\�oߓ�{U�,��\�\"',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',30,_binary '\0'),(19,'',_binary '�\�\�\\詰$Ax�(\�l,\�8W#�jk��X\�\�\�\n',_binary '\�.\��u�L\�oͦ}ݠ\\\�oߓ�{U�,��\�\"',_binary '\�Ꮝ�j%lʳ\�\�%�D\�Uͥ\�)�\�t3','2021-07-31',31,_binary '\0'),(20,'',_binary 'R�\�h|\�.�\�4.�o\�. ���뛂\�o>o0t;',_binary '\�\�+Mp�\�D�\�Ġd-�F�\�\�=�/�!�N�',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',32,_binary '\0'),(21,'',_binary '_\�$b_j�j̘\�\��IK�u�Cա�͸',_binary 'P�AbL%䓪\���2�ţ���\�5�9�n?\�|VZ�',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',33,_binary '\0'),(22,'',_binary 'R�\�h|\�.�\�4.�o\�. ���뛂\�o>o0t;',_binary 'h��\��LP,\\���,ň\�`y�ވ0L&�˙Α\�',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',34,_binary '\0'),(23,'',_binary '\�Fϒ��\'\�\�3\�΋\nJ@��i�J�׼M�Ա',_binary '\�.\��u�L\�oͦ}ݠ\\\�oߓ�{U�,��\�\"',_binary '�e�Y B/�A~Hg\�\�O��J?��~������z\�','2021-07-31',35,_binary '\0'),(24,'',_binary '�릛:v\'І�{Բ�hX���M\Z>\�̿�+;��\�',_binary 'ԘK\r�iچ �g\��K҈��\�\�@��N�_}',_binary '�\�\�\\詰$Ax�(\�l,\�8W#�jk��X\�\�\�\n','2021-07-31',36,_binary '\0');
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

-- Dump completed on 2021-07-28  6:27:53
