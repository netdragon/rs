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

CREATE TABLE `zhshzy` (
  `zyid` int(11) NOT NULL AUTO_INCREMENT,
  `zymc` char(20) DEFAULT NULL,
  `type` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`zyid`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='招生专业';

CREATE TABLE `sqbkly` (
  `mc` char(20) DEFAULT NULL,
  PRIMARY KEY (`mc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='申请报考理由';


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
) ENGINE=InnoDB AUTO_INCREMENT=1908 DEFAULT CHARSET=utf8 COMMENT='用户表';

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
  `bmsj` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `shhqk` tinyint(4) DEFAULT NULL,
  `shhyj` varchar(200) DEFAULT NULL,
  `sflq` tinyint(4) DEFAULT NULL,
  `lqzy` varchar(20) DEFAULT NULL,
  `kszp` varchar(60) DEFAULT NULL,
  `mmxm` varchar(100) DEFAULT NULL,
  `mmgzdw` varchar(200) DEFAULT NULL,
  `sqly` varchar(200) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1466 DEFAULT CHARSET=utf8 COMMENT='报名信息';

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
) ENGINE=InnoDB AUTO_INCREMENT=4030 DEFAULT CHARSET=utf8;
CREATE TABLE `hdqk` (
  `hdqkid` int(11) NOT NULL AUTO_INCREMENT,
  `hdsj` date DEFAULT NULL,
  `hdmc` varchar(200) DEFAULT NULL,
  `brjsgx` varchar(300) DEFAULT NULL,
  `bmxxid` int(11) DEFAULT NULL,
  PRIMARY KEY (`hdqkid`),
  UNIQUE KEY `shgzjlid_UNIQUE` (`hdqkid`)
) ENGINE=InnoDB AUTO_INCREMENT=13588 DEFAULT CHARSET=utf8;
CREATE TABLE `hjqk` (
  `hjqkid` int(11) NOT NULL AUTO_INCREMENT,
  `bmxxid` int(11) NOT NULL,
  `hjsj` date DEFAULT NULL,
  `hjmc` varchar(200) DEFAULT NULL,
  `jsjb` varchar(100) DEFAULT NULL,
  `hjdj` varchar(120) DEFAULT NULL,
  `sjbm` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`hjqkid`)
) ENGINE=InnoDB AUTO_INCREMENT=13592 DEFAULT CHARSET=utf8;
CREATE TABLE `kemu` (
  `kmid` int(11) NOT NULL AUTO_INCREMENT,
  `kmmc` varchar(50) DEFAULT NULL,
  `ksrq` date DEFAULT NULL,
  `kssj` char(5) DEFAULT NULL,
  `jssj` char(5) DEFAULT NULL,
  PRIMARY KEY (`kmid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
CREATE TABLE `score` (
  `kmid` int(11) NOT NULL,
  `bmxxid` int(11) NOT NULL,
  `fenshu` float DEFAULT NULL,
  `lrcjsj` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`kmid`,`bmxxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21112 DEFAULT CHARSET=utf8;
CREATE TABLE `system_settings` (
  `item` varchar(50) NOT NULL DEFAULT '',
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


LOCK TABLES `system_settings` WRITE;
INSERT INTO `system_settings`(item, value) VALUES ('isPublic_Admission','0'),('isPublic_Admit','0'),('isPublic_Audit','0'),('isPublic_ScoreExtra','0'),('isPublic_Score','0'),('regEndDate','2017-1-1'),('regStartDate','2016-10-10');
UNLOCK TABLES;


LOCK TABLES `kemu` WRITE;
INSERT INTO `kemu`(kmid,kmmc,ksrq,kssj,jssj) VALUES (1,'笔试',now(),'8:00','20:00'),(2,'面试',now(),'8:00','20:00');
UNLOCK TABLES;


LOCK TABLES `user` WRITE;
INSERT INTO `user` VALUES (0,'administrator','8a185c7b560fb9a2',now(),'127.0.0.1','dddd@ddd.dd','您的出生地是?','bjbjbj',1);
UNLOCK TABLES;

LOCK TABLES `zhshzy` WRITE;
INSERT INTO `zhshzy`(zymc, type) VALUES ('',-1),('地质工程',0),('勘查技术与工程',0),('石油工程',0),('油气储运工程',0),('船舶与海洋工程',0),('化学工程与工艺',0),('环境工程',0),('过程装备与控制工程',0),('机械设计制造及其自动化',0),('材料科学与工程',0),('自动化',0),('安全工程',0),('测控技术与仪器',0),('计算机科学与技术',0),('环境科学',0),('应用化学',0),('数学与应用数学',0),('信息管理与信息系统',0),('市场营销',0),('会计学',0),('财务管理',0),('国际经济与贸易',0),('市场营销',1),('会计学',1),('财务管理',1),('国际经济与贸易',1),('英语',1),('热能',0);
UNLOCK TABLES;
LOCK TABLES `sqbkly` WRITE;
INSERT INTO `sqbkly`(mc) VALUES ('数学特长'),('外语特长'),('物理特长'),('化学特长'),('艺术特长');
UNLOCK TABLES;