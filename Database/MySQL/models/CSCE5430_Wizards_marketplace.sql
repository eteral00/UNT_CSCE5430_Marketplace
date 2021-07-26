-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema marketplace
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema marketplace
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `marketplace` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `marketplace` ;

-- -----------------------------------------------------
-- Table `marketplace`.`address_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace`.`address_info` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address_street` VARCHAR(255) NOT NULL,
  `address_city` VARCHAR(50) NOT NULL,
  `address_state` VARCHAR(50) NOT NULL,
  `address_zip` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE INDEX `address_id_UNIQUE` (`address_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `marketplace`.`payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace`.`payment_method` (
  `payment_method_id` INT NOT NULL AUTO_INCREMENT,
  `payment_method_type` VARCHAR(50) NOT NULL,
  `account_number` BLOB NOT NULL,
  `account_owner_name` BLOB NOT NULL,
  `account_security_code` BLOB NULL DEFAULT NULL,
  `billing_address_id` INT NOT NULL,
  `is_locked` BIT(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`payment_method_id`),
  UNIQUE INDEX `payment_method_id_UNIQUE` (`payment_method_id` ASC) VISIBLE,
  INDEX `billing_address_id_idx` (`billing_address_id` ASC) VISIBLE,
  CONSTRAINT `billing_address_id`
    FOREIGN KEY (`billing_address_id`)
    REFERENCES `marketplace`.`address_info` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `marketplace`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace`.`user` (
  `username` VARCHAR(50) NOT NULL,
  `user_password` BLOB NOT NULL,
  `is_admin` BIT(1) NOT NULL DEFAULT b'0',
  `is_locked` BIT(1) NOT NULL DEFAULT b'0',
  `locked_until_date` DATETIME NULL DEFAULT NULL,
  `email_address` VARCHAR(255) NOT NULL,
  `phone_number` CHAR(10) NULL DEFAULT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `default_address_id` INT NULL DEFAULT NULL,
  `payment_reception_method_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE INDEX `user_name_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_address_id_idx` (`default_address_id` ASC) VISIBLE,
  INDEX `fk_payment_reception_method_id_idx` (`payment_reception_method_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_id`
    FOREIGN KEY (`default_address_id`)
    REFERENCES `marketplace`.`address_info` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_reception_method_id`
    FOREIGN KEY (`payment_reception_method_id`)
    REFERENCES `marketplace`.`payment_method` (`payment_method_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `marketplace`.`shipping_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace`.`shipping_info` (
  `shipping_info_id` INT NOT NULL AUTO_INCREMENT,
  `shipping_to_name` VARCHAR(255) NOT NULL,
  `shipping_address_id` INT NOT NULL,
  `shipping_contact_phone` CHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`shipping_info_id`),
  UNIQUE INDEX `shipping_info_id_UNIQUE` (`shipping_info_id` ASC) VISIBLE,
  INDEX `fk_shipping_address_id_idx` (`shipping_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_shipping_address_id`
    FOREIGN KEY (`shipping_address_id`)
    REFERENCES `marketplace`.`address_info` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `marketplace`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  `buyer_user_name` VARCHAR(50) NOT NULL,
  `payment_method_id` INT NULL DEFAULT NULL,
  `shipping_info_id` INT NULL DEFAULT NULL,
  `is_cancelled` BIT(1) NOT NULL DEFAULT b'0',
  `is_shipped` BIT(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_buyer_user_name_idx` (`buyer_user_name` ASC) VISIBLE,
  INDEX `fk_payment_method_id_idx` (`payment_method_id` ASC) VISIBLE,
  INDEX `fk_shipping_info_id_idx` (`shipping_info_id` ASC) VISIBLE,
  CONSTRAINT `fk_buyer_user_name`
    FOREIGN KEY (`buyer_user_name`)
    REFERENCES `marketplace`.`user` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_method_id`
    FOREIGN KEY (`payment_method_id`)
    REFERENCES `marketplace`.`payment_method` (`payment_method_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_shipping_info_id`
    FOREIGN KEY (`shipping_info_id`)
    REFERENCES `marketplace`.`shipping_info` (`shipping_info_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `marketplace`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `is_removed` BIT(1) NOT NULL DEFAULT b'0',
  `product_name` VARCHAR(255) NOT NULL,
  `product_category` VARCHAR(50) NOT NULL,
  `product_description` TEXT NULL DEFAULT NULL,
  `product_image_link` TEXT NULL DEFAULT NULL,
  `unit_price` DECIMAL(65,2) NOT NULL,
  `initial_quantity` INT NOT NULL DEFAULT '1',
  `remaining_quantity` INT NULL DEFAULT NULL,
  `seller_username` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE,
  INDEX `fk_seller_user_name_idx` (`seller_username` ASC) VISIBLE,
  CONSTRAINT `fk_seller_username`
    FOREIGN KEY (`seller_username`)
    REFERENCES `marketplace`.`user` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `marketplace`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace`.`order_detail` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `product_quantity` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `marketplace`.`order` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `marketplace`.`product` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
