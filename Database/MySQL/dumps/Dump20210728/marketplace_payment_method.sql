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
INSERT INTO `payment_method` VALUES (1,'account',_binary 'çñû\Ôn\ \”¬ö:bíÄ\ÊÜ\œ?]ZÜØÛ\ í:\‹lí',_binary 'åiv\ÂµAΩ\ÈΩM\Óﬂ±g©\»s¸K∏®o*¥H©',NULL,'2021-09-01',NULL,_binary '\0'),(2,'account',_binary 'åiv\ÂµAΩ\ÈΩM\Óﬂ±g©\»s¸K∏®o*¥H©',_binary 'çñû\Ôn\ \”¬ö:bíÄ\ÊÜ\œ?]ZÜØÛ\ í:\‹lí',NULL,'2021-07-27',NULL,_binary '\0'),(3,'account',_binary 'åiv\ÂµAΩ\ÈΩM\Óﬂ±g©\»s¸K∏®o*¥H©',_binary 'çñû\Ôn\ \”¬ö:bíÄ\ÊÜ\œ?]ZÜØÛ\ í:\‹lí',NULL,'2021-07-27',NULL,_binary '\0'),(4,'account',_binary 'çñû\Ôn\ \”¬ö:bíÄ\ÊÜ\œ?]ZÜØÛ\ í:\‹lí',_binary 'åiv\ÂµAΩ\ÈΩM\Óﬂ±g©\»s¸K∏®o*¥H©',NULL,'2021-07-01',NULL,_binary '\0'),(5,'',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U','2021-07-27',1,_binary '\0'),(6,'',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U','2021-07-27',1,_binary '\0'),(7,'',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U',_binary '\„∞\ƒBò¸ö˚Ù»ôoπ$\'ÆA\‰dõìL§ïôxR∏U','2021-07-27',NULL,_binary '\0'),(8,'',_binary '√ã\ÌÜ\Í\‘ç_¿Ω\Í\ÍjØ&Ä2S†ñ\0dÅ\rD≤?\ﬁ',_binary '˜”î\€\‘]ÙzØ,K¿bùÕ≠m∫\≈\÷_πÜπ\\\Z&wù',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',NULL,_binary '\0'),(9,'',_binary 'O-ˆ!:r}\⁄\ÌuKˆˆ\√\ÿ99Ø*d_`t\Óò&$',_binary 't\\\≈8\›ê-°éB\€¸?à›ø.öj^¸sK5\0ªÜs',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',NULL,_binary '\0'),(10,'',_binary 'O-ˆ!:r}\⁄\ÌuKˆˆ\√\ÿ99Ø*d_`t\Óò&$',_binary 't\\\≈8\›ê-°éB\€¸?à›ø.öj^¸sK5\0ªÜs',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',NULL,_binary '\0'),(11,'',_binary 'g\È√¨\Î±T¢ÇÛ&\‘ˇQ\Õ4.X\ÁMV+UkQ}•\Âa2',_binary '\Êwñ\‘L\Ÿ\ƒ	C\n4\À\'ÛÖPêiH>EÅ\«˛Wò‡∏ó\Ê¨',_binary 'H¨9)∂t§S¬´ûJº¢39\ÃDø7u\”TÉU(','2021-07-31',NULL,_binary '\0'),(12,'',_binary '—∞\È\È\…\…\Â\nöGK<d\‡ó{x¿uz{à?\◊pŸ¨ÆºA',_binary '[ò¿*Ö»Çßøg©¥&°ëÄk&Éª´âé	`g\›¡\r',_binary '¨gBÛ\·\\v\·•\‚Ugï6#»≥à¥Eû˘x\◊\»FÙ','2021-07-31',NULL,_binary '\0'),(13,'',_binary '—∞\È\È\…\…\Â\nöGK<d\‡ó{x¿uz{à?\◊pŸ¨ÆºA',_binary '[ò¿*Ö»Çßøg©¥&°ëÄk&Éª´âé	`g\›¡\r',_binary '¨gBÛ\·\\v\·•\‚Ugï6#»≥à¥Eû˘x\◊\»FÙ','2021-07-31',NULL,_binary '\0'),(14,'',_binary 'Ç˝ïäF\–˛_ì[\”w,Òek\¬m¿v:U\∆\‹\Õy•',_binary '\ƒ.\ﬁ¸uáL\‚oÕ¶}›†\\\¬oﬂì±{UÙ,≠˝\√\"',_binary '1¨5˛ªeg∂\Î˜\ÊD\”4yÉ\\V∫\‹Rí\€ÒM≥-\◊','2021-07-31',26,_binary '\0'),(15,'',_binary 'Ç@ˆæ%xù\„Ò°ú\Óˆ©\"≠Éj\ÀrØ]ãx]ˆM\0I',_binary '_\Ÿ$b_j±jÃò\«\≈ÆIK¶u¯C’°™Õ∏',_binary '¨gBÛ\·\\v\·•\‚Ugï6#»≥à¥Eû˘x\◊\»FÙ','2021-07-31',27,_binary '\0'),(16,'',_binary '3ª2áp9≤ø$\‘uCfü\Ê6o\–}\›xI˘',_binary '_\Ÿ$b_j±jÃò\«\≈ÆIK¶u¯C’°™Õ∏',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',28,_binary '\0'),(17,'',_binary 'œÆ&(ã\ÿ.\Zófõw GÛî\Ë{SΩ\◊\ÂÑX\Ãc\0',_binary 'P≠AbL%‰ì™\«Ù´2Ω≈£∞∑é\Ã5µ9ìn?\Í|VZ˜',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',29,_binary '\0'),(18,'',_binary 'ñ\ \„\\Ë©∞$Axø(\‰ñl,\·∏8W#©jkÉàX\Õ\÷\ \n',_binary '\ƒ.\ﬁ¸uáL\‚oÕ¶}›†\\\¬oﬂì±{UÙ,≠˝\√\"',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',30,_binary '\0'),(19,'',_binary 'ñ\ \„\\Ë©∞$Axø(\‰ñl,\·∏8W#©jkÉàX\Õ\÷\ \n',_binary '\ƒ.\ﬁ¸uáL\‚oÕ¶}›†\\\¬oﬂì±{UÙ,≠˝\√\"',_binary '\„·èçåj%l ≥\‘\Á•%ÄD\¬UÕ•\’)É\…t3','2021-07-31',31,_binary '\0'),(20,'',_binary 'R¶\Îh|\“.Ä\”4.¨o\Ã. ûèÉÎõÇ\Ëo>o0t;',_binary '\Ô\·+Mpó\∆D∏\Âƒ†d-êFÚ\Ë\Œ=Æ/ß!çN˝',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',32,_binary '\0'),(21,'',_binary '_\Ÿ$b_j±jÃò\«\≈ÆIK¶u¯C’°™Õ∏',_binary 'P≠AbL%‰ì™\«Ù´2Ω≈£∞∑é\Ã5µ9ìn?\Í|VZ˜',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',33,_binary '\0'),(22,'',_binary 'R¶\Îh|\“.Ä\”4.¨o\Ã. ûèÉÎõÇ\Ëo>o0t;',_binary 'háá\ÿˇLP,\\ˇ™˛,≈à\ÿ`y˘ﬁà0L&∞ÀôŒë\∆',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',34,_binary '\0'),(23,'',_binary '\ÀFœíèÖ\'\‚\ƒ3\¬Œã\nJ@≠éi•J¢◊ºMâ‘±',_binary '\ƒ.\ﬁ¸uáL\‚oÕ¶}›†\\\¬oﬂì±{UÙ,≠˝\√\"',_binary '¶e§Y B/ùA~Hg\Ô\‹O∏†J?ˇ†~ôéÜ˜˜¢z\„','2021-07-31',35,_binary '\0'),(24,'',_binary 'ˇÎ¶õ:v\'–Üç{‘≤ÇhXé©´M\Z>\÷ÃøØ+;†˚\‰',_binary '‘òK\rÖi⁄Ü ˛g\Á˝K“àõ≥\’\Ó@∫ëN∂_}',_binary 'ñ\ \„\\Ë©∞$Axø(\‰ñl,\·∏8W#©jkÉàX\Õ\÷\ \n','2021-07-31',36,_binary '\0');
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
