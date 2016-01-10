-- MySQL dump 10.13  Distrib 5.1.46, for Win32 (ia32)
--
-- Host: localhost    Database: cup
-- ------------------------------------------------------
-- Server version	5.1.46-community-log

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
-- Table structure for table `attach_file`
--

DROP TABLE IF EXISTS `attach_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attach_file` (
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `size` int(11) DEFAULT NULL,
  `catalog` varchar(50) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `uuid` varchar(60) NOT NULL DEFAULT '',
  `path` varchar(200) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attach_file`
--

LOCK TABLES `attach_file` WRITE;
/*!40000 ALTER TABLE `attach_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `attach_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bkzy`
--

DROP TABLE IF EXISTS `bkzy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bkzy` (
  `zyid` int(11) NOT NULL,
  `bmxxid` int(11) NOT NULL,
  `tjf` tinyint(4) DEFAULT NULL,
  `xh` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`zyid`,`bmxxid`,`xh`),
  KEY `bmxx_bkzy_FK1` (`bmxxid`),
  CONSTRAINT `bmxx_bkzy_FK1` FOREIGN KEY (`bmxxid`) REFERENCES `bmxx` (`bmxxid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `zhshzy_bkzy_FK1` FOREIGN KEY (`zyid`) REFERENCES `zhshzy` (`zyid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bkzy`
--

LOCK TABLES `bkzy` WRITE;
/*!40000 ALTER TABLE `bkzy` DISABLE KEYS */;
INSERT INTO `bkzy` VALUES (1,5,1,1),(1,10,1,1),(2,10,1,2),(3,4,1,1),(5,8,1,3),(7,6,1,4),(8,6,1,5),(9,6,1,3),(10,8,1,2),(12,6,1,1),(12,8,1,1),(13,6,1,2),(15,7,1,2),(15,9,1,3),(16,7,1,5),(16,9,1,1),(17,9,1,4),(18,7,1,1),(18,9,1,2);
/*!40000 ALTER TABLE `bkzy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bmxx`
--

DROP TABLE IF EXISTS `bmxx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bmxx` (
  `bmxxid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `ksxm` varchar(100) DEFAULT NULL,
  `ksxb` tinyint(4) DEFAULT NULL,
  `wyyz` varchar(50) DEFAULT NULL,
  `jg` varchar(200) DEFAULT NULL,
  `mz` varchar(100) DEFAULT NULL,
  `zzmm` char(20) DEFAULT NULL,
  `zxmc` varchar(200) DEFAULT NULL,
  `kskl` varchar(10) DEFAULT NULL,
  `shfzh` char(18) DEFAULT NULL,
  `ksshji` varchar(100) DEFAULT NULL,
  `fmxm` varchar(100) DEFAULT NULL,
  `fmgzdw` varchar(200) DEFAULT NULL,
  `fmzw` varchar(100) DEFAULT NULL,
  `fmyddh` varchar(100) DEFAULT NULL,
  `mmzw` varchar(100) DEFAULT NULL,
  `txdz` varchar(300) DEFAULT NULL,
  `mmyddh` varchar(100) DEFAULT NULL,
  `yzbm` char(10) DEFAULT NULL,
  `shxr` varchar(100) DEFAULT NULL,
  `bmsj` timestamp NULL DEFAULT NULL,
  `shhqk` tinyint(4) DEFAULT NULL,
  `shhyj` varchar(200) DEFAULT NULL,
  `sflq` tinyint(4) DEFAULT NULL,
  `lqzy` varchar(20) DEFAULT NULL,
  `kszp` varchar(60) DEFAULT NULL,
  `mmxm` varchar(100) DEFAULT NULL,
  `mmgzdw` varchar(200) DEFAULT NULL,
  `sqly` varchar(50) DEFAULT NULL,
  `sfjbmf` tinyint(4) DEFAULT '0',
  `zhkzhid` char(10) DEFAULT NULL,
  `kch` int(11) DEFAULT '0',
  `zongfen` float DEFAULT '0',
  `ksah` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`bmxxid`),
  UNIQUE KEY `shfzh_UNIQUE` (`shfzh`),
  UNIQUE KEY `zhkzhid_UNIQUE` (`zhkzhid`),
  KEY `user_bmxx_FK1` (`userid`),
  KEY `user_attach_FK1` (`kszp`),
  CONSTRAINT `user_attach_FK1` FOREIGN KEY (`kszp`) REFERENCES `attach_file` (`uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_bmxx_FK1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='报名信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bmxx`
--

LOCK TABLES `bmxx` WRITE;
/*!40000 ALTER TABLE `bmxx` DISABLE KEYS */;
INSERT INTO `bmxx` VALUES (4,1911,'liusuzhuanb',1,'英语','甘肃','东乡族','中共预备党员','kd','文史','736363636383993020','dkd','','','','','','jd','','kjdkd','jdkd','2013-12-22 14:12:11',1,'',1,'工商管理类（文）',NULL,'','','5',1,'2013020001',0,0,''),(5,1913,'liusuzhuand',0,'英语','湖北','汉族','中共党员','djkdkd中学名称','理工','736367548696904848','383883','','','fzw','','mzw','知书邮寄地知书邮寄地','','7383','wdk','2013-12-22 14:12:11',1,'',1,'工商管理类（理）',NULL,'','','4',1,'2013050001',0,0,''),(6,1914,'liusuzhuane',1,'英语','福建','汉族','中共预备党员','知书邮寄地知书邮寄地知书邮寄地知书邮寄地','理工','766474728383939292','7383','','','','','','hdh知书邮寄地知书邮寄地','','知书邮寄地','知书邮寄地','2013-12-22 14:12:11',1,'',1,'自动化',NULL,'','','2',1,'2013050002',0,0,''),(7,1915,'liusuzhuanf',1,'英语','青海','汉族','共青团员','中学名称','理工','763519037365563738','83','竞赛','中阶段获省市级以上荣誉称号和竞赛','','','','地址','','右','顺','2013-12-22 14:12:11',1,'',1,'应用化学',NULL,'中号和竞赛','中阶段获省市级以上荣誉称号和竞赛','1',1,'2013050003',0,0,''),(8,1916,'teste',1,'英语','北京','汉族','共青团员','kdddddddddddd','理工','333333333333333338','dsfsdfs','','','','','','sdfsdfsd','','dfsdfs','dfdsfs','2013-12-22 14:23:26',1,'',1,'油气储运工程',NULL,'','','2',1,'2013050004',0,0,''),(9,1910,'liusuzhuana',1,'英语','北京','汉族','共青团员','mingcheng','理工','478493939030300399','dfd','','','','','','fd','','fdd','dfd','2013-12-23 00:11:45',1,'',NULL,NULL,NULL,'','','1',0,NULL,0,0,''),(10,1918,'d',1,'英语','北京','汉族','共青团员','f','理工','674889899393090303','f','','','fzw','','mzw','f','','f','f','2013-12-27 06:48:12',NULL,NULL,NULL,NULL,NULL,'','','4',0,NULL,0,0,'');
/*!40000 ALTER TABLE `bmxx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cjjd`
--

DROP TABLE IF EXISTS `cjjd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cjjd` (
  `cjjdid` int(11) NOT NULL AUTO_INCREMENT,
  `bmxxid` int(11) DEFAULT NULL,
  `zxtxdz` varchar(200) DEFAULT NULL,
  `zxjb` varchar(30) DEFAULT NULL,
  `zxybm` char(10) DEFAULT NULL,
  `zxlxdh` varchar(100) DEFAULT NULL,
  `njfzr` varchar(50) DEFAULT NULL,
  `gysyw` varchar(20) DEFAULT NULL,
  `gyssx` varchar(20) DEFAULT NULL,
  `gyswy` varchar(20) DEFAULT NULL,
  `gyswl` varchar(20) DEFAULT NULL,
  `gyshx` varchar(20) DEFAULT NULL,
  `gyssw` varchar(20) DEFAULT NULL,
  `gysls` varchar(20) DEFAULT NULL,
  `gyszz` varchar(20) DEFAULT NULL,
  `gysdl` varchar(20) DEFAULT NULL,
  `gysty` varchar(20) DEFAULT NULL,
  `gyszf` varchar(20) DEFAULT NULL,
  `gysbjmc` int(11) DEFAULT NULL,
  `gysbjrs` int(11) DEFAULT NULL,
  `gysnjmc` int(11) DEFAULT NULL,
  `gysnjrs` int(11) DEFAULT NULL,
  `gyxyw` varchar(20) DEFAULT NULL,
  `gyxsx` varchar(20) DEFAULT NULL,
  `gyxwy` varchar(20) DEFAULT NULL,
  `gyxwl` varchar(20) DEFAULT NULL,
  `gyxhx` varchar(20) DEFAULT NULL,
  `gyxsw` varchar(20) DEFAULT NULL,
  `gyxls` varchar(20) DEFAULT NULL,
  `gyxzz` varchar(20) DEFAULT NULL,
  `gyxdl` varchar(20) DEFAULT NULL,
  `gyxty` varchar(20) DEFAULT NULL,
  `gyxzf` varchar(20) DEFAULT NULL,
  `gyxbjmc` int(11) DEFAULT NULL,
  `gyxbjrs` int(11) DEFAULT NULL,
  `gyxnjmc` int(11) DEFAULT NULL,
  `gyxnjrs` int(11) DEFAULT NULL,
  `gesyw` varchar(20) DEFAULT NULL,
  `gessx` varchar(20) DEFAULT NULL,
  `geswy` varchar(20) DEFAULT NULL,
  `geswl` varchar(20) DEFAULT NULL,
  `geshx` varchar(20) DEFAULT NULL,
  `gessw` varchar(20) DEFAULT NULL,
  `gesls` varchar(20) DEFAULT NULL,
  `geszz` varchar(20) DEFAULT NULL,
  `gesdl` varchar(20) DEFAULT NULL,
  `gesty` varchar(20) DEFAULT NULL,
  `geszf` varchar(20) DEFAULT NULL,
  `gesbjmc` int(11) DEFAULT NULL,
  `gesbjrs` int(11) DEFAULT NULL,
  `gesnjmc` int(11) DEFAULT NULL,
  `gesnjrs` int(11) DEFAULT NULL,
  `gexyw` varchar(20) DEFAULT NULL,
  `gexsx` varchar(20) DEFAULT NULL,
  `gexwy` varchar(20) DEFAULT NULL,
  `gexwl` varchar(20) DEFAULT NULL,
  `gexhx` varchar(20) DEFAULT NULL,
  `gexsw` varchar(20) DEFAULT NULL,
  `gexls` varchar(20) DEFAULT NULL,
  `gexzz` varchar(20) DEFAULT NULL,
  `gexdl` varchar(20) DEFAULT NULL,
  `gexty` varchar(20) DEFAULT NULL,
  `gexzf` varchar(20) DEFAULT NULL,
  `gexbjmc` int(11) DEFAULT NULL,
  `gexbjrs` int(11) DEFAULT NULL,
  `gexnjmc` int(11) DEFAULT NULL,
  `gexnjrs` int(11) DEFAULT NULL,
  `gssyw` varchar(20) DEFAULT NULL,
  `gsssx` varchar(20) DEFAULT NULL,
  `gsswy` varchar(20) DEFAULT NULL,
  `gsswl` varchar(20) DEFAULT NULL,
  `gsshx` varchar(20) DEFAULT NULL,
  `gsssw` varchar(20) DEFAULT NULL,
  `gssls` varchar(20) DEFAULT NULL,
  `gsszz` varchar(20) DEFAULT NULL,
  `gssdl` varchar(20) DEFAULT NULL,
  `gssty` varchar(20) DEFAULT NULL,
  `gsszf` varchar(20) DEFAULT NULL,
  `gssbjmc` int(11) DEFAULT NULL,
  `gssbjrs` int(11) DEFAULT NULL,
  `gssnjmc` int(11) DEFAULT NULL,
  `gssnjrs` int(11) DEFAULT NULL,
  `hkyw` varchar(20) DEFAULT NULL,
  `hksx` varchar(20) DEFAULT NULL,
  `hkwy` varchar(20) DEFAULT NULL,
  `hkwl` varchar(20) DEFAULT NULL,
  `hkhx` varchar(20) DEFAULT NULL,
  `hksw` varchar(20) DEFAULT NULL,
  `hkls` varchar(20) DEFAULT NULL,
  `hkzz` varchar(20) DEFAULT NULL,
  `hkdl` varchar(20) DEFAULT NULL,
  `hkty` varchar(20) DEFAULT NULL,
  `hkzf` varchar(20) DEFAULT NULL,
  `hkbjmc` int(11) DEFAULT NULL,
  `hkbjrs` int(11) DEFAULT NULL,
  `hknjmc` int(11) DEFAULT NULL,
  `hknjrs` int(11) DEFAULT NULL,
  `zjyw` varchar(20) DEFAULT NULL,
  `zjsx` varchar(20) DEFAULT NULL,
  `zjwy` varchar(20) DEFAULT NULL,
  `zjwl` varchar(20) DEFAULT NULL,
  `zjhx` varchar(20) DEFAULT NULL,
  `zjsw` varchar(20) DEFAULT NULL,
  `zjls` varchar(20) DEFAULT NULL,
  `zjzz` varchar(20) DEFAULT NULL,
  `zjdl` varchar(20) DEFAULT NULL,
  `zjty` varchar(20) DEFAULT NULL,
  `zjzf` varchar(20) DEFAULT NULL,
  `zjbjmc` int(11) DEFAULT NULL,
  `zjbjrs` int(11) DEFAULT NULL,
  `zjnjmc` int(11) DEFAULT NULL,
  `zjnjrs` int(11) DEFAULT NULL,
  `bzrpj` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`cjjdid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cjjd`
--

LOCK TABLES `cjjd` WRITE;
/*!40000 ALTER TABLE `cjjd` DISABLE KEYS */;
INSERT INTO `cjjd` VALUES (3,7,'中阶段获省市级以上荣誉称号和竞赛','省级示范性高中','白','6474','打交道','1','1','1','1','1','1','1','1','1','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'1','1','1','1','1','1','1','1','1','1','1',1,111,111,1,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'中阶段获省市级以上荣誉称号和竞赛中阶段获省市级以上荣誉称号和竞赛中阶段获省段获省和竞赛\r\n中阶段获省市级以上荣誉称号和竞赛中阶段获省市级以上荣誉称号和竞赛。中阶段获省市级以'),(5,9,'dfd','省级示范性高中','df','d','df','1','1','1','1','1','1','1','1','1','1','1',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'该生是我校高中应届毕业生，以上材料全部属实，同意报考。若有虚假，我校愿意承担后果'),(6,10,'f','其它','gf','j','f','','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'','','','','','','','','','','',0,0,0,0,'fff');
/*!40000 ALTER TABLE `cjjd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hdqk`
--

DROP TABLE IF EXISTS `hdqk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hdqk` (
  `hdqkid` int(11) NOT NULL AUTO_INCREMENT,
  `hdsj` date DEFAULT NULL,
  `hdmc` varchar(200) DEFAULT NULL,
  `brjsgx` varchar(300) DEFAULT NULL,
  `bmxxid` int(11) DEFAULT NULL,
  PRIMARY KEY (`hdqkid`),
  UNIQUE KEY `shgzjlid_UNIQUE` (`hdqkid`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hdqk`
--

LOCK TABLES `hdqk` WRITE;
/*!40000 ALTER TABLE `hdqk` DISABLE KEYS */;
INSERT INTO `hdqk` VALUES (43,NULL,'','',4),(44,NULL,'','',4),(45,NULL,'','',4),(61,NULL,'','',5),(62,NULL,'','',5),(63,NULL,'','',5),(82,NULL,'','',6),(83,NULL,'','',6),(84,NULL,'','',6),(88,NULL,'中阶段获省市级以上荣誉称号和竞赛','',7),(89,NULL,'','',7),(90,NULL,'','',7),(94,NULL,'','',8),(95,NULL,'','',8),(96,NULL,'','',8),(103,NULL,'','',9),(104,NULL,'','',9),(105,NULL,'','',9),(106,NULL,'','',10),(107,NULL,'','',10),(108,NULL,'','',10);
/*!40000 ALTER TABLE `hdqk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hjqk`
--

DROP TABLE IF EXISTS `hjqk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hjqk` (
  `hjqkid` int(11) NOT NULL AUTO_INCREMENT,
  `bmxxid` int(11) NOT NULL,
  `hjsj` date DEFAULT NULL,
  `hjmc` varchar(200) DEFAULT NULL,
  `jsjb` varchar(100) DEFAULT NULL,
  `hjdj` varchar(120) DEFAULT NULL,
  `sjbm` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`hjqkid`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hjqk`
--

LOCK TABLES `hjqk` WRITE;
/*!40000 ALTER TABLE `hjqk` DISABLE KEYS */;
INSERT INTO `hjqk` VALUES (43,4,NULL,'','','',''),(44,4,NULL,'','','',''),(45,4,NULL,'','','',''),(61,5,NULL,'','','',''),(62,5,NULL,'','','',''),(63,5,NULL,'','','',''),(82,6,NULL,'','','',''),(83,6,NULL,'','','',''),(84,6,NULL,'','','',''),(88,7,NULL,'中阶段获省市级以上荣誉称号和竞赛','','',''),(89,7,NULL,'','','',''),(90,7,NULL,'','','',''),(94,8,NULL,'','','',''),(95,8,NULL,'','','',''),(96,8,NULL,'','','',''),(103,9,NULL,'','','',''),(104,9,NULL,'','','',''),(105,9,NULL,'','','',''),(106,10,NULL,'','','',''),(107,10,NULL,'','','',''),(108,10,NULL,'','','','');
/*!40000 ALTER TABLE `hjqk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemu`
--

DROP TABLE IF EXISTS `kemu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kemu` (
  `kmid` int(11) NOT NULL AUTO_INCREMENT,
  `kmmc` varchar(50) DEFAULT NULL,
  `kmlxid` int(11) NOT NULL,
  PRIMARY KEY (`kmid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemu`
--

LOCK TABLES `kemu` WRITE;
/*!40000 ALTER TABLE `kemu` DISABLE KEYS */;
INSERT INTO `kemu` VALUES (1,'笔试科目一',1),(10,'面试',2);
/*!40000 ALTER TABLE `kemu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemulx`
--

DROP TABLE IF EXISTS `kemulx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kemulx` (
  `lxid` smallint(6) NOT NULL,
  `lxmc` varchar(45) DEFAULT NULL,
  `ksrq` date DEFAULT NULL,
  `kssj` varchar(20) DEFAULT NULL,
  `jssj` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`lxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemulx`
--

LOCK TABLES `kemulx` WRITE;
/*!40000 ALTER TABLE `kemulx` DISABLE KEYS */;
INSERT INTO `kemulx` VALUES (1,'笔试','2014-03-02','9:0','11:0'),(2,'面试','2014-03-02','13:0','20:0');
/*!40000 ALTER TABLE `kemulx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score`
--

DROP TABLE IF EXISTS `score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `score` (
  `kmid` int(11) NOT NULL,
  `bmxxid` int(11) NOT NULL,
  `fenshu` varchar(20) DEFAULT NULL,
  `lrcjsj` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`kmid`,`bmxxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score`
--

LOCK TABLES `score` WRITE;
/*!40000 ALTER TABLE `score` DISABLE KEYS */;
INSERT INTO `score` VALUES (1,4,'4','2013-12-22 14:28:34'),(1,5,'4','2013-12-22 14:28:34'),(1,6,'4','2013-12-22 14:28:34'),(1,7,'4','2013-12-22 14:28:34'),(1,8,'4','2013-12-22 14:28:34'),(10,4,'7','2013-12-22 14:28:34'),(10,5,'7','2013-12-22 14:28:34'),(10,6,'7','2013-12-22 14:28:34'),(10,7,'7','2013-12-22 14:28:34'),(10,8,'7','2013-12-22 14:28:34');
/*!40000 ALTER TABLE `score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sqbkly`
--

DROP TABLE IF EXISTS `sqbkly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sqbkly` (
  `mc` char(20) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mc_UNIQUE` (`mc`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='申请报考理由';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sqbkly`
--

LOCK TABLES `sqbkly` WRITE;
/*!40000 ALTER TABLE `sqbkly` DISABLE KEYS */;
INSERT INTO `sqbkly` VALUES ('理工一',1,1),('理工二',2,1),('经济管理类(理)',4,1),('经济管理类(文)',5,0);
/*!40000 ALTER TABLE `sqbkly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14413 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
INSERT INTO `sys_log` VALUES (14143,'administrator 增加了招生专业。','2013-12-22 02:10:33'),(14144,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 02:10:54'),(14145,'administrator 修改系统参数设置。','2013-12-22 02:11:33'),(14146,'chenchen 登录系统, IP:127.0.0.1','2013-12-22 02:12:45'),(14147,'chenchen 登录系统, IP:127.0.0.1','2013-12-22 02:14:39'),(14148,'administrator 修改系统参数设置。','2013-12-22 02:18:32'),(14149,'administrator 删除了考试科目。','2013-12-22 02:18:40'),(14150,'administrator 修改考生分数。','2013-12-22 02:20:02'),(14151,'chenchen 登录系统, IP:127.0.0.1','2013-12-22 02:27:38'),(14152,'chenchen 登录系统, IP:127.0.0.1','2013-12-22 02:31:23'),(14153,'chenchen 登录系统, IP:127.0.0.1','2013-12-22 02:33:52'),(14154,'administrator 登录系统, IP:127.0.0.1','2013-12-22 02:53:14'),(14155,'administrator 登录系统, IP:127.0.0.1','2013-12-22 02:53:59'),(14156,'administrator 修改系统参数设置。','2013-12-22 02:54:37'),(14157,'liusuzhuane 登录系统, IP:127.0.0.1','2013-12-22 02:55:18'),(14158,'liusuzhuane 填写报名表。','2013-12-22 02:56:25'),(14159,'administrator 登录系统, IP:127.0.0.1','2013-12-22 02:56:48'),(14160,'administrator 进行考生初审。','2013-12-22 02:59:57'),(14161,'administrator 确认考生交费。','2013-12-22 03:01:00'),(14162,'administrator 生成准考证。','2013-12-22 03:01:07'),(14163,'administrator 修改考生分数。','2013-12-22 03:03:40'),(14164,'liusuzhuane 登录系统, IP:127.0.0.1','2013-12-22 03:06:13'),(14165,'administrator 调剂录取考生。','2013-12-22 03:07:05'),(14166,'administrator 调剂录取考生。','2013-12-22 03:07:13'),(14167,'administrator 调剂录取考生。','2013-12-22 03:07:29'),(14168,'administrator 调剂录取考生。','2013-12-22 03:07:46'),(14169,'administrator 调剂录取考生。','2013-12-22 03:07:56'),(14170,'administrator 重置发布标志。','2013-12-22 03:08:49'),(14171,'administrator 登录系统, IP:127.0.0.1','2013-12-22 03:35:30'),(14172,'administrator 登录系统, IP:127.0.0.1','2013-12-22 03:44:51'),(14173,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:00:51'),(14174,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:09:10'),(14175,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:12:27'),(14176,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:17:39'),(14177,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:19:08'),(14178,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:24:18'),(14179,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:33:35'),(14180,'administrator 调剂录取考生。','2013-12-22 04:34:04'),(14181,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:35:48'),(14182,'administrator 调剂录取考生。','2013-12-22 04:37:05'),(14183,'administrator 进行考生录取。','2013-12-22 04:37:11'),(14184,'administrator 调剂录取考生。','2013-12-22 04:37:18'),(14185,'administrator 调剂录取考生。','2013-12-22 04:41:35'),(14186,'administrator 调剂录取考生。','2013-12-22 04:41:43'),(14187,'liusuzhuanb 登录系统, IP:127.0.0.1','2013-12-22 04:42:12'),(14188,'administrator 重置发布标志。','2013-12-22 04:44:25'),(14189,'administrator 进行考生录取。','2013-12-22 04:44:35'),(14190,'administrator 重置发布标志。','2013-12-22 04:44:52'),(14191,'administrator 调剂录取考生。','2013-12-22 04:45:12'),(14192,'administrator 调剂录取考生。','2013-12-22 04:45:17'),(14193,'administrator 调剂录取考生。','2013-12-22 04:45:24'),(14194,'liusuzhuanc 登录系统, IP:127.0.0.1','2013-12-22 04:45:59'),(14195,'liusuzhuanc 登录系统, IP:127.0.0.1','2013-12-22 04:49:43'),(14196,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:50:33'),(14197,'administrator 重置发布标志。','2013-12-22 04:50:53'),(14198,'administrator 调剂录取考生。','2013-12-22 04:51:08'),(14199,'liusuzhuand 登录系统, IP:127.0.0.1','2013-12-22 04:51:35'),(14200,'administrator 重置发布标志。','2013-12-22 04:52:21'),(14201,'administrator 登录系统, IP:127.0.0.1','2013-12-22 04:53:44'),(14202,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 05:02:48'),(14203,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 05:04:44'),(14204,'liusuzhuane 登录系统, IP:127.0.0.1','2013-12-22 05:05:39'),(14205,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 05:06:21'),(14206,'liusuzhuanb 登录系统, IP:127.0.0.1','2013-12-22 05:07:03'),(14207,'administrator 登录系统, IP:127.0.0.1','2013-12-22 06:08:22'),(14208,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 06:09:51'),(14209,'administrator 进行了系统备份。','2013-12-22 06:18:26'),(14210,'liusuzhuanb 登录系统, IP:127.0.0.1','2013-12-22 06:22:32'),(14211,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 06:22:54'),(14212,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 06:31:53'),(14213,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 06:40:06'),(14214,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 06:42:07'),(14215,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 06:43:51'),(14216,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 06:45:19'),(14217,'administrator 登录系统, IP:127.0.0.1','2013-12-22 06:45:37'),(14218,'administrator 重置发布标志。','2013-12-22 06:45:44'),(14219,'liusuzhuanf 填写报名表。','2013-12-22 06:46:36'),(14220,'liusuzhuanf 填写成绩鉴定表。','2013-12-22 06:47:42'),(14221,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 06:49:33'),(14222,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 06:52:01'),(14223,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 06:53:31'),(14224,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 06:57:09'),(14225,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 07:00:42'),(14226,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 07:04:46'),(14227,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 07:07:19'),(14228,'liusuzhuanf 填写成绩鉴定表。','2013-12-22 07:08:11'),(14229,'liusuzhuanf 填写成绩鉴定表。','2013-12-22 07:09:26'),(14230,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 07:12:19'),(14231,'liusuzhuang 登录系统, IP:127.0.0.1','2013-12-22 07:15:48'),(14232,'liusuzhuang 填写报名表。','2013-12-22 07:17:03'),(14233,'liusuzhuang 填写成绩鉴定表。','2013-12-22 07:18:13'),(14234,'liusuzhuang 填写成绩鉴定表。','2013-12-22 07:18:38'),(14235,'administrator 登录系统, IP:127.0.0.1','2013-12-22 07:20:02'),(14236,'administrator 登录系统, IP:127.0.0.1','2013-12-22 07:27:35'),(14237,'administrator 登录系统, IP:127.0.0.1','2013-12-22 07:42:17'),(14238,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 08:18:37'),(14239,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 08:22:48'),(14240,'administrator 登录系统, IP:127.0.0.1','2013-12-22 08:29:05'),(14241,'administrator 进行了系统初始化。','2013-12-22 08:31:31'),(14242,'administrator 登录系统, IP:127.0.0.1','2013-12-22 09:03:56'),(14243,'administrator 修改系统参数设置。','2013-12-22 09:06:23'),(14244,'administrator 增加了申请理由。','2013-12-22 09:07:00'),(14245,'administrator 增加了申请理由。','2013-12-22 09:07:10'),(14246,'administrator 增加了申请理由。','2013-12-22 09:07:25'),(14247,'administrator 修改了申请理由。','2013-12-22 09:08:34'),(14248,'administrator 增加了申请理由。','2013-12-22 09:08:54'),(14249,'administrator 增加了招生专业。','2013-12-22 09:09:50'),(14250,'administrator 增加了招生专业。','2013-12-22 09:10:03'),(14251,'administrator 增加了招生专业。','2013-12-22 09:10:16'),(14252,'administrator 增加了招生专业。','2013-12-22 09:10:27'),(14253,'administrator 增加了招生专业。','2013-12-22 09:10:54'),(14254,'administrator 增加了招生专业。','2013-12-22 09:11:28'),(14255,'administrator 增加了招生专业。','2013-12-22 10:37:49'),(14256,'administrator 增加了招生专业。','2013-12-22 10:38:19'),(14257,'administrator 增加了招生专业。','2013-12-22 10:38:47'),(14258,'administrator 增加了招生专业。','2013-12-22 10:39:13'),(14259,'administrator 增加了招生专业。','2013-12-22 10:39:26'),(14260,'administrator 增加了招生专业。','2013-12-22 10:39:33'),(14261,'administrator 增加了招生专业。','2013-12-22 10:39:49'),(14262,'administrator 增加了招生专业。','2013-12-22 10:40:00'),(14263,'administrator 增加了招生专业。','2013-12-22 10:40:33'),(14264,'administrator 增加了招生专业。','2013-12-22 10:40:46'),(14265,'administrator 增加了招生专业。','2013-12-22 10:40:56'),(14266,'administrator 增加了招生专业。','2013-12-22 10:41:07'),(14267,'administrator 登录系统, IP:127.0.0.1','2013-12-22 10:41:43'),(14268,'administrator 修改系统参数设置。','2013-12-22 10:41:51'),(14269,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 10:42:24'),(14270,'administrator 登录系统, IP:127.0.0.1','2013-12-22 10:44:53'),(14271,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 10:50:50'),(14272,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 10:54:01'),(14273,'administrator 登录系统, IP:127.0.0.1','2013-12-22 10:55:45'),(14274,'administrator 修改系统参数设置。','2013-12-22 10:56:19'),(14275,'administrator 登录系统, IP:127.0.0.1','2013-12-22 10:57:54'),(14276,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 10:59:30'),(14277,'administrator 登录系统, IP:127.0.0.1','2013-12-22 10:59:56'),(14278,'administrator 修改系统参数设置。','2013-12-22 11:00:04'),(14279,'administrator 填写报名表。','2013-12-22 11:02:00'),(14280,'administrator 填写成绩鉴定表。','2013-12-22 11:02:59'),(14281,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 11:17:54'),(14282,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 11:20:33'),(14283,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 11:23:41'),(14284,'administrator 登录系统, IP:127.0.0.1','2013-12-22 11:24:06'),(14285,'administrator 进行了系统初始化。','2013-12-22 11:24:14'),(14286,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 11:24:47'),(14287,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 11:32:50'),(14288,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 11:41:40'),(14289,'liusuzhuana 填写报名表。','2013-12-22 11:42:26'),(14290,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 11:58:19'),(14291,'liusuzhuana 填写报名表。','2013-12-22 11:58:48'),(14292,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 12:02:42'),(14293,'liusuzhuana 填写报名表。','2013-12-22 12:03:15'),(14294,'administrator 登录系统, IP:127.0.0.1','2013-12-22 12:03:40'),(14295,'administrator 进行考生初审。','2013-12-22 12:03:46'),(14296,'administrator 确认考生交费。','2013-12-22 12:03:54'),(14297,'administrator 生成准考证。','2013-12-22 12:04:02'),(14298,'administrator 修改考生分数。','2013-12-22 12:04:53'),(14299,'administrator 调剂录取考生。','2013-12-22 12:05:07'),(14300,'administrator 登录系统, IP:127.0.0.1','2013-12-22 12:13:30'),(14301,'administrator 修改系统参数设置。','2013-12-22 12:14:04'),(14302,'administrator 登录系统, IP:127.0.0.1','2013-12-22 12:16:50'),(14303,'administrator 登录系统, IP:127.0.0.1','2013-12-22 12:23:12'),(14304,'administrator 登录系统, IP:127.0.0.1','2013-12-22 12:25:55'),(14305,'administrator 修改了申请理由。','2013-12-22 12:26:03'),(14306,'administrator 修改了申请理由。','2013-12-22 12:26:29'),(14307,'administrator 增加了申请理由。','2013-12-22 12:26:52'),(14308,'administrator 删除了报考理由。','2013-12-22 12:26:56'),(14309,'administrator 修改了申请理由。','2013-12-22 12:27:12'),(14310,'administrator 修改了申请理由。','2013-12-22 12:27:52'),(14311,'administrator 修改了招生专业。','2013-12-22 12:28:54'),(14312,'administrator 修改了招生专业。','2013-12-22 12:29:01'),(14313,'administrator 增加了招生专业。','2013-12-22 12:29:08'),(14314,'administrator 登录系统, IP:127.0.0.1','2013-12-22 12:32:31'),(14315,'administrator 修改系统参数设置。','2013-12-22 12:38:30'),(14316,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 12:41:14'),(14317,'liusuzhuana 填写报名表。','2013-12-22 12:42:13'),(14318,'liusuzhuana 填写报名表。','2013-12-22 12:42:31'),(14319,'liusuzhuana 填写报名表。','2013-12-22 12:42:43'),(14320,'liusuzhuanb 登录系统, IP:127.0.0.1','2013-12-22 12:43:44'),(14321,'liusuzhuanb 填写报名表。','2013-12-22 12:44:34'),(14322,'liusuzhuanb 填写报名表。','2013-12-22 12:45:12'),(14323,'liusuzhuanb 填写报名表。','2013-12-22 12:45:30'),(14324,'liusuzhuanb 填写报名表。','2013-12-22 12:45:42'),(14325,'liusuzhuanb 填写报名表。','2013-12-22 12:45:52'),(14326,'liusuzhuanb 填写报名表。','2013-12-22 12:46:18'),(14327,'liusuzhuanb 填写报名表。','2013-12-22 12:46:30'),(14328,'administrator 登录系统, IP:127.0.0.1','2013-12-22 12:46:44'),(14329,'administrator 修改系统参数设置。','2013-12-22 12:47:04'),(14330,'administrator 删除了招生专业。','2013-12-22 12:47:19'),(14331,'administrator 修改系统参数设置。','2013-12-22 12:47:27'),(14332,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 12:47:43'),(14333,'liusuzhuana 填写报名表。','2013-12-22 12:48:15'),(14334,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-22 13:09:13'),(14335,'liusuzhuana 填写报名表。','2013-12-22 13:09:47'),(14336,'liusuzhuana 填写报名表。','2013-12-22 13:10:03'),(14337,'liusuzhuana 填写报名表。','2013-12-22 13:10:36'),(14338,'liusuzhuana 填写报名表。','2013-12-22 13:10:56'),(14339,'liusuzhuand 登录系统, IP:127.0.0.1','2013-12-22 13:16:56'),(14340,'liusuzhuand 填写报名表。','2013-12-22 13:17:54'),(14341,'liusuzhuane 登录系统, IP:127.0.0.1','2013-12-22 13:18:35'),(14342,'liusuzhuane 填写报名表。','2013-12-22 13:20:12'),(14343,'liusuzhuane 填写报名表。','2013-12-22 13:21:28'),(14344,'liusuzhuane 填写报名表。','2013-12-22 13:21:40'),(14345,'liusuzhuane 填写报名表。','2013-12-22 13:21:52'),(14346,'liusuzhuane 填写报名表。','2013-12-22 13:22:24'),(14347,'liusuzhuane 填写报名表。','2013-12-22 13:23:34'),(14348,'liusuzhuane 填写报名表。','2013-12-22 13:24:03'),(14349,'administrator 登录系统, IP:127.0.0.1','2013-12-22 13:24:29'),(14350,'administrator 删除考生信息。','2013-12-22 13:27:20'),(14351,'administrator 生成准考证。','2013-12-22 13:28:33'),(14352,'administrator 进行考生初审。','2013-12-22 13:28:39'),(14353,'administrator 确认考生交费。','2013-12-22 13:28:45'),(14354,'administrator 生成准考证。','2013-12-22 13:28:50'),(14355,'administrator 修改考生分数。','2013-12-22 13:33:41'),(14356,'administrator 进行考生录取。','2013-12-22 13:33:59'),(14357,'administrator 调剂录取考生。','2013-12-22 13:34:05'),(14358,'administrator 调剂录取考生。','2013-12-22 13:34:10'),(14359,'administrator 调剂录取考生。','2013-12-22 13:34:15'),(14360,'administrator 登录系统, IP:127.0.0.1','2013-12-22 13:43:31'),(14361,'administrator 登录系统, IP:127.0.0.1','2013-12-22 13:51:56'),(14362,'administrator 生成准考证。','2013-12-22 13:54:26'),(14363,'administrator 生成准考证。','2013-12-22 13:54:31'),(14364,'administrator 修改考生分数。','2013-12-22 14:00:09'),(14365,'administrator 调剂录取考生。','2013-12-22 14:00:33'),(14366,'liusuzhuanf 登录系统, IP:127.0.0.1','2013-12-22 14:01:59'),(14367,'liusuzhuanf 填写报名表。','2013-12-22 14:03:04'),(14368,'liusuzhuanf 填写报名表。','2013-12-22 14:04:26'),(14369,'liusuzhuanf 填写成绩鉴定表。','2013-12-22 14:05:58'),(14370,'liusuzhuanf 填写成绩鉴定表。','2013-12-22 14:07:34'),(14371,'administrator 登录系统, IP:127.0.0.1','2013-12-22 14:09:41'),(14372,'administrator 进行考生初审。','2013-12-22 14:09:48'),(14373,'administrator 确认考生交费。','2013-12-22 14:12:04'),(14374,'administrator 生成准考证。','2013-12-22 14:12:11'),(14375,'chenchen 登录系统, IP:127.0.0.1','2013-12-22 14:22:44'),(14376,'chenchen 填写报名表。','2013-12-22 14:23:26'),(14377,'administrator 登录系统, IP:127.0.0.1','2013-12-22 14:23:51'),(14378,'chenchen 填写报名表。','2013-12-22 14:24:56'),(14379,'administrator 进行考生初审。','2013-12-22 14:25:36'),(14380,'administrator 确认考生交费。','2013-12-22 14:25:44'),(14381,'administrator 生成准考证。','2013-12-22 14:25:48'),(14382,'administrator 修改考生分数。','2013-12-22 14:28:34'),(14383,'administrator 调剂录取考生。','2013-12-22 14:28:53'),(14384,'administrator 调剂录取考生。','2013-12-22 14:28:59'),(14385,'liusuzhuang 登录系统, IP:127.0.0.1','2013-12-22 14:30:59'),(14386,'administrator 重置发布标志。','2013-12-22 14:31:15'),(14387,'liusuzhuang 登录系统, IP:127.0.0.1','2013-12-22 14:36:08'),(14388,'administrator 登录系统, IP:127.0.0.1','2013-12-23 00:09:35'),(14389,'administrator 设置系统提示语','2013-12-23 00:09:55'),(14390,'administrator 设置系统提示语','2013-12-23 00:10:35'),(14391,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-23 00:10:53'),(14392,'liusuzhuana 填写报名表。','2013-12-23 00:11:45'),(14393,'administrator 登录系统, IP:127.0.0.1','2013-12-23 00:12:04'),(14394,'liusuzhuana 登录系统, IP:127.0.0.1','2013-12-23 00:12:29'),(14395,'liusuzhuana 填写成绩鉴定表。','2013-12-23 00:12:49'),(14396,'liusuzhuana 填写成绩鉴定表。','2013-12-23 00:13:19'),(14397,'liusuzhuana 填写报名表。','2013-12-23 00:14:54'),(14398,'liusuzhuana 填写报名表。','2013-12-23 00:15:24'),(14399,'administrator 登录系统, IP:127.0.0.1','2013-12-23 01:13:58'),(14400,'administrator 进行考生初审。','2013-12-23 01:14:33'),(14401,'administrator 进行了系统备份。','2013-12-23 01:33:08'),(14402,'administrator 登录系统, IP:127.0.0.1','2013-12-25 00:53:15'),(14403,'administrator 进行考生初审。','2013-12-25 00:53:28'),(14404,'administrator 进行了系统备份。','2013-12-25 00:53:39'),(14405,'administrator 登录系统, IP:127.0.0.1','2013-12-27 06:43:24'),(14406,'administrator 登录系统, IP:127.0.0.1','2013-12-27 06:46:14'),(14407,'liusuzhuan99 登录系统, IP:127.0.0.1','2013-12-27 06:47:46'),(14408,'liusuzhuan99 填写报名表。','2013-12-27 06:48:12'),(14409,'liusuzhuan99 填写成绩鉴定表。','2013-12-27 06:50:51'),(14410,'administrator 登录系统, IP:127.0.0.1','2013-12-27 06:53:05'),(14411,'liusuzhuan99 登录系统, IP:127.0.0.1','2013-12-27 06:55:01'),(14412,'administrator 登录系统, IP:127.0.0.1','2013-12-27 06:56:07');
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_settings`
--

DROP TABLE IF EXISTS `system_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_settings` (
  `item` varchar(50) NOT NULL DEFAULT '',
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_settings`
--

LOCK TABLES `system_settings` WRITE;
/*!40000 ALTER TABLE `system_settings` DISABLE KEYS */;
INSERT INTO `system_settings` VALUES ('admit_result_no','sss ory抱歉，抱歉抱歉你未抱歉抱歉抱歉抱歉抱歉抱歉通过中国石油大学（北京）自主选拔录取，但我们仍然认为你很优秀，希望你再接再厉，继续关注中国石油大学（北京）。顺祝高考顺利！aa'),('admit_result_yes','祝贺你！你已经通过中国石油大学（北京）自主选拔录取，可享受相关优惠政策。学校会尽快将预录取通知书（含专业）寄给你，祝你高考顺利！aa'),('audit_result_no','你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自你你没有通过自主选拔录没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录主选拔录你没有你没有通过自主选拔录通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录你没有通过自主选拔录'),('audit_result_yes','祝贺你！祝贺你！abcdbcdefgh jkabcdefghjkabc defghjkabcdefghjkabcdefg hjkabcde过自主选abcdefgjkabcdefghjkabc defghjkabcdefghjkabcdefghjkabcdefg hjkabcdefabcdefghjkabcdefghjka bcdefghjkabcdefghjk'),('isPublic_Admission','null'),('isPublic_Admit','null'),('isPublic_Audit','null'),('isPublic_Score','null'),('isPublic_ScoreExtra','null'),('regEndDate','2027-1-6'),('regStartDate','2013-12-14');
/*!40000 ALTER TABLE `system_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `userpwd` varchar(300) DEFAULT NULL,
  `reg_time` timestamp NULL DEFAULT NULL,
  `reg_ip` varchar(80) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `question` varchar(200) DEFAULT NULL,
  `answer` varchar(200) DEFAULT NULL,
  `admin` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1919 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1908,'administrator','8a185c7b560fb9a2','2012-12-04 00:46:00','127.0.0.1','dddd@ddd.dd','您的出生地是?','bjbjbj',1),(1910,'liusuzhuana','0809aa8849e19228','2013-12-22 11:24:38','127.0.0.1','','您母亲的生日是?','aaaaaa',0),(1911,'liusuzhuanb','0809aa8849e19228','2013-12-22 12:43:33','127.0.0.1','','您母亲的姓名是?','jjj',0),(1912,'liusuzhuanc','0809aa8849e19228','2013-12-22 13:09:02','127.0.0.1','','您母亲的姓名是?','df',0),(1913,'liusuzhuand','0809aa8849e19228','2013-12-22 13:16:44','127.0.0.1','','您母亲的姓名是?','dfk',0),(1914,'liusuzhuane','0809aa8849e19228','2013-12-22 13:18:24','127.0.0.1','','您母亲的姓名是?','ddf',0),(1915,'liusuzhuanf','0809aa8849e19228','2013-12-22 14:01:50','127.0.0.1','','您母亲的姓名是?','ddfk',0),(1916,'chenchen','0809aa8849e19228','2013-12-22 14:22:29','127.0.0.1','','您父亲的生日是?','aaaaaa',0),(1917,'liusuzhuang','0809aa8849e19228','2013-12-22 14:30:49','127.0.0.1','','您母亲的姓名是?','dfd',0),(1918,'liusuzhuan99','0809aa8849e19228','2013-12-27 06:47:35','127.0.0.1','','您母亲的姓名是?','aaaa',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zhshzy`
--

DROP TABLE IF EXISTS `zhshzy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zhshzy` (
  `zyid` int(11) NOT NULL AUTO_INCREMENT,
  `zymc` char(20) DEFAULT NULL,
  `type` int(11) DEFAULT '0',
  PRIMARY KEY (`zyid`),
  KEY `zy_sqly` (`type`),
  CONSTRAINT `zy_sqly` FOREIGN KEY (`type`) REFERENCES `sqbkly` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='招生专业';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zhshzy`
--

LOCK TABLES `zhshzy` WRITE;
/*!40000 ALTER TABLE `zhshzy` DISABLE KEYS */;
INSERT INTO `zhshzy` VALUES (1,'经济学（理）',4),(2,'工商管理类（理）',4),(3,'经济学（文）',5),(4,'工商管理类（文）',5),(5,'石油工程',2),(6,'资源勘查工程',2),(7,'油气储运工程',2),(8,'勘查技术与工程(物探)',2),(9,'勘查技术与工程(测井)',2),(10,'机械设计制造及其自动化',2),(11,'自动化',2),(12,'安全工程',2),(13,'过程装备与控制工程',2),(14,'海洋油气工程',2),(15,'化学工程与工艺',1),(16,'能源化学工程',1),(17,'应用化学',1),(18,'材料科学与工程',1);
/*!40000 ALTER TABLE `zhshzy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cup'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-10 13:36:07

