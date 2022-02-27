-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: bankingsystem
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `Account#` decimal(10,0) NOT NULL,
  `Balance` decimal(15,2) NOT NULL,
  PRIMARY KEY (`Account#`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accountopened`
--

DROP TABLE IF EXISTS `accountopened`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountopened`
--

LOCK TABLES `accountopened` WRITE;
/*!40000 ALTER TABLE `accountopened` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountopened` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branchID` decimal(4,0) NOT NULL,
  `Locality` varchar(45) NOT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(45) NOT NULL,
  PRIMARY KEY (`branchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cards`
--

DROP TABLE IF EXISTS `cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cards` (
  `CardNo` decimal(16,0) NOT NULL,
  `Term_Yrs` int NOT NULL,
  `IssueDate` date NOT NULL,
  `CType` varchar(40) NOT NULL,
  `CSubType` varchar(40) NOT NULL,
  PRIMARY KEY (`CardNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cards`
--

LOCK TABLES `cards` WRITE;
/*!40000 ALTER TABLE `cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creditcard`
--

DROP TABLE IF EXISTS `creditcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creditcard` (
  `CType` varchar(40) NOT NULL,
  `MonthlyInterest` float NOT NULL,
  `Eligibility_score` int NOT NULL,
  `Cash_Limit` float NOT NULL,
  `Joining_Fee` float NOT NULL,
  `Annual_Fee` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditcard`
--

LOCK TABLES `creditcard` WRITE;
/*!40000 ALTER TABLE `creditcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `creditcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustID` decimal(6,0) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Income` float NOT NULL,
  `Credit Score` float NOT NULL,
  `AadharNo` decimal(12,0) unsigned NOT NULL,
  PRIMARY KEY (`CustID`),
  CONSTRAINT `customer_chk_1` CHECK ((length(`CustID`) = 6))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (123456,'1234567',122,123,12341);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debitcard`
--

DROP TABLE IF EXISTS `debitcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debitcard` (
  `CType` varchar(40) NOT NULL,
  `CashBack_percent` int NOT NULL,
  `Points` int NOT NULL,
  `Withdrawal_Limit` float NOT NULL,
  `Renewal_Fee` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debitcard`
--

LOCK TABLES `debitcard` WRITE;
/*!40000 ALTER TABLE `debitcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `debitcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `depositoryacc`
--

DROP TABLE IF EXISTS `depositoryacc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `depositoryacc`
--

LOCK TABLES `depositoryacc` WRITE;
/*!40000 ALTER TABLE `depositoryacc` DISABLE KEYS */;
/*!40000 ALTER TABLE `depositoryacc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixeddeposits`
--

DROP TABLE IF EXISTS `fixeddeposits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixeddeposits`
--

LOCK TABLES `fixeddeposits` WRITE;
/*!40000 ALTER TABLE `fixeddeposits` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixeddeposits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loanacc`
--

DROP TABLE IF EXISTS `loanacc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loanacc` (
  `InterestRate` float NOT NULL,
  `RepaymentDate` date NOT NULL,
  `Account#` decimal(10,0) NOT NULL,
  PRIMARY KEY (`Account#`),
  CONSTRAINT `FK_ACCNO` FOREIGN KEY (`Account#`) REFERENCES `account` (`Account#`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanacc`
--

LOCK TABLES `loanacc` WRITE;
/*!40000 ALTER TABLE `loanacc` DISABLE KEYS */;
/*!40000 ALTER TABLE `loanacc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loanrequests`
--

DROP TABLE IF EXISTS `loanrequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanrequests`
--

LOCK TABLES `loanrequests` WRITE;
/*!40000 ALTER TABLE `loanrequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `loanrequests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manages`
--

DROP TABLE IF EXISTS `manages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manages` (
  `empID` decimal(6,0) NOT NULL,
  `branchID` decimal(4,0) NOT NULL,
  `DOJ` date NOT NULL,
  PRIMARY KEY (`empID`,`branchID`,`DOJ`),
  KEY `FK_BrID_Manages_idx` (`branchID`),
  CONSTRAINT `FK_BrID_Manages` FOREIGN KEY (`branchID`) REFERENCES `branch` (`branchID`),
  CONSTRAINT `FK_emp_manages` FOREIGN KEY (`empID`) REFERENCES `employee` (`empID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manages`
--

LOCK TABLES `manages` WRITE;
/*!40000 ALTER TABLE `manages` DISABLE KEYS */;
/*!40000 ALTER TABLE `manages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phonenumbers`
--

DROP TABLE IF EXISTS `phonenumbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phonenumbers` (
  `PhoneNumber` decimal(10,0) NOT NULL,
  `AadharNo` decimal(12,0) unsigned NOT NULL,
  PRIMARY KEY (`PhoneNumber`,`AadharNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phonenumbers`
--

LOCK TABLES `phonenumbers` WRITE;
/*!40000 ALTER TABLE `phonenumbers` DISABLE KEYS */;
/*!40000 ALTER TABLE `phonenumbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `TransactionID` decimal(10,0) NOT NULL,
  `Amount` decimal(15,2) NOT NULL,
  `Status` varchar(1) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `DateTime` datetime NOT NULL,
  `CustID` decimal(6,0) NOT NULL,
  `Account#` decimal(10,0) NOT NULL,
  PRIMARY KEY (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-27 13:53:30
