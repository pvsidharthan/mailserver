-- MySQL dump 10.13  Distrib 5.1.34, for Win32 (ia32)
--
-- Host: localhost    Database: mail_server
-- ------------------------------------------------------
-- Server version	5.1.34-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chat_friends`
--

DROP TABLE IF EXISTS `chat_friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_friends` (
  `user_name` varchar(25) NOT NULL,
  `friend_user_name` varchar(50) NOT NULL,
  `status` char(1) NOT NULL,
  `nick_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_name`,`friend_user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_friends`
--

LOCK TABLES `chat_friends` WRITE;
/*!40000 ALTER TABLE `chat_friends` DISABLE KEYS */;
INSERT INTO `chat_friends` VALUES ('lijith','rohit','A','Luttu'),('lijith','sidharthan','A','Sidhu'),('rohit','lijith','A','Lijith'),('rohit','sidharthan','A','Sidhu..'),('sidharthan','lijith','A','Patoli'),('sidharthan','rohit','A','Luttu..');
/*!40000 ALTER TABLE `chat_friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_invitation`
--

DROP TABLE IF EXISTS `chat_invitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_invitation` (
  `from_user_name` varchar(25) NOT NULL DEFAULT '',
  `to_user_name` varchar(25) NOT NULL DEFAULT '',
  `status` char(1) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`from_user_name`,`to_user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_invitation`
--

LOCK TABLES `chat_invitation` WRITE;
/*!40000 ALTER TABLE `chat_invitation` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_invitation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_message`
--

DROP TABLE IF EXISTS `chat_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_message` (
  `to_user_name` varchar(25) NOT NULL,
  `from_user_name` varchar(25) NOT NULL,
  `message` text,
  `status` char(1) NOT NULL,
  `time` datetime NOT NULL,
  `sl_no` decimal(4,0) unsigned NOT NULL,
  PRIMARY KEY (`sl_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_message`
--

LOCK TABLES `chat_message` WRITE;
/*!40000 ALTER TABLE `chat_message` DISABLE KEYS */;
INSERT INTO `chat_message` VALUES ('lijith','sidharthan','Hai....','R','2010-05-29 15:47:27','1'),('lijith','rohit','Hello','R','2010-05-29 15:47:59','2'),('rohit','lijith','hello\n','R','2010-05-29 06:59:50','3'),('lijith','rohit','\naw\n','R','2010-05-29 07:07:19','4'),('lijith','rohit','hai','R','2010-05-29 07:15:38','5'),('lijith','sidharthan','HAIII','R','2010-05-29 07:16:39','6'),('sidharthan','lijith','good evening','R','2010-05-29 07:16:58','7'),('lijith','sidharthan','poodaaa','R','2010-05-29 07:17:07','8'),('lijith','sidharthan','\nhi','R','2010-05-29 07:17:14','9'),('sidharthan','lijith','hello','R','2010-05-29 07:17:17','10'),('rohit','sidharthan','hai','U','2010-05-29 07:21:05','11'),('rohit','sidharthan','\nhai','U','2010-05-29 07:21:06','12'),('rohit','sidharthan','\nl','U','2010-05-29 07:21:07','13'),('rohit','sidharthan','\nk','U','2010-05-29 07:21:08','14'),('rohit','sidharthan','\n','U','2010-05-29 07:21:08','15'),('rohit','sidharthan','\nkl','U','2010-05-29 07:21:09','16'),('rohit','sidharthan','\nl','U','2010-05-29 07:21:10','17'),('rohit','sidharthan','\nl','U','2010-05-29 07:21:10','18'),('rohit','sidharthan','\nl','U','2010-05-29 07:21:11','19'),('rohit','sidharthan','l','U','2010-05-29 07:22:14','20'),('rohit','sidharthan','\nl','U','2010-05-29 07:22:15','21'),('rohit','sidharthan','\nl','U','2010-05-29 07:22:15','22'),('rohit','sidharthan','\nl','U','2010-05-29 07:22:15','23'),('rohit','sidharthan','\nl','U','2010-05-29 07:22:15','24'),('rohit','sidharthan','\nl','U','2010-05-29 07:22:16','25'),('rohit','sidharthan','\nl','U','2010-05-29 07:22:16','26'),('rohit','sidharthan','\nl','U','2010-05-29 07:22:17','27'),('rohit','sidharthan','\n','U','2010-05-29 07:22:17','28'),('rohit','sidharthan','\nl','U','2010-05-29 07:22:17','29'),('rohit','sidharthan','\nlg','U','2010-05-29 07:22:18','30'),('lijith','sidharthan','l','R','2010-05-29 07:22:41','31'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:41','32'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:42','33'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:42','34'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:42','35'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:42','36'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:42','37'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:43','38'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:43','39'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:43','40'),('lijith','sidharthan','\nl','R','2010-05-29 07:22:43','41'),('lijith','sidharthan','\ng','R','2010-05-29 07:22:45','42'),('lijith','sidharthan','\ng','R','2010-05-29 07:22:46','43'),('lijith','sidharthan','\ng','R','2010-05-29 07:22:46','44'),('lijith','sidharthan','\ng','R','2010-05-29 07:22:46','45'),('lijith','sidharthan','\ng','R','2010-05-29 07:22:47','46'),('lijith','sidharthan','\ngt','R','2010-05-29 07:22:47','47'),('lijith','sidharthan','\nt','R','2010-05-29 07:22:48','48'),('lijith','sidharthan','\nt','R','2010-05-29 07:22:48','49'),('lijith','sidharthan','\nt','R','2010-05-29 07:22:48','50'),('rohit','sidharthan','l','U','2010-05-29 07:23:08','51'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:09','52'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:09','53'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:09','54'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:09','55'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:09','56'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:10','57'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:10','58'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:10','59'),('rohit','sidharthan','\nl','U','2010-05-29 07:23:10','60'),('rohit','sidharthan','\ny','U','2010-05-29 07:23:10','61'),('rohit','sidharthan','\ny','U','2010-05-29 07:23:11','62'),('rohit','sidharthan','\ny','U','2010-05-29 07:23:11','63'),('rohit','sidharthan','\ny','U','2010-05-29 07:23:11','64'),('rohit','sidharthan','\ny','U','2010-05-29 07:23:11','65'),('rohit','sidharthan','\ny','U','2010-05-29 07:23:11','66'),('rohit','sidharthan','\nt','U','2010-05-29 07:23:12','67'),('rohit','sidharthan','\ne','U','2010-05-29 07:23:12','68'),('rohit','sidharthan','\ne','U','2010-05-29 07:23:12','69'),('rohit','sidharthan','\ne','U','2010-05-29 07:23:12','70'),('rohit','sidharthan','\n','U','2010-05-29 07:23:12','71'),('rohit','sidharthan','\ne1','U','2010-05-29 07:23:13','72'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:13','73'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:13','74'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:13','75'),('rohit','sidharthan','\n','U','2010-05-29 07:23:13','76'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:14','77'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:14','78'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:14','79'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:14','80'),('rohit','sidharthan','\n','U','2010-05-29 07:23:15','81'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:15','82'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:15','83'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:15','84'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:16','85'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:16','86'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:16','87'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:16','88'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:16','89'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:17','90'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:17','91'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:17','92'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:17','93'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:17','94'),('rohit','sidharthan','\n1','U','2010-05-29 07:23:17','95'),('rohit','sidharthan','\nnk','U','2010-05-29 07:23:18','96'),('rohit','sidharthan','\nojio','U','2010-05-29 07:23:18','97'),('rohit','sidharthan','\nji','U','2010-05-29 07:23:18','98'),('rohit','sidharthan','\no','U','2010-05-29 07:23:18','99'),('rohit','sidharthan','\nji','U','2010-05-29 07:23:18','100'),('rohit','sidharthan','\nji','U','2010-05-29 07:23:19','101'),('rohit','sidharthan','\nodf','U','2010-05-29 07:23:21','102'),('rohit','sidharthan','\ndf','U','2010-05-29 07:23:21','103'),('rohit','sidharthan','\ndf','U','2010-05-29 07:23:21','104'),('rohit','sidharthan','\ndf','U','2010-05-29 07:23:22','105'),('rohit','sidharthan','\ndf','U','2010-05-29 07:23:22','106'),('rohit','sidharthan','\ndf','U','2010-05-29 07:23:22','107'),('rohit','sidharthan','\nd','U','2010-05-29 07:23:22','108'),('rohit','sidharthan','\nd','U','2010-05-29 07:23:22','109'),('rohit','sidharthan','\nf','U','2010-05-29 07:23:22','110'),('rohit','sidharthan','\n','U','2010-05-29 07:23:23','111'),('rohit','sidharthan','\ndf','U','2010-05-29 07:23:23','112'),('rohit','sidharthan','\nd','U','2010-05-29 07:23:23','113'),('rohit','sidharthan','\nfd','U','2010-05-29 07:23:23','114'),('rohit','sidharthan','\nd','U','2010-05-29 07:23:23','115'),('rohit','sidharthan','\nd','U','2010-05-29 07:23:24','116'),('rohit','sidharthan','\nd','U','2010-05-29 07:23:24','117'),('rohit','sidharthan','\ne','U','2010-05-29 07:23:24','118'),('rohit','sidharthan','\nwe','U','2010-05-29 07:23:24','119'),('rohit','sidharthan','\nw','U','2010-05-29 07:23:24','120'),('rohit','sidharthan','\nw','U','2010-05-29 07:23:25','121'),('rohit','sidharthan','\nw','U','2010-05-29 07:23:25','122'),('rohit','sidharthan','\nw','U','2010-05-29 07:23:25','123'),('rohit','sidharthan','\nw','U','2010-05-29 07:23:26','124'),('rohit','sidharthan','\nw','U','2010-05-29 07:23:26','125'),('rohit','sidharthan','\n','U','2010-05-29 07:23:26','126'),('rohit','sidharthan','\nr','U','2010-05-29 07:23:26','127'),('rohit','sidharthan','\ne','U','2010-05-29 07:23:26','128'),('rohit','sidharthan','\nwe','U','2010-05-29 07:23:26','129'),('rohit','sidharthan','\nwe','U','2010-05-29 07:23:27','130'),('rohit','sidharthan','\nw','U','2010-05-29 07:23:27','131'),('rohit','sidharthan','\nw','U','2010-05-29 07:23:27','132'),('rohit','sidharthan','\new','U','2010-05-29 07:23:27','133'),('lijith','sidharthan','Hai','R','2010-05-29 07:23:43','134'),('sidharthan','lijith','hiiiiiii','R','2010-05-29 07:24:11','135'),('rohit','lijith','gchbgch','U','2010-05-29 07:24:32','136'),('rohit','lijith','','U','2010-05-29 07:24:33','137'),('rohit','lijith','gfhgf','U','2010-05-29 07:24:35','138'),('sidharthan','lijith','gfhgfh','R','2010-05-29 07:24:44','139'),('lijith','sidharthan','hai','R','2010-05-29 07:25:12','140'),('lijith','sidharthan','hello','R','2010-05-29 07:25:17','141'),('sidharthan','lijith','hiiiiiiiii','R','2010-05-29 07:25:17','142'),('sidharthan','lijith','\nhi mr.patoli','R','2010-05-29 07:25:32','143'),('sidharthan','lijith','\nfg','R','2010-05-29 07:25:36','144'),('sidharthan','lijith','\nfg','R','2010-05-29 07:25:37','145'),('sidharthan','lijith','\ndgfdh','R','2010-05-29 07:25:43','146'),('sidharthan','lijith','\nfdgdfgdf','R','2010-05-29 07:25:44','147'),('sidharthan','lijith','h','R','2010-05-29 07:26:51','148'),('sidharthan','lijith','\nl','R','2010-05-29 07:26:51','149'),('sidharthan','lijith','\nl','R','2010-05-29 07:26:52','150'),('sidharthan','lijith','\nl','R','2010-05-29 07:26:52','151'),('sidharthan','lijith','\nl','R','2010-05-29 07:26:53','152'),('sidharthan','lijith','h','R','2010-05-29 07:27:25','153'),('sidharthan','lijith','\nl','R','2010-05-29 07:27:26','154'),('sidharthan','lijith','\nl','R','2010-05-29 07:27:27','155'),('sidharthan','lijith','\nl','R','2010-05-29 07:27:27','156'),('sidharthan','lijith','\nll','R','2010-05-29 07:27:27','157'),('sidharthan','lijith','\n;','R','2010-05-29 07:27:31','158'),('sidharthan','lijith','\n;','R','2010-05-29 07:27:31','159'),('sidharthan','lijith','\n;','R','2010-05-29 07:27:32','160'),('sidharthan','lijith','\n;','R','2010-05-29 07:27:32','161'),('lijith','sidharthan','32','R','2010-05-29 07:27:32','162'),('lijith','sidharthan','\n342314231423435453453','R','2010-05-29 07:27:34','163'),('lijith','sidharthan','\n1','R','2010-05-29 07:27:41','164'),('sidharthan','lijith','hai...','R','2010-05-29 07:27:42','165'),('lijith','sidharthan','\n11111111111111111111111111111111111111111111111111111111111111111111','R','2010-05-29 07:27:51','166'),('lijith','sidharthan','lrtk;jyhltk;ju','R','2010-05-29 07:28:06','167'),('lijith','sidharthan','\nytju','R','2010-05-29 07:28:07','168'),('lijith','sidharthan','\nytlkuyt;jyfg','R','2010-05-29 07:28:09','169'),('lijith','sidharthan','\nkytjl;yt','R','2010-05-29 07:28:09','170'),('lijith','sidharthan','\nytu;lrtkuyh','R','2010-05-29 07:28:10','171'),('lijith','sidharthan','\nreu;lky','R','2010-05-29 07:28:11','172'),('lijith','sidharthan','\nr;uykt','R','2010-05-29 07:28:11','173'),('lijith','sidharthan','\nrt;uyky;ulkyt;ulkyt;lukyt;ukyt;lukdrtprp6eouilrk;rpeyoiohk','R','2010-05-29 07:28:19','174'),('lijith','sidharthan','a','R','2010-05-29 07:28:43','175'),('lijith','sidharthan','hghg hjhgjh jjhjh jhjhjh jhjhh hjjhjh jhjj jhjh ','R','2010-05-29 07:29:06','176'),('lijith','sidharthan','\njjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj','R','2010-05-29 07:29:13','177'),('lijith','sidharthan','\nn,jkl,jkkkkkkkkkkkkkkkkk   kjljl','R','2010-05-29 07:29:24','178'),('lijith','sidharthan','\njjjjjjjjjjlllllllllllllll lik l','R','2010-05-29 07:29:34','179'),('lijith','sidharthan','hii','R','2010-05-29 07:39:17','180'),('sidharthan','lijith','Hai...','R','2010-05-29 07:39:20','181'),('sidharthan','lijith','please check the logout','R','2010-05-29 07:39:33','182'),('lijith','sidharthan','\nnice work dear...','R','2010-05-29 07:39:37','183'),('lijith','sidharthan','hi','R','2010-05-29 07:52:35','184'),('sidharthan','lijith','hai... Namukku pokam','R','2010-05-29 07:52:43','185'),('lijith','sidharthan','\noook','R','2010-05-29 07:52:50','186');
/*!40000 ALTER TABLE `chat_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_status`
--

DROP TABLE IF EXISTS `chat_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_status` (
  `user_name` varchar(25) NOT NULL,
  `status` decimal(1,0) NOT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_status`
--

LOCK TABLES `chat_status` WRITE;
/*!40000 ALTER TABLE `chat_status` DISABLE KEYS */;
INSERT INTO `chat_status` VALUES ('lijith','3'),('rohit','3'),('sidharthan','3');
/*!40000 ALTER TABLE `chat_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `user_name` varchar(25) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `group_id` decimal(2,0) DEFAULT NULL,
  `status` decimal(1,0) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `group_code` int(10) unsigned NOT NULL,
  `group_name` varchar(30) NOT NULL,
  PRIMARY KEY (`group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `code` int(10) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'India'),(2,'Pakistan'),(3,'Australia');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `to_user_name` varchar(25) NOT NULL,
  `from_user_name` varchar(25) NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `message_body` text,
  `date` datetime NOT NULL,
  `status` decimal(10,0) NOT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration` (
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `user_name` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `sec_question` varchar(100) DEFAULT NULL,
  `answer` varchar(100) DEFAULT NULL,
  `recovery_email` varchar(25) DEFAULT NULL,
  `location` decimal(3,0) NOT NULL,
  `dob` datetime DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES ('Lijith','Patoli','lijith','patoli','a','a','a','1','1986-07-08 00:00:00'),('rohit','g bal','rohit','rgb','rgb','rgb','rgb','1','1988-05-31 00:00:00'),('Sidhartthan','PV','sidharthan','12345','asd','asd','pvsidharthan@gmail.com','1','1990-01-14 00:00:00');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-05-29 14:28:35
