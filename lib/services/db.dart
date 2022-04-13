import 'package:sqflite/sqflite.dart';

Future<Database> initDB() async {
  var path = await getDatabasesPath();
  print("Creating tables at path: $path");
  var dbPath = path + 'banking.db';

  Database dbConnection = await openDatabase(dbPath, version: 1,
      onCreate: (Database db, int version) async {
    // await db.execute(
    //   "CREATE TABLE ingredients(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category_name TEXT, date_created INTEGER)",
    // );
    await db.execute('''
DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `id` varchar(6) NOT NULL,
  `date` date NOT NULL,
  `time` datetime NOT NULL,
  `AadharNo` decimal(12,0) NOT NULL,
  `Hid` decimal(4,0) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `FK_Aadhar_idx` (`AadharNo`),
  KEY `FK_Hid_idx` (`Hid`),
  CONSTRAINT `FK_Aadhar` FOREIGN KEY (`AadharNo`) REFERENCES `citizen` (`AadharNo`),
  CONSTRAINT `FK_Hid` FOREIGN KEY (`Hid`) REFERENCES `hospital` (`Hid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES ('134115','2021-04-21','2021-04-21 18:35:29',344714349501,7635),('368767','2021-11-04','2021-11-04 05:59:08',816376748732,5641),('478644','2022-03-14','2022-03-14 01:47:28',200379687422,9999),('496315','2022-03-20','2022-03-20 03:24:22',434714349502,4481),('762300','2021-09-08','2021-09-08 00:07:13',110379687421,4740),('804601','2022-03-25','2022-03-25 20:37:41',614103352096,7636),('878400','2021-03-09','2021-03-09 16:55:14',524103352096,8731),('922286','2021-04-20','2021-04-20 01:47:27',726376748732,6735),('937535','2021-05-02','2021-05-02 03:49:41',999999999999,3581);
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointmentstatus`
--

DROP TABLE IF EXISTS `appointmentstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentstatus` (
  `appointmentId` varchar(6) NOT NULL,
  `didShowUp` tinyint NOT NULL,
  PRIMARY KEY (`appointmentId`),
  CONSTRAINT `FK_AptId_Apt` FOREIGN KEY (`appointmentId`) REFERENCES `appointment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointmentstatus`
--

LOCK TABLES `appointmentstatus` WRITE;
/*!40000 ALTER TABLE `appointmentstatus` DISABLE KEYS */;
INSERT INTO `appointmentstatus` VALUES ('134115',1),('368767',1),('478644',1),('496315',1),('762300',1),('804601',0),('878400',1),('922286',1),('937535',1);
/*!40000 ALTER TABLE `appointmentstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citizen`
--

DROP TABLE IF EXISTS `citizen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citizen` (
  `AadharNo` decimal(12,0) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `PhoneNo` varchar(45) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `VaccinationStatus` varchar(45) DEFAULT NULL,
  `Age` int GENERATED ALWAYS AS (((to_days(_utf8mb4'2022-03-25') - to_days(`DOB`)) / 365.2524)) VIRTUAL,
  `category` varchar(45) DEFAULT 'Adult',
  PRIMARY KEY (`AadharNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citizen`
--

LOCK TABLES `citizen` WRITE;
/*!40000 ALTER TABLE `citizen` DISABLE KEYS */;
INSERT INTO `citizen` (`AadharNo`, `Name`, `City`, `PhoneNo`, `DOB`, `VaccinationStatus`, `category`) VALUES (110379687421,'Marya1956','Stevensville','(784) 105-7292','1993-07-13','Unvaccinated','Adult'),(200379687422,'Arminda2013','Chalmette','(465) 098-1888','1960-06-24','Vaccinated','Senior citizen'),(344714349501,'Edmonds2029','Gorman','(141) 952-2282','1998-06-16','Vaccinaed','Adult'),(434714349502,'Luisa1960','Barnstable','(450) 290-3993','1991-07-23','Vaccinated','Adult'),(524103352096,'Maxwell1966','Melvin','(730) 123-8017','1987-11-21','Vaccinated','Adult'),(614103352096,'Scarlet484','Prairieville','(219) 687-2284','1932-08-31','Vaccinated','Senior citizen'),(726376748732,'Lonna2001','Nicholville','(434) 214-4385','1983-08-14','Vaccinated','Adult'),(816376748732,'Tanja943','Goshen','(375) 580-5172','1955-11-12','Vaccinated','Adult'),(887455805577,'Kruger3','Eakly','(423) 916-0439','2006-05-19','Unvaccinated','Teenager'),(999999999999,'Hank939','Nicholson','(465) 824-3043','1945-03-20','Vaccinated','Senior citizen');
/*!40000 ALTER TABLE `citizen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital` (
  `Hid` decimal(4,0) NOT NULL,
  `HLocation` varchar(45) DEFAULT NULL,
  `Hname` varchar(45) DEFAULT NULL,
  `LicenseNumber` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`Hid`),
  UNIQUE KEY `LicenseNumber_UNIQUE` (`LicenseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
INSERT INTO `hospital` VALUES (2453,'Oneida','0G57J',725863),(3581,'Butner','1Y9FL',815863),(4481,'Iowa Park','75L4L',157052),(4740,'Sudlersville','2QFBV',999999),(5641,'Alvarado','N7N99',843667),(6735,'East Palestine','1VQKB',409224),(7635,'Magee','3327H',933664),(7636,'Zuni','4Y9Z2',319224),(8731,'Butlerville','0S80G',319223),(9999,'Wheat Ridge','56WUU',409223);
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccine`
--

DROP TABLE IF EXISTS `vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccine` (
  `name` varchar(10) DEFAULT NULL,
  `dosesReq` int DEFAULT NULL,
  `AptId` varchar(6) DEFAULT NULL,
  KEY `FK_AptId_Id_idx` (`AptId`),
  CONSTRAINT `FK_AptId_Id` FOREIGN KEY (`AptId`) REFERENCES `appointment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccine`
--

LOCK TABLES `vaccine` WRITE;
/*!40000 ALTER TABLE `vaccine` DISABLE KEYS */;
INSERT INTO `vaccine` VALUES ('Covishield',2,'134115'),('Covaxin',2,'368767'),('Covaxin',2,'804601'),('Covishield',2,'478644'),('Covishield',2,'922286'),('Covaxin',2,'496315'),('Covaxin',2,'878400'),('Covaxin',2,'762300'),('Covaxin',2,'937535');
/*!40000 ALTER TABLE `vaccine` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-13 17:34:54

''');

    // await _loadIngredients(db);
  });

  return dbConnection;
}
