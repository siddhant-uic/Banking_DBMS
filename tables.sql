# ************************************************************
# Sequel Ace SQL dump
# Version 20029
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 8.0.27)
# Database: bankingSystem
# Generation Time: 2022-02-26 18:59:57 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Account`;

CREATE TABLE `Account` (
  `Account#` decimal(10,0) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Balance` decimal(15,2) NOT NULL,
  PRIMARY KEY (`Account#`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table AccountOpened
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AccountOpened`;

CREATE TABLE `AccountOpened` (
  `CustID` decimal(6,0) NOT NULL,
  `BranchID` decimal(4,0) NOT NULL,
  `Account#` decimal(10,0) NOT NULL,
  `DateOfOpening` date NOT NULL,
  PRIMARY KEY (`Account#`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table Branch
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Branch`;

CREATE TABLE `Branch` (
  `branchID` decimal(4,0) NOT NULL,
  `Locality` varchar(45) NOT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(45) NOT NULL,
  PRIMARY KEY (`branchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



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



# Dump of table customer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `CustID` int NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Income` float NOT NULL,
  `Credit Score` float NOT NULL,
  `AadharNo` decimal(12,0) unsigned NOT NULL,
  PRIMARY KEY (`CustID`)
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



# Dump of table DepositoryAcc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `DepositoryAcc`;

CREATE TABLE `DepositoryAcc` (
  `Account#` decimal(10,0) NOT NULL,
  `InterestRate` decimal(2,0) DEFAULT NULL,
  `minBalance` decimal(15,0) DEFAULT NULL,
  `Type` varchar(45) NOT NULL,
  `DebitCard#` decimal(16,0) NOT NULL,
  PRIMARY KEY (`Account#`),
  UNIQUE KEY `DebitCard#_UNIQUE` (`DebitCard#`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table Employee
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Employee`;

CREATE TABLE `Employee` (
  `empID` decimal(6,0) NOT NULL,
  `Salary` int unsigned NOT NULL,
  `DOJ` date NOT NULL,
  `branchID` decimal(4,0) NOT NULL,
  PRIMARY KEY (`empID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table fixeddeposits
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fixeddeposits`;

CREATE TABLE `fixeddeposits` (
  `DepositNo` int NOT NULL,
  `TenureMonth` int NOT NULL,
  `DateOfCreation` date NOT NULL,
  `Amount` float NOT NULL,
  `ROI` float NOT NULL,
  PRIMARY KEY (`DepositNo`),
  UNIQUE KEY `DepositNo_UNIQUE` (`DepositNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table LoanRequests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `LoanRequests`;

CREATE TABLE `LoanRequests` (
  `requestID` decimal(6,0) NOT NULL,
  `DateOfOpening` date NOT NULL,
  `Amount` decimal(15,0) NOT NULL,
  `DurationMonths` int NOT NULL,
  `Type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`requestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table Manages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Manages`;

CREATE TABLE `Manages` (
  `empID` decimal(6,0) NOT NULL,
  `branchID` decimal(4,0) NOT NULL,
  `DOJ` date NOT NULL,
  PRIMARY KEY (`empID`,`branchID`,`DOJ`)
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
