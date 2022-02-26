# ************************************************************
# Sequel Ace SQL dump
# Version 20029
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 8.0.27)
# Database: BankingSystem
# Generation Time: 2022-02-26 18:52:49 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Cards
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Cards`;

CREATE TABLE `Cards` (
  `CardNo` decimal(16,0) NOT NULL,
  `Term_Yrs` int NOT NULL,
  `IssueDate` date NOT NULL,
  `CType` varchar(40) NOT NULL,
  `CSubType` varchar(40) NOT NULL,
  PRIMARY KEY (`CardNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table CreditCard
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CreditCard`;

CREATE TABLE `CreditCard` (
  `CType` varchar(40) NOT NULL,
  `MonthlyInterest` float NOT NULL,
  `Eligibility_score` int NOT NULL,
  `Cash_Limit` float NOT NULL,
  `Joining_Fee` float NOT NULL,
  `Annual_Fee` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table DebitCard
# ------------------------------------------------------------

DROP TABLE IF EXISTS `DebitCard`;

CREATE TABLE `DebitCard` (
  `CType` varchar(40) NOT NULL,
  `CashBack_percent` int NOT NULL,
  `Points` int NOT NULL,
  `Withdrawal_Limit` float NOT NULL,
  `Renewal_Fee` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table person
# ------------------------------------------------------------

DROP TABLE IF EXISTS `person`;

CREATE TABLE `person` (
  `AadharNo` int unsigned NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `DOB` date NOT NULL,
  `Gender` varchar(1) NOT NULL,
  `HouseNo` varchar(45) DEFAULT NULL,
  `Locality` varchar(45) DEFAULT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(45) NOT NULL,
  PRIMARY KEY (`AadharNo`),
  CONSTRAINT `person_chk_1` CHECK ((`Gender` in (_utf8mb4'M',_utf8mb4'F',_utf8mb4'O')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;

INSERT INTO `person` (`AadharNo`, `FirstName`, `LastName`, `DOB`, `Gender`, `HouseNo`, `Locality`, `City`, `State`)
VALUES
	(123,'abc','def','2000-10-20','M','1','1','1','1');

/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table phonenumbers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `phonenumbers`;

CREATE TABLE `phonenumbers` (
  `PhoneNumber` int NOT NULL,
  `AadharNo` int unsigned NOT NULL,
  PRIMARY KEY (`PhoneNumber`,`AadharNo`),
  KEY `FK_Person_idx` (`AadharNo`),
  CONSTRAINT `FK_Person` FOREIGN KEY (`AadharNo`) REFERENCES `person` (`AadharNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
