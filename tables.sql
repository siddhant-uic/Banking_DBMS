# ************************************************************
# Sequel Ace SQL dump
# Version 20029
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 8.0.27)
# Database: test2
# Generation Time: 2022-02-27 08:37:55 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `Account#` decimal(10,0) NOT NULL,
  `Balance` decimal(15,2) NOT NULL,
  PRIMARY KEY (`Account#`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table accountopened
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accountopened`;

CREATE TABLE `accountopened` (
  `CustID` decimal(6,0) NOT NULL,
  `BranchID` decimal(4,0) NOT NULL,
  `Account#` decimal(10,0) NOT NULL,
  `DateOfOpening` date NOT NULL,
  PRIMARY KEY (`Account#`),
  KEY `FK_Cust_idx` (`CustID`),
  KEY `FK_BrID_idx` (`BranchID`),
  CONSTRAINT `FK_ActNo` FOREIGN KEY (`Account#`) REFERENCES `account` (`Account#`) ON DELETE CASCADE,
  CONSTRAINT `FK_BrID` FOREIGN KEY (`BranchID`) REFERENCES `branch` (`branchID`),
  CONSTRAINT `FK_Cust` FOREIGN KEY (`CustID`) REFERENCES `customer` (`CustID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table branch
# ------------------------------------------------------------

DROP TABLE IF EXISTS `branch`;

CREATE TABLE `branch` (
  `branchID` decimal(4,0) NOT NULL,
  `Locality` varchar(45) NOT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(45) NOT NULL,
  PRIMARY KEY (`branchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table cards
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cards`;

CREATE TABLE `cards` (
  `CardNo` decimal(16,0) NOT NULL,
  `Term_Yrs` int NOT NULL,
  `IssueDate` date NOT NULL,
  `CType` varchar(40) NOT NULL,
  `CSubType` varchar(40) NOT NULL,
  PRIMARY KEY (`CardNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table creditcard
# ------------------------------------------------------------

DROP TABLE IF EXISTS `creditcard`;

CREATE TABLE `creditcard` (
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
  `CustID` decimal(6,0) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Income` float NOT NULL,
  `Credit Score` float NOT NULL,
  `AadharNo` decimal(12,0) unsigned NOT NULL,
  PRIMARY KEY (`CustID`),
  CONSTRAINT `customer_chk_1` CHECK ((length(`CustID`) = 6))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table debitcard
# ------------------------------------------------------------

DROP TABLE IF EXISTS `debitcard`;

CREATE TABLE `debitcard` (
  `CType` varchar(40) NOT NULL,
  `CashBack_percent` int NOT NULL,
  `Points` int NOT NULL,
  `Withdrawal_Limit` float NOT NULL,
  `Renewal_Fee` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table depositoryacc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `depositoryacc`;

CREATE TABLE `depositoryacc` (
  `Account#` decimal(10,0) NOT NULL,
  `InterestRate` decimal(2,0) DEFAULT NULL,
  `minBalance` decimal(15,0) DEFAULT NULL,
  `Type` varchar(45) NOT NULL,
  `DebitCard#` decimal(16,0) NOT NULL,
  PRIMARY KEY (`Account#`),
  UNIQUE KEY `DebitCard#_UNIQUE` (`DebitCard#`),
  CONSTRAINT `FK_Act_Dep` FOREIGN KEY (`Account#`) REFERENCES `account` (`Account#`) ON DELETE CASCADE,
  CONSTRAINT `depositoryacc_chk_1` CHECK ((`type` in (_utf8mb4'SAVINGS',_utf8mb4'CURRENT')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table employee
# ------------------------------------------------------------

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `empID` decimal(6,0) NOT NULL,
  `Salary` float unsigned NOT NULL,
  `DOJ` date NOT NULL,
  `branchID` decimal(4,0) NOT NULL,
  `AadharNo` decimal(12,0) unsigned NOT NULL,
  PRIMARY KEY (`empID`),
  UNIQUE KEY `AadharNo_UNIQUE` (`AadharNo`),
  KEY `FK_WORKS_idx` (`branchID`),
  CONSTRAINT `FK_WORKS` FOREIGN KEY (`branchID`) REFERENCES `branch` (`branchID`)
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
  `CustId` decimal(6,0) NOT NULL,
  PRIMARY KEY (`DepositNo`),
  UNIQUE KEY `DepositNo_UNIQUE` (`DepositNo`),
  KEY `FK_OPENS_FD_idx` (`CustId`),
  CONSTRAINT `FK_OPENS_FD` FOREIGN KEY (`CustId`) REFERENCES `customer` (`CustID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table loanacc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loanacc`;

CREATE TABLE `loanacc` (
  `InterestRate` float NOT NULL,
  `RepaymentDate` date NOT NULL,
  `Account#` decimal(10,0) NOT NULL,
  PRIMARY KEY (`Account#`),
  CONSTRAINT `FK_ACCNO` FOREIGN KEY (`Account#`) REFERENCES `account` (`Account#`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table loanrequests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `loanrequests`;

CREATE TABLE `loanrequests` (
  `requestID` decimal(6,0) NOT NULL,
  `DateOfOpening` date NOT NULL,
  `Amount` float NOT NULL,
  `DurationMonths` int NOT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `CustId` decimal(6,0) NOT NULL,
  `BranchId` decimal(4,0) NOT NULL,
  `Acc#` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`requestID`),
  KEY `FK_Acc#_Loan_idx` (`Acc#`),
  KEY `FK_BrId_Loan_idx` (`BranchId`),
  KEY `FK_Cust_Loan_idx` (`CustId`),
  CONSTRAINT `FK_Acc#_Loan` FOREIGN KEY (`Acc#`) REFERENCES `account` (`Account#`) ON DELETE CASCADE,
  CONSTRAINT `FK_BrId_Loan` FOREIGN KEY (`BranchId`) REFERENCES `branch` (`branchID`),
  CONSTRAINT `FK_Cust_Loan` FOREIGN KEY (`CustId`) REFERENCES `customer` (`CustID`) ON DELETE CASCADE,
  CONSTRAINT `loanrequests_chk_1` CHECK ((`Type` in (_utf8mb4'PERSONAL',_utf8mb4'HOME',_utf8mb4'EDUCATION',_utf8mb4'VEHICLE',_utf8mb4'BUSINESS',_utf8mb4'OTHER')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table manages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `manages`;

CREATE TABLE `manages` (
  `empID` decimal(6,0) NOT NULL,
  `branchID` decimal(4,0) NOT NULL,
  `DOJ` date NOT NULL,
  PRIMARY KEY (`empID`,`branchID`,`DOJ`),
  KEY `FK_BrID_Manages_idx` (`branchID`),
  CONSTRAINT `FK_BrID_Manages` FOREIGN KEY (`branchID`) REFERENCES `branch` (`branchID`),
  CONSTRAINT `FK_emp_manages` FOREIGN KEY (`empID`) REFERENCES `employee` (`empID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table person
# ------------------------------------------------------------

DROP TABLE IF EXISTS `person`;


CREATE TABLE `person` (
  `AadharNo` decimal(12,0) unsigned NOT NULL,
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



# Dump of table phonenumbers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `phonenumbers`;

CREATE TABLE `phonenumbers` (
  `PhoneNumber` decimal(10,0) NOT NULL,
  `AadharNo` decimal(12,0) unsigned NOT NULL,
  PRIMARY KEY (`PhoneNumber`,`AadharNo`),
  CONSTRAINT `FK_Aadhar_Phone` FOREIGN KEY (`PhoneNumber`) REFERENCES `person` (`AadharNo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table transactions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transactions`;

CREATE TABLE `transactions` (
  `TransactionID` decimal(10,0) NOT NULL,
  `Amount` decimal(15,2) NOT NULL,
  `Status` varchar(1) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `DateTime` datetime NOT NULL,
  `CustID` decimal(6,0) NOT NULL,
  `Account#` decimal(10,0) NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `FK_custid_trans` (`CustID`),
  KEY `FK_acc_trans` (`Account#`),
  CONSTRAINT `FK_acc_trans` FOREIGN KEY (`Account#`) REFERENCES `account` (`Account#`) ON DELETE CASCADE,
  CONSTRAINT `FK_custid_trans` FOREIGN KEY (`CustID`) REFERENCES `customer` (`CustID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
