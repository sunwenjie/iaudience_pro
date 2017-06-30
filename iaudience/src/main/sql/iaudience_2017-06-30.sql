# ************************************************************
# Sequel Pro SQL dump
# Version 4529
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 10.11.60.201 (MySQL 5.6.34-log)
# Database: iaudience
# Generation Time: 2017-06-30 10:34:59 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account_balance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_balance`;

CREATE TABLE `account_balance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `unit` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `account_balance` WRITE;
/*!40000 ALTER TABLE `account_balance` DISABLE KEYS */;

INSERT INTO `account_balance` (`id`, `user_id`, `balance`, `unit`)
VALUES
	(1,1,9210.45,2);

/*!40000 ALTER TABLE `account_balance` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table account_blance_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_blance_record`;

CREATE TABLE `account_blance_record` (
  `id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '''1充值，2消费''',
  `amount` decimal(10,2) NOT NULL COMMENT '额度，与账户货币单位相同',
  `amount_unit` decimal(10,2) DEFAULT NULL COMMENT '消费时，与消费目标相同的额度',
  `unit` tinyint(1) DEFAULT NULL COMMENT '消费目标的货币单位',
  `remark` varchar(100) NOT NULL,
  `update_time` datetime NOT NULL,
  `balance_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_account_blance_record_account_balance1_idx` (`balance_id`),
  CONSTRAINT `fk_account_blance_record_account_balance1` FOREIGN KEY (`balance_id`) REFERENCES `account_balance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table app_activity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_activity`;

CREATE TABLE `app_activity` (
  `id` int(11) NOT NULL,
  `picture_url` varchar(1000) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `app_activity` WRITE;
/*!40000 ALTER TABLE `app_activity` DISABLE KEYS */;

INSERT INTO `app_activity` (`id`, `picture_url`, `create_time`)
VALUES
	(1,'http://imgs.woliwu.com/enterprise/xinfuli/images/ad_1_1483608383212.jpg@347h_1200w_1e','2017-03-23 12:20:02'),
	(2,'http://imgs.woliwu.com/enterprise/xinfuli/images/ad_2_1484191440136.jpg@347h_1200w_1e','2017-03-23 12:20:02'),
	(3,'http://imgs.woliwu.com/enterprise/demo/images/ad_2_1481683768865.jpg@347h_1200w_1e','2017-03-23 12:20:02'),
	(4,'http://imgs.woliwu.com/enterprise/xinfuli/images/ad_2_1482128987306.jpg@347h_1200w_1e','2017-03-23 12:20:02');

/*!40000 ALTER TABLE `app_activity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table app_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_category`;

CREATE TABLE `app_category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '默认的名称',
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `app_category` WRITE;
/*!40000 ALTER TABLE `app_category` DISABLE KEYS */;

INSERT INTO `app_category` (`id`, `name`, `enabled`)
VALUES
	(1,X'6941756469656E63652041707073',1),
	(2,X'694163636573732041707073',1),
	(3,X'694163746976652041707073',1),
	(4,X'69457870657269656E63652041707073',1),
	(5,X'694E7369676874732041707073',1);

/*!40000 ALTER TABLE `app_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table app_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_info`;

CREATE TABLE `app_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_key` varchar(36) NOT NULL,
  `app_secret` varchar(36) NOT NULL,
  `version` varchar(45) NOT NULL,
  `publisher_id` int(11) NOT NULL,
  `stars` tinyint(1) NOT NULL DEFAULT '5',
  `icon` varchar(1000) NOT NULL,
  `login_url` varchar(1000) DEFAULT NULL,
  `register_url` varchar(1000) DEFAULT NULL,
  `index_url` varchar(1000) NOT NULL,
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `update_time` datetime NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `update_content` text,
  `description` text,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `latest_version` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_app_info_app_category1_idx` (`category_id`),
  CONSTRAINT `fk_app_info_app_category1` FOREIGN KEY (`category_id`) REFERENCES `app_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `app_info` WRITE;
/*!40000 ALTER TABLE `app_info` DISABLE KEYS */;

INSERT INTO `app_info` (`id`, `app_key`, `app_secret`, `version`, `publisher_id`, `stars`, `icon`, `login_url`, `register_url`, `index_url`, `del`, `enabled`, `update_time`, `category_id`, `name`, `update_content`, `description`, `featured`, `latest_version`)
VALUES
	(1,'3743bf37d3e947c4a4702026573cfbac','69e5ff7c1ac711e793ae92361f002671','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',1,'3rd Party First','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.  Invidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',0,1),
	(2,'3743bf37d3e947c4a4702026573c1bac','69e5ff7c1ac211e793ae92361f002671','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',1,'3rd Party DMPs','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',1,1),
	(3,'2743bf37d3e947c4a4702026573c1bac','69e5ff7c1ac211e793ae92361f002673','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',2,'Brand Safety','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',0,1),
	(4,'4743bf37d3e947c4a4702026573c1bac','69e5ff7c1ac211e793ae92361f002674','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',3,'3rd Party DMPs','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',1,1),
	(5,'5743bf37d3e947c4a4702026573c1bac','69e5ff7c1ac211e793ae92361f002675','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',4,'Invalid Traffic','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',0,1),
	(6,'6743bf37d3e947c4a4702026573c1bac','69e5ff7c1ac211e793ae92361f002676','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',5,'3rd Party DMPs','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',0,1),
	(7,'7743bf37d3e947c4a4702026573c2bac','69e5ff7c1ac211e793ae92362f002677','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',4,'3rd Party Ad Serving','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',1,1),
	(8,'7743bf37d3e947c4a4702026573c3bac','69e5ff7c1ac211e793ae92363f002677','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',4,'3rd Party DMPs','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',0,1),
	(9,'7743bf37d3e947c4a4702026573c4bac','69e5ff7c1ac211e793ae92364f002677','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',5,'App Download Tracking','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',0,1),
	(10,'7743bf37d3e947c4a4702026573c5bac','69e5ff7c1ac211e793ae92365f002677','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',4,'3rd Party DMPs','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',0,1),
	(11,'7743bf37d3e947c4a4702026573c6bac','69e5ff7c1ac211e793ae92366f002677','1.0',1,3,'http://static.symphony.optimix.local/images/icon_conversions.png','https://yun.baidu.com/','https://passport.baidu.com/v2/?reg&u=http%3A%2F%2Fpan.baidu.com&regType=1&tpl=netdisk','http://www.baidu.com',0,1,'2017-03-20 10:00:00',5,'3rd Party Tracking','<p>New Updates</p> <p>1.0 Bug fixed</p> <a>...Read More</a>','The acronym PCALEC has a life path number 22.The path number tewnty-two is an master number with various vibrations. The most astounding and most capable figure that is extremely uncommon.\n\nInvidividuals with this number can defeat any deterrent.Your abilities are extremely adaptable and solid.',0,1);

/*!40000 ALTER TABLE `app_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table app_module_relation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_module_relation`;

CREATE TABLE `app_module_relation` (
  `app_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  KEY `fk_app_module_relation_app_info1_idx` (`app_id`),
  KEY `fk_app_module_relation_module1_idx` (`module_id`),
  CONSTRAINT `fk_app_module_relation_app_info1` FOREIGN KEY (`app_id`) REFERENCES `app_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_app_module_relation_module1` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `app_module_relation` WRITE;
/*!40000 ALTER TABLE `app_module_relation` DISABLE KEYS */;

INSERT INTO `app_module_relation` (`app_id`, `module_id`)
VALUES
	(1,1),
	(2,1),
	(3,2),
	(4,3),
	(5,4),
	(7,4),
	(8,4),
	(10,4),
	(6,5),
	(9,5),
	(11,5);

/*!40000 ALTER TABLE `app_module_relation` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table app_purchase_records
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_purchase_records`;

CREATE TABLE `app_purchase_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_strategy_id` int(11) NOT NULL,
  `purchase_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `app_purchase_records` WRITE;
/*!40000 ALTER TABLE `app_purchase_records` DISABLE KEYS */;

INSERT INTO `app_purchase_records` (`id`, `purchase_strategy_id`, `purchase_time`)
VALUES
	(1,1,'2017-04-12 08:05:51'),
	(4,5,'2017-04-13 08:13:14');

/*!40000 ALTER TABLE `app_purchase_records` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table app_purchase_strategy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_purchase_strategy`;

CREATE TABLE `app_purchase_strategy` (
  `id` int(11) NOT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `currency_unit` tinyint(1) DEFAULT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_app_ purchase_strategy_app_info1_idx` (`app_id`),
  CONSTRAINT `fk_app_ purchase_strategy_app_info1` FOREIGN KEY (`app_id`) REFERENCES `app_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `app_purchase_strategy` WRITE;
/*!40000 ALTER TABLE `app_purchase_strategy` DISABLE KEYS */;

INSERT INTO `app_purchase_strategy` (`id`, `type`, `num`, `price`, `currency_unit`, `app_id`)
VALUES
	(1,4,1,128.00,2,1),
	(2,4,3,359.00,2,1),
	(3,5,1,1200.00,2,1),
	(4,4,1,121.00,1,2),
	(5,4,3,352.00,1,2),
	(6,5,1,1100.00,1,2),
	(7,4,6,85.00,3,3),
	(8,5,1,160.00,3,3),
	(9,5,2,300.00,3,3),
	(10,0,0,0.00,1,4),
	(11,1,0,1000.00,3,5),
	(12,2,1000,100.00,1,6),
	(13,2,2000,190.00,1,6),
	(14,3,45,30.00,1,7),
	(15,3,100,60.00,1,7),
	(16,1,0,500.00,2,8),
	(17,4,1,128.00,2,9),
	(18,4,3,359.00,2,9),
	(19,5,1,1200.00,2,9),
	(20,4,3,300.00,1,10),
	(21,4,6,500.00,1,10),
	(22,5,1,1000.00,2,11);

/*!40000 ALTER TABLE `app_purchase_strategy` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table app_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_tag`;

CREATE TABLE `app_tag` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table app_tag_relation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_tag_relation`;

CREATE TABLE `app_tag_relation` (
  `tag_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  KEY `fk_app_tag_relation_app_tag1_idx` (`tag_id`),
  KEY `fk_app_tag_relation_app_info1_idx` (`app_id`),
  CONSTRAINT `fk_app_tag_relation_app_info1` FOREIGN KEY (`app_id`) REFERENCES `app_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_app_tag_relation_app_tag1` FOREIGN KEY (`tag_id`) REFERENCES `app_tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exchange_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exchange_rate`;

CREATE TABLE `exchange_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_unit` tinyint(1) NOT NULL,
  `to_unit` tinyint(1) NOT NULL,
  `rate` decimal(10,5) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exchange_rate` WRITE;
/*!40000 ALTER TABLE `exchange_rate` DISABLE KEYS */;

INSERT INTO `exchange_rate` (`id`, `from_unit`, `to_unit`, `rate`, `update_time`)
VALUES
	(1,1,2,1.12800,'2017-04-13 08:00:00'),
	(2,1,3,0.14520,'2017-04-13 08:00:00'),
	(3,2,1,0.88650,'2017-04-13 08:00:00'),
	(4,2,3,0.12870,'2017-04-13 08:00:00'),
	(5,3,1,6.88900,'2017-04-13 08:00:00'),
	(6,3,2,7.77100,'2017-04-13 08:00:00');

/*!40000 ALTER TABLE `exchange_rate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table iau_advanced_setting
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_advanced_setting`;

CREATE TABLE `iau_advanced_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key_words` varchar(255) NOT NULL COMMENT '关键词描述',
  `city` varchar(255) NOT NULL COMMENT '城市',
  `location` text NOT NULL COMMENT '位置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='高级优化设置表';

LOCK TABLES `iau_advanced_setting` WRITE;
/*!40000 ALTER TABLE `iau_advanced_setting` DISABLE KEYS */;

INSERT INTO `iau_advanced_setting` (`id`, `key_words`, `city`, `location`)
VALUES
	(1,'UpdaateadvancedSetting,1,2,3','1156440100','肯德基,阿矮海鲜大排档(溪岸路),FF体育公园(北门)'),
	(3,'abc,舒珊,高洁丝','1156110000','肯德吉'),
	(4,'苍梧','1156440300','肯德基'),
	(5,'','1156110000',''),
	(8,'a,b,c,d,e,f','1156110000','A.O.史密斯(徐州升辉装饰建材专卖店),A.hotel'),
	(9,'','1156110000',''),
	(10,'b','1156110000','复旦大学附属中山医院(西院区),复旦大学附属华山医院'),
	(11,'','1156110000',''),
	(12,'','1156110000',''),
	(13,'琴棋书画,紫砂,博会','1156310000','工银中心上海世博展览馆,琴台路'),
	(14,'','1156110000',''),
	(15,'','1156110000',''),
	(16,'','1156110000',''),
	(17,'','1156110000',''),
	(18,'','1156110000',''),
	(19,'','1156110000',''),
	(20,'','1156110000',''),
	(21,'W','1156440100','复旦大学附属华山医院,复旦大学附属中山医院(西院区)'),
	(22,'','1156110000',''),
	(23,'位置','1156440100','和发智能大厦,奉节饭店(奉节友谊医院南)'),
	(24,'A','1156440300','复地·复城国际,复旦大学附属中山医院(西院区)'),
	(25,'A','1156110000','复旦大学邯郸校区'),
	(26,'','1156110000',''),
	(27,'','1156110000',''),
	(28,'','1156110000',''),
	(29,'','1156110000',''),
	(30,'','1156110000',''),
	(31,'','1156110000',''),
	(32,'位置,在哪,地理位置,阴阳','1156440100','返点科技,复旦大学附属儿科医院');

/*!40000 ALTER TABLE `iau_advanced_setting` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table iau_audience
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_audience`;

CREATE TABLE `iau_audience` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `name_en` varchar(100) DEFAULT NULL,
  `d_type` varchar(20) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `key_type` varchar(10) DEFAULT 'opx',
  `keyword_list` text,
  `include_all_searchers` tinyint(1) DEFAULT '0',
  `include_paid_searchers` tinyint(1) DEFAULT '0',
  `include_organic_searchers` tinyint(1) DEFAULT '0',
  `use_manual_input` tinyint(1) DEFAULT '0',
  `gender` varchar(20) DEFAULT NULL,
  `age_group` varchar(20) DEFAULT NULL,
  `income_group` varchar(20) DEFAULT NULL,
  `city_group` varchar(255) DEFAULT NULL,
  `create_by` varchar(45) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(45) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `result_detail` text,
  `parent_audience_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人群定义表';



# Dump of table iau_audience_custom
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_audience_custom`;

CREATE TABLE `iau_audience_custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `key_word` varchar(450) DEFAULT NULL,
  `age_group` varchar(100) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `result_json` text,
  `create_by` varchar(45) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(45) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义人群信息表';



# Dump of table iau_audience_news
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_audience_news`;

CREATE TABLE `iau_audience_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `audience_plan_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1-key:market,2-key:brand',
  `score` decimal(8,6) NOT NULL COMMENT '热度',
  `summary` text,
  `title` text,
  `topImg` varchar(1000) NOT NULL,
  `url` varchar(1000) NOT NULL,
  `meta` text,
  `date` varchar(45) DEFAULT NULL COMMENT '日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='热点新闻';



# Dump of table iau_audience_plan
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_audience_plan`;

CREATE TABLE `iau_audience_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL COMMENT '客户ID',
  `name` varchar(255) NOT NULL COMMENT '人群包名称',
  `category_id` int(11) NOT NULL COMMENT '行业id',
  `advanced_setting_id` int(11) DEFAULT NULL COMMENT '高级设置id',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` int(11) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` int(11) NOT NULL COMMENT '更新者',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `analyse_status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人群包设置主表';

LOCK TABLES `iau_audience_plan` WRITE;
/*!40000 ALTER TABLE `iau_audience_plan` DISABLE KEYS */;

INSERT INTO `iau_audience_plan` (`id`, `client_id`, `name`, `category_id`, `advanced_setting_id`, `is_deleted`, `create_by`, `create_time`, `update_by`, `update_time`, `analyse_status`)
VALUES
	(1,1001,'TestBrand1_20170614',30,1,0,1206,'2017-05-24 18:20:52',1208,'2017-06-15 14:09:36',2),
	(12,1001,'test',3005,3,0,1206,'2017-05-27 17:08:36',1208,'2017-05-31 11:13:19',2),
	(14,1001,'test',2703,4,0,1206,'2017-05-31 11:47:21',1208,'2017-05-31 11:57:13',2),
	(15,1001,'test',31,5,0,1206,'2017-06-09 17:00:19',1206,'2017-06-09 17:00:19',2),
	(16,1001,'a_20170613',31,8,0,1206,'2017-06-13 17:46:28',1208,'2017-06-13 17:47:33',2),
	(17,1001,'ownBrand_20170614',3108,9,0,1206,'2017-06-14 17:57:29',1206,'2017-06-14 17:57:29',2),
	(18,1001,'ownBrandfdf_20170615',31,10,0,1206,'2017-06-15 11:23:59',1208,'2017-06-15 12:11:52',2),
	(19,1001,'ownBrandtest1_20170615',3108,11,0,1206,'2017-06-15 12:05:02',1208,'2017-06-15 15:04:08',2),
	(20,1001,'A_20170615',31,12,0,1206,'2017-06-15 12:13:14',1206,'2017-06-15 12:13:14',2),
	(21,1001,'ownBrand1_20170615',31,13,0,1206,'2017-06-15 15:19:24',1206,'2017-06-15 15:19:24',2),
	(22,1001,'a_20170615',31,14,0,1206,'2017-06-15 15:25:03',1206,'2017-06-15 15:25:03',2),
	(23,1001,'a_20170615',31,15,0,1206,'2017-06-15 15:27:17',1206,'2017-06-15 15:27:18',2),
	(24,1001,'a_20170615',3107,16,0,1206,'2017-06-15 15:36:23',1206,'2017-06-15 15:36:23',2),
	(25,1001,'ownBrand_20170615',3108,17,0,1206,'2017-06-15 16:07:48',1208,'2017-06-15 16:23:05',2),
	(26,1001,'a_20170615',31,18,0,1206,'2017-06-15 16:28:13',1206,'2017-06-15 16:28:13',2),
	(27,1001,'a_20170615',3108,19,0,1206,'2017-06-15 16:34:24',1206,'2017-06-15 16:34:24',2),
	(28,1001,'ownBrand_20170615',31,20,0,1206,'2017-06-15 16:39:30',1206,'2017-06-15 16:39:30',2),
	(29,1001,'a_20170615',31,21,0,1206,'2017-06-15 16:49:19',1208,'2017-06-15 16:53:24',2),
	(30,1001,'a_20170620',3108,22,0,1206,'2017-06-20 10:22:30',1208,'2017-06-20 10:23:00',2),
	(31,1001,'b_20170620',1712,23,0,1206,'2017-06-20 11:16:52',1206,'2017-06-20 11:16:52',2),
	(32,1001,'C_20170620',3108,24,0,1206,'2017-06-20 11:22:05',1206,'2017-06-20 11:22:05',2),
	(33,1001,'D_20170620',31,25,0,1206,'2017-06-20 11:26:41',1208,'2017-06-20 11:52:19',2),
	(34,1001,'E_20170620',1712,26,0,1206,'2017-06-20 11:53:31',1206,'2017-06-20 11:53:31',2),
	(35,1001,'f_20170620',31,27,0,1206,'2017-06-20 12:02:43',1206,'2017-06-20 12:02:43',2),
	(36,1001,'r_20170620',31,28,0,1206,'2017-06-20 12:05:54',1206,'2017-06-20 12:05:54',2),
	(37,1001,'t_20170620',26,29,0,1206,'2017-06-20 12:08:34',1206,'2017-06-20 12:08:34',2),
	(38,1001,'gg_20170620',31,30,0,1206,'2017-06-20 12:12:09',1206,'2017-06-20 12:12:09',2),
	(39,1001,'w_20170620',27,31,0,1206,'2017-06-20 12:14:29',1208,'2017-06-20 12:15:38',2),
	(40,1001,'a_20170620',31,32,0,1206,'2017-06-20 12:19:59',1208,'2017-06-20 12:21:33',2);

/*!40000 ALTER TABLE `iau_audience_plan` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table iau_audience_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_audience_record`;

CREATE TABLE `iau_audience_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `audience_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `date` varchar(45) DEFAULT '',
  `create_time` date DEFAULT NULL,
  `type` int(11) DEFAULT '0' COMMENT '1:interest,2:custom-key-word,3:retargeting,4:search-retargeting',
  PRIMARY KEY (`id`),
  UNIQUE KEY `audience_id` (`audience_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人群 主表';

LOCK TABLES `iau_audience_record` WRITE;
/*!40000 ALTER TABLE `iau_audience_record` DISABLE KEYS */;

INSERT INTO `iau_audience_record` (`id`, `audience_id`, `total`, `date`, `create_time`, `type`)
VALUES
	(1,12,441641403,'20170521','2017-05-21',1),
	(2,31,392816234,'20170521','2017-05-21',1),
	(3,27,369538518,'20170521','2017-05-21',1),
	(4,15,366414735,'20170521','2017-05-21',1),
	(5,25,357920606,'20170521','2017-05-21',1),
	(6,17,342120924,'20170521','2017-05-21',1),
	(7,1208,311192134,'20170521','2017-05-21',1),
	(8,2502,278205726,'20170521','2017-05-21',1),
	(9,21,262601510,'20170521','2017-05-21',1),
	(10,26,243662629,'20170521','2017-05-21',1),
	(11,18,242431717,'20170521','2017-05-21',1),
	(12,16,233286474,'20170521','2017-05-21',1),
	(13,2703,226495966,'20170521','2017-05-21',1),
	(14,11,216935790,'20170521','2017-05-21',1),
	(15,1712,210263397,'20170521','2017-05-21',1),
	(16,1202,209684553,'20170521','2017-05-21',1),
	(17,1501,206488550,'20170521','2017-05-21',1),
	(18,1601,204811276,'20170521','2017-05-21',1),
	(19,24,186949670,'20170521','2017-05-21',1),
	(20,1711,186473690,'20170521','2017-05-21',1),
	(21,22,179080105,'20170521','2017-05-21',1),
	(22,3102,177262090,'20170521','2017-05-21',1),
	(23,2101,177146455,'20170521','2017-05-21',1),
	(24,2701,174080484,'20170521','2017-05-21',1),
	(25,120803,169521915,'20170521','2017-05-21',1),
	(26,1603,167221961,'20170521','2017-05-21',1),
	(27,20,165350080,'20170521','2017-05-21',1),
	(28,2001,165264794,'20170521','2017-05-21',1),
	(29,30,164011085,'20170521','2017-05-21',1),
	(30,3106,158529523,'20170521','2017-05-21',1),
	(31,120802,150982646,'20170521','2017-05-21',1),
	(32,171101,147240254,'20170521','2017-05-21',1),
	(33,250203,145989978,'20170521','2017-05-21',1),
	(34,2201,144217357,'20170521','2017-05-21',1),
	(35,1504,143330725,'20170521','2017-05-21',1),
	(36,1102,137199851,'20170521','2017-05-21',1),
	(37,3103,132807356,'20170521','2017-05-21',1),
	(38,2401,130339549,'20170521','2017-05-21',1),
	(39,2702,127566231,'20170521','2017-05-21',1),
	(40,2103,118780908,'20170521','2017-05-21',1),
	(41,160302,118523407,'20170521','2017-05-21',1),
	(42,2604,117353954,'20170521','2017-05-21',1),
	(43,2501,115117286,'20170521','2017-05-21',1),
	(44,3101,111508079,'20170521','2017-05-21',1),
	(45,171102,109900555,'20170521','2017-05-21',1),
	(46,1803,106279331,'20170521','2017-05-21',1),
	(47,2603,104097948,'20170521','2017-05-21',1),
	(48,250206,101217129,'20170521','2017-05-21',1),
	(49,171208,100982175,'20170521','2017-05-21',1),
	(50,3002,98938813,'20170521','2017-05-21',1),
	(51,1503,98643566,'20170521','2017-05-21',1),
	(52,120203,97712144,'20170521','2017-05-21',1),
	(53,2605,94594942,'20170521','2017-05-21',1),
	(54,120202,94338164,'20170521','2017-05-21',1),
	(55,160305,92694335,'20170521','2017-05-21',1),
	(56,1802,89955113,'20170521','2017-05-21',1),
	(57,1502,88255930,'20170521','2017-05-21',1),
	(58,2102,88181282,'20170521','2017-05-21',1),
	(59,2403,86460450,'20170521','2017-05-21',1),
	(60,2601,86033662,'20170521','2017-05-21',1),
	(61,1801,83585150,'20170521','2017-05-21',1),
	(62,2404,83565765,'20170521','2017-05-21',1),
	(63,3003,83457519,'20170521','2017-05-21',1),
	(64,160109,80073281,'20170521','2017-05-21',1),
	(65,160110,75759049,'20170521','2017-05-21',1),
	(66,300307,75740298,'20170521','2017-05-21',1),
	(67,1706,71538217,'20170521','2017-05-21',1),
	(68,160303,71005444,'20170521','2017-05-21',1),
	(69,300304,70525118,'20170521','2017-05-21',1),
	(70,300306,70466903,'20170521','2017-05-21',1),
	(71,210304,69681827,'20170521','2017-05-21',1),
	(72,160103,68618146,'20170521','2017-05-21',1),
	(73,171204,68538197,'20170521','2017-05-21',1),
	(74,160101,66529974,'20170521','2017-05-21',1),
	(75,160301,66165822,'20170521','2017-05-21',1),
	(76,160106,64994890,'20170521','2017-05-21',1),
	(77,250201,64952114,'20170521','2017-05-21',1),
	(78,1702,64596687,'20170521','2017-05-21',1),
	(79,300207,64259383,'20170521','2017-05-21',1),
	(80,250202,64247656,'20170521','2017-05-21',1),
	(81,1701,64125107,'20170521','2017-05-21',1),
	(82,120801,63537457,'20170521','2017-05-21',1),
	(83,160105,63467790,'20170521','2017-05-21',1),
	(84,171104,63258080,'20170521','2017-05-21',1),
	(85,250101,62469235,'20170521','2017-05-21',1),
	(86,210103,61662914,'20170521','2017-05-21',1),
	(87,200106,60190053,'20170521','2017-05-21',1),
	(88,1103,58542094,'20170521','2017-05-21',1),
	(89,171103,58534833,'20170521','2017-05-21',1),
	(90,210202,58449268,'20170521','2017-05-21',1),
	(91,250207,58385519,'20170521','2017-05-21',1),
	(92,2602,58016171,'20170521','2017-05-21',1),
	(93,160104,57677805,'20170521','2017-05-21',1),
	(94,200109,57615597,'20170521','2017-05-21',1),
	(95,1104,56128187,'20170521','2017-05-21',1),
	(96,250204,55158993,'20170521','2017-05-21',1),
	(97,171201,55146318,'20170521','2017-05-21',1),
	(98,1708,53642996,'20170521','2017-05-21',1),
	(99,160108,52886398,'20170521','2017-05-21',1),
	(100,12020304,52165590,'20170521','2017-05-21',1);

/*!40000 ALTER TABLE `iau_audience_record` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table iau_audience_report_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_audience_report_data`;

CREATE TABLE `iau_audience_report_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '1-key:market,2-key:互联网人群,3-key:brand，4-key:competitor,5-key:product,6-key:competitors,7-key:潜在人群',
  `ref_id` int(11) DEFAULT NULL COMMENT 'type为1则是market id， type为2为空，tpye为3则是brand id,type为4则是brand id，type为5则是product id，type为6为空，type为7则为advanceSettingId',
  `audience_plan_id` int(11) NOT NULL,
  `total` int(11) NOT NULL DEFAULT '0' COMMENT '当天的数量',
  `date` varchar(45) DEFAULT NULL COMMENT '日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报表数据(天粒度)';



# Dump of table iau_audience_summary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_audience_summary`;

CREATE TABLE `iau_audience_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `audience_id` int(11) DEFAULT NULL,
  `audience_size` int(11) DEFAULT NULL,
  `weekly_growth_rate` float DEFAULT NULL,
  `monthly_growth_rate` float DEFAULT NULL,
  `type` int(11) DEFAULT '0' COMMENT '1:interest,2:custom-key-word,3:retargeting,4:search-retargeting',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人群汇总表';

LOCK TABLES `iau_audience_summary` WRITE;
/*!40000 ALTER TABLE `iau_audience_summary` DISABLE KEYS */;

INSERT INTO `iau_audience_summary` (`id`, `audience_id`, `audience_size`, `weekly_growth_rate`, `monthly_growth_rate`, `type`, `create_time`)
VALUES
	(1,12,441641403,0,0,1,'2017-05-21 09:38:23'),
	(2,31,392816234,0,0,1,'2017-05-21 09:38:23'),
	(3,27,369538518,0,0,1,'2017-05-21 09:38:23'),
	(4,15,366414735,0,0,1,'2017-05-21 09:38:23'),
	(5,25,357920606,0,0,1,'2017-05-21 09:38:23'),
	(6,17,342120924,0,0,1,'2017-05-21 09:38:23'),
	(7,1208,311192134,0,0,1,'2017-05-21 09:38:23'),
	(8,2502,278205726,0,0,1,'2017-05-21 09:38:23'),
	(9,21,262601510,0,0,1,'2017-05-21 09:38:23'),
	(10,26,243662629,0,0,1,'2017-05-21 09:38:23'),
	(11,18,242431717,0,0,1,'2017-05-21 09:38:23'),
	(12,16,233286474,0,0,1,'2017-05-21 09:38:23'),
	(13,2703,226495966,0,0,1,'2017-05-21 09:38:23'),
	(14,11,216935790,0,0,1,'2017-05-21 09:38:23'),
	(15,1712,210263397,0,0,1,'2017-05-21 09:38:23'),
	(16,1202,209684553,0,0,1,'2017-05-21 09:38:23'),
	(17,1501,206488550,0,0,1,'2017-05-21 09:38:23'),
	(18,1601,204811276,0,0,1,'2017-05-21 09:38:23'),
	(19,24,186949670,0,0,1,'2017-05-21 09:38:23'),
	(20,1711,186473690,0,0,1,'2017-05-21 09:38:23'),
	(21,22,179080105,0,0,1,'2017-05-21 09:38:23'),
	(22,3102,177262090,0,0,1,'2017-05-21 09:38:23'),
	(23,2101,177146455,0,0,1,'2017-05-21 09:38:23'),
	(24,2701,174080484,0,0,1,'2017-05-21 09:38:23'),
	(25,120803,169521915,0,0,1,'2017-05-21 09:38:23'),
	(26,1603,167221961,0,0,1,'2017-05-21 09:38:23'),
	(27,20,165350080,0,0,1,'2017-05-21 09:38:23'),
	(28,2001,165264794,0,0,1,'2017-05-21 09:38:23'),
	(29,30,164011085,0,0,1,'2017-05-21 09:38:23'),
	(30,3106,158529523,0,0,1,'2017-05-21 09:38:23'),
	(31,120802,150982646,0,0,1,'2017-05-21 09:38:23'),
	(32,171101,147240254,0,0,1,'2017-05-21 09:38:23'),
	(33,250203,145989978,0,0,1,'2017-05-21 09:38:23'),
	(34,2201,144217357,0,0,1,'2017-05-21 09:38:23'),
	(35,1504,143330725,0,0,1,'2017-05-21 09:38:23'),
	(36,1102,137199851,0,0,1,'2017-05-21 09:38:23'),
	(37,3103,132807356,0,0,1,'2017-05-21 09:38:23'),
	(38,2401,130339549,0,0,1,'2017-05-21 09:38:23'),
	(39,2702,127566231,0,0,1,'2017-05-21 09:38:23'),
	(40,2103,118780908,0,0,1,'2017-05-21 09:38:23'),
	(41,160302,118523407,0,0,1,'2017-05-21 09:38:23'),
	(42,2604,117353954,0,0,1,'2017-05-21 09:38:23'),
	(43,2501,115117286,0,0,1,'2017-05-21 09:38:23'),
	(44,3101,111508079,0,0,1,'2017-05-21 09:38:23'),
	(45,171102,109900555,0,0,1,'2017-05-21 09:38:23'),
	(46,1803,106279331,0,0,1,'2017-05-21 09:38:23'),
	(47,2603,104097948,0,0,1,'2017-05-21 09:38:23'),
	(48,250206,101217129,0,0,1,'2017-05-21 09:38:23'),
	(49,171208,100982175,0,0,1,'2017-05-21 09:38:23'),
	(50,3002,98938813,0,0,1,'2017-05-21 09:38:23'),
	(51,1503,98643566,0,0,1,'2017-05-21 09:38:23'),
	(52,120203,97712144,0,0,1,'2017-05-21 09:38:23'),
	(53,2605,94594942,0,0,1,'2017-05-21 09:38:23'),
	(54,120202,94338164,0,0,1,'2017-05-21 09:38:23'),
	(55,160305,92694335,0,0,1,'2017-05-21 09:38:23'),
	(56,1802,89955113,0,0,1,'2017-05-21 09:38:23'),
	(57,1502,88255930,0,0,1,'2017-05-21 09:38:23'),
	(58,2102,88181282,0,0,1,'2017-05-21 09:38:23'),
	(59,2403,86460450,0,0,1,'2017-05-21 09:38:23'),
	(60,2601,86033662,0,0,1,'2017-05-21 09:38:23'),
	(61,1801,83585150,0,0,1,'2017-05-21 09:38:23'),
	(62,2404,83565765,0,0,1,'2017-05-21 09:38:23'),
	(63,3003,83457519,0,0,1,'2017-05-21 09:38:23'),
	(64,160109,80073281,0,0,1,'2017-05-21 09:38:23'),
	(65,160110,75759049,0,0,1,'2017-05-21 09:38:23'),
	(66,300307,75740298,0,0,1,'2017-05-21 09:38:23'),
	(67,1706,71538217,0,0,1,'2017-05-21 09:38:23'),
	(68,160303,71005444,0,0,1,'2017-05-21 09:38:23'),
	(69,300304,70525118,0,0,1,'2017-05-21 09:38:23'),
	(70,300306,70466903,0,0,1,'2017-05-21 09:38:23'),
	(71,210304,69681827,0,0,1,'2017-05-21 09:38:23'),
	(72,160103,68618146,0,0,1,'2017-05-21 09:38:23'),
	(73,171204,68538197,0,0,1,'2017-05-21 09:38:23'),
	(74,160101,66529974,0,0,1,'2017-05-21 09:38:23'),
	(75,160301,66165822,0,0,1,'2017-05-21 09:38:23'),
	(76,160106,64994890,0,0,1,'2017-05-21 09:38:23'),
	(77,250201,64952114,0,0,1,'2017-05-21 09:38:23'),
	(78,1702,64596687,0,0,1,'2017-05-21 09:38:23'),
	(79,300207,64259383,0,0,1,'2017-05-21 09:38:23'),
	(80,250202,64247656,0,0,1,'2017-05-21 09:38:23'),
	(81,1701,64125107,0,0,1,'2017-05-21 09:38:23'),
	(82,120801,63537457,0,0,1,'2017-05-21 09:38:23'),
	(83,160105,63467790,0,0,1,'2017-05-21 09:38:23'),
	(84,171104,63258080,0,0,1,'2017-05-21 09:38:23'),
	(85,250101,62469235,0,0,1,'2017-05-21 09:38:23'),
	(86,210103,61662914,0,0,1,'2017-05-21 09:38:23'),
	(87,200106,60190053,0,0,1,'2017-05-21 09:38:23'),
	(88,1103,58542094,0,0,1,'2017-05-21 09:38:23'),
	(89,171103,58534833,0,0,1,'2017-05-21 09:38:23'),
	(90,210202,58449268,0,0,1,'2017-05-21 09:38:23'),
	(91,250207,58385519,0,0,1,'2017-05-21 09:38:23'),
	(92,2602,58016171,0,0,1,'2017-05-21 09:38:23'),
	(93,160104,57677805,0,0,1,'2017-05-21 09:38:23'),
	(94,200109,57615597,0,0,1,'2017-05-21 09:38:23'),
	(95,1104,56128187,0,0,1,'2017-05-21 09:38:23'),
	(96,250204,55158993,0,0,1,'2017-05-21 09:38:23'),
	(97,171201,55146318,0,0,1,'2017-05-21 09:38:23'),
	(98,1708,53642996,0,0,1,'2017-05-21 09:38:23'),
	(99,160108,52886398,0,0,1,'2017-05-21 09:38:23'),
	(100,12020304,52165590,0,0,1,'2017-05-21 09:38:23');

/*!40000 ALTER TABLE `iau_audience_summary` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table iau_brand
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_brand`;

CREATE TABLE `iau_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  `is_competitor` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是竞争品牌',
  `audience_plan_id` int(11) DEFAULT NULL COMMENT 'audience_plan id',
  `key_words` varchar(255) NOT NULL COMMENT '关键词描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='品牌表';

LOCK TABLES `iau_brand` WRITE;
/*!40000 ALTER TABLE `iau_brand` DISABLE KEYS */;

INSERT INTO `iau_brand` (`id`, `name`, `is_competitor`, `audience_plan_id`, `key_words`)
VALUES
	(3,'TestBrand1',0,1,'brand2,1,2,3'),
	(4,'Competitor 2',1,12,'abc,高洁丝'),
	(5,'competitor1',1,12,'a,b,c,d,e,f'),
	(6,'ownBrand',0,12,'a,b,c,d,e,f'),
	(7,'competitor02',1,14,'a,b,c,d,e,f'),
	(8,'ownBrand_02_update',0,14,'wr,跳水'),
	(9,'testCompetitor01',1,14,'wer,隆重,机器人,科普宣传'),
	(10,'competitor04',1,14,'FDF'),
	(11,'competitor03',1,14,'ert'),
	(12,'A',0,15,'A'),
	(13,'C',1,15,'C'),
	(14,'a',0,16,'b,a,b,c,d,e,f'),
	(15,'',1,16,''),
	(16,'B',1,1,'B'),
	(19,'competitor',1,17,'competitor1'),
	(20,'ownBrand',0,17,'A'),
	(21,'ownBrandfdf',0,18,'ownBrand'),
	(22,'a',1,18,'a'),
	(23,'ownBrandtest1',0,19,'A'),
	(25,'A',1,20,'A'),
	(26,'A',0,20,'A'),
	(27,'ownBrand1',0,21,'钢琴,弹钢琴,钢琴曲,钢琴谱'),
	(28,'competitor1',1,21,'小提琴,吕思清,violin,小提琴谱'),
	(29,'competitor2',1,21,'琴音,宫琴音,出道至今,宫琴,泽井芽衣,竖琴'),
	(30,'1',1,22,'a'),
	(31,'2',1,22,'2'),
	(32,'a',0,22,'a'),
	(33,'b',1,23,'b'),
	(34,'a',0,23,'a'),
	(35,'a',1,24,'a'),
	(36,'a',0,24,'a'),
	(37,'a',1,24,'钢琴,弹钢琴,钢琴曲,钢琴谱'),
	(38,'a',1,25,'f'),
	(39,'test',1,25,'test'),
	(40,'ownBrand',0,25,'a'),
	(41,'a',0,26,'a'),
	(42,'a',1,26,'a'),
	(43,'b',1,26,'b'),
	(44,'a',1,27,'a'),
	(45,'b',1,27,'b'),
	(46,'a',0,27,'a'),
	(47,'ownBrand',0,28,'a'),
	(48,'a',1,28,'w'),
	(49,'b',1,28,'b'),
	(50,'b',1,29,'b'),
	(51,'a',0,29,'a'),
	(52,'co1',1,29,'co'),
	(53,'a',0,30,'a'),
	(54,'b',0,31,'汽车,试驾,新能源汽车,胖哥'),
	(55,'C',0,32,'A'),
	(56,'D',0,33,'D'),
	(57,'A',1,33,'A'),
	(58,'E',0,34,'E'),
	(59,'f',0,35,'f'),
	(60,'r',0,36,'r'),
	(61,'t',0,37,'t'),
	(62,'gg',0,38,'gg'),
	(63,'hh',1,38,'hh'),
	(64,'w',1,39,'w'),
	(65,'w',0,39,'w'),
	(66,'w',1,39,'w'),
	(67,'悍马方法',1,40,'钢琴,弹钢琴,钢琴曲,钢琴谱'),
	(68,'a',0,40,'汽车,试驾,新能源汽车,胖哥');

/*!40000 ALTER TABLE `iau_brand` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table iau_event_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_event_info`;

CREATE TABLE `iau_event_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) DEFAULT NULL,
  `event_desc` varchar(255) DEFAULT NULL,
  `event_one_name` varchar(255) DEFAULT NULL,
  `event_one_type` varchar(255) DEFAULT NULL,
  `event_two_name` varchar(255) DEFAULT NULL,
  `event_two_type` varchar(255) DEFAULT NULL,
  `event_three_name` varchar(255) DEFAULT NULL,
  `event_three_type` varchar(255) DEFAULT NULL,
  `event_four_name` varchar(255) DEFAULT NULL,
  `event_four_type` varchar(255) DEFAULT NULL,
  `event_five_name` varchar(255) DEFAULT NULL,
  `event_five_type` varchar(255) DEFAULT NULL,
  `event_six_name` varchar(255) DEFAULT NULL,
  `event_six_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `event_one_default` varchar(255) DEFAULT NULL,
  `event_two_default` varchar(255) DEFAULT NULL,
  `event_three_default` varchar(255) DEFAULT NULL,
  `event_four_default` varchar(255) DEFAULT NULL,
  `event_five_default` varchar(255) DEFAULT NULL,
  `event_six_default` varchar(255) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `conversion_field` tinyint(1) DEFAULT '0',
  `deduplication` tinyint(1) DEFAULT '0',
  `client_id` int(11) DEFAULT NULL,
  `unique_session` tinyint(1) DEFAULT '0',
  `product_id` int(11) DEFAULT NULL,
  `deduplication_type` int(11) DEFAULT '0' COMMENT '0 => No de-duplication\n-1 => Remove duplicate visitor within conversion period\n-2 => Remove duplicate session\n>= 1 => event_params to be de-duplicate',
  `event_index` int(11) DEFAULT NULL,
  `retargeting_status` tinyint(1) DEFAULT '0',
  `manual_feed` tinyint(1) DEFAULT '0',
  `javascripts` text,
  `urls` varchar(10000) DEFAULT NULL,
  `last_event_on` datetime DEFAULT NULL,
  `event_type` mediumint(9) DEFAULT '0',
  `url_flag` tinyint(1) DEFAULT '0',
  `gdn_audience_id` int(11) DEFAULT NULL,
  `gdn_javascripts` text,
  `enable_cookie_matching` tinyint(1) DEFAULT NULL,
  `filter_type` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `event_tags` text,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_clilent_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动';



# Dump of table iau_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `iau_product`;

CREATE TABLE `iau_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL DEFAULT '' COMMENT '产品行业',
  `name` varchar(255) NOT NULL COMMENT '产品名称',
  `brand_id` int(11) DEFAULT NULL COMMENT '产品id',
  `key_words` varchar(255) NOT NULL COMMENT '关键词描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表';

LOCK TABLES `iau_product` WRITE;
/*!40000 ALTER TABLE `iau_product` DISABLE KEYS */;

INSERT INTO `iau_product` (`id`, `category`, `name`, `brand_id`, `key_words`)
VALUES
	(6,'20001','TestProduct1',3,'product1,1,2,3'),
	(7,'20001','TestProduct2',3,'product2,1,2,3'),
	(8,'测试','Competitor 2 p1',4,'abc,首飞'),
	(9,'测试','competitor1_p1',5,'abc,dq'),
	(10,'测试','ownBrandP1',6,'abc,卫生巾'),
	(11,'测试','ownBrandP2',6,'ABC,高洁丝'),
	(12,'测试','competitor02_p1',7,'wer,选拔赛'),
	(13,'测试','testOwnBrand01_update',8,'abc,高洁丝,首飞'),
	(14,'测试','testOwnBrand02',8,'abc,首飞,划分'),
	(15,'测试','competitor01_p1_update',9,'wer,启动仪式暨'),
	(16,'测试','competitor01_p2',9,'wer,启动仪式暨,隆重'),
	(18,'测试','competitor03_p1',11,'wer,启动仪式暨,科普宣传'),
	(19,'测试','testOwnBrand02_update',8,'wer,启动仪式暨,科普宣传'),
	(20,'测试','competitor01_p1_update',9,'rt,叶景汶,洪慧芳,rt-ac68u'),
	(23,'测试','testOwnBrand01_update',14,'abc,高洁丝'),
	(24,'测试','testOwnBrand02',14,'abc,首飞,划分'),
	(25,'测试','testOwnBrand02_update',14,'wer,启动仪式暨,科普宣传'),
	(26,'','',15,''),
	(34,'','',16,''),
	(37,'','w',19,'w'),
	(38,'','t',19,'t'),
	(39,'','A',20,'A'),
	(40,'','B',20,'B'),
	(41,'fd','AA',21,''),
	(42,'fd','fd',22,'fd'),
	(43,'OWN1','P1',23,'WON'),
	(44,'OWN2','P2',23,'WON2'),
	(47,'电子琴','电子琴',27,'品牌,法国,中国品牌'),
	(48,'牛头琴','牛头琴',27,'品牌,法国,牌子,中国品牌'),
	(49,'琴谱','琴谱',28,'琴谱,钢琴谱,天空之城,伴奏'),
	(50,'琴弦','琴弦',28,'琴弦'),
	(51,'','',29,''),
	(52,'','',31,''),
	(53,'','',35,''),
	(54,'电子琴','电子琴',36,'品牌,法国,中国品牌'),
	(55,'牛头琴','牛头琴',36,'品牌,法国,牌子,中国品牌'),
	(56,'电子琴','电子琴',37,'品牌,法国,中国品牌'),
	(57,'牛头琴','牛头琴',37,'品牌,法国,牌子,中国品牌'),
	(58,'a','a',39,'a'),
	(59,'a','a',41,'a'),
	(60,'b','b',42,'b'),
	(61,'','',43,''),
	(62,'','',45,''),
	(63,'r','r',48,'r'),
	(64,'','',49,''),
	(65,'a','co1',52,'a'),
	(66,'C','A',51,'C'),
	(67,'D','D',51,'D'),
	(68,'33','C02',52,'EE'),
	(69,'电子琴','电子琴',54,'品牌,法国,中国品牌'),
	(70,'牛头琴','奥迪',54,'奥迪配件'),
	(71,'','t',61,''),
	(72,'汽车','悍马1发地方',67,'悍马1,发地方'),
	(74,'汽车','奥迪',68,'奥迪配件');

/*!40000 ALTER TABLE `iau_product` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table interest_structure
# ------------------------------------------------------------

DROP TABLE IF EXISTS `interest_structure`;

CREATE TABLE `interest_structure` (
  `id` int(11) NOT NULL,
  `name_en` varchar(100) DEFAULT NULL,
  `name_cn` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `interest_structure` WRITE;
/*!40000 ALTER TABLE `interest_structure` DISABLE KEYS */;

INSERT INTO `interest_structure` (`id`, `name_en`, `name_cn`, `status`)
VALUES
	(11,'Culture','文化艺术',1),
	(12,'Jobs & Education','教育培训',1),
	(13,'Games','游戏',0),
	(14,'Consumer Electronics','消费数码',0),
	(15,'Health & Wellness','健康医疗',1),
	(16,'Beauty & Cosmetics','美容及化妆品',1),
	(17,'Automobiles','汽车',1),
	(18,'Sports & Fitness','运动健身',1),
	(19,'Internet & Technology','IT及信息产业',0),
	(20,'Baby & Maternity','母婴育儿',1),
	(21,'Personal Finance','金融财经',1),
	(22,'Consulting & Services','咨询及服务',1),
	(23,'Industrial','工业',0),
	(24,'Female Fashion','时尚',1),
	(25,'Leisure Travel & Business Travel','旅游商旅',1),
	(26,'Food & Drink','食品美食',1),
	(27,'Home & Lifestyle','家居生活',1),
	(29,'Office Equipment','电脑办公',0),
	(30,'Alcohol','酒类',1),
	(31,'Arts & Entertainment','娱乐',1),
	(32,'Commerce','商业',0),
	(33,'Festival','节日',0),
	(1101,'Online Literature','网络小说',1),
	(1102,'Culture/Literature','文化文学',1),
	(1103,'Books/Magazines','书刊杂志',1),
	(1104,'Humanities & Arts','人文艺术',1),
	(1201,'Primary & Secondary Schooling','初级中级教育',0),
	(1202,'Overseas Education','留学移民',1),
	(1203,'MBA/EMBA','MBA/EMBA',1),
	(1204,'Vocational & Continuing Education','职业技能培训',1),
	(1205,'Early Childhood Education','早教幼教',1),
	(1206,'Language Education','语言培训',1),
	(1207,'University','大学',0),
	(1208,'Private School','私立学校',1),
	(1301,'Massive Multiplayer','大型客户端游戏',0),
	(1302,'Online Games','网页游戏',0),
	(1303,'Mobile Phone/Tablet Games','手机平板游戏',0),
	(1304,'Mini Games & Flash Games','小游戏Flash游戏',0),
	(1305,'Sports Games','电子竞技',0),
	(1306,'Games Related Products','游戏周边',0),
	(1401,'Mobile Phones/ Tablets','手机平板',0),
	(1402,'Mobile Accessories','手机配件',0),
	(1403,'Mobile Carrier','运营商',0),
	(1404,'Desktops / Notebooks','台式机',0),
	(1405,'Computer Hardware','电脑硬件',0),
	(1406,'Digital Accessories','数码配件',0),
	(1407,'Photography','摄影摄像',0),
	(1408,'Fashional Videos','时尚影音',0),
	(1409,'Smart Devices','智能设备',0),
	(1410,'E-education','电子教育',0),
	(1411,'Game Consoles','游戏机',0),
	(1501,'Psychology','情感心理',1),
	(1502,'Cosmetic Procedures','整形整容',1),
	(1503,'Healthcare','保健养生',1),
	(1504,'Sexual Health','两性健康',1),
	(1601,'Skin Care','护肤',1),
	(1602,'Daily Personal Care','洗护日用',0),
	(1603,'Make-Up/Cosmetics','彩妆',1),
	(1604,'Hair & Body','美发美体',0),
	(1701,'High-End Cars','高档汽车',1),
	(1702,'Mid-End Cars','中档汽车',1),
	(1703,'Entry-Level Cars','入门级汽车',1),
	(1704,'Vehicle Maintenance','养车用车',0),
	(1705,'Used Cars','二手车',1),
	(1706,'Rental Cars','汽车租赁',1),
	(1707,'Car Manufacturers','汽车制造商',0),
	(1708,'Auto Insurance','汽车保险',1),
	(1709,'Auto Accessories','汽车周边',0),
	(1710,'Luxury Cars','豪华汽车',1),
	(1711,'Car Manufacturer Country','生产国家',1),
	(1712,'Car Type','车型',1),
	(1801,'Fitness','健身',1),
	(1802,'Outdoor Sports','户外',1),
	(1803,'Sports Events','体育赛事',1),
	(1901,'Telecommunications/Services','电信、通信服务',0),
	(1902,'Software','软件',0),
	(1903,'E-commerce','电子商务',0),
	(2001,'Maternity & Parenting','母婴用品',1),
	(2002,'Family Services','亲子服务',0),
	(2101,'Insurance','保险',1),
	(2102,'Investing','投资理财',1),
	(2103,'Real Estate & Construction','房地产及建筑',1),
	(2201,'Wedding Services','婚庆',1),
	(2202,'Careers','招聘求职',1),
	(2203,'Dating','相亲交友',1),
	(2401,'Clothing','服装',1),
	(2402,'Jewelry/Accessories','首饰饰品',1),
	(2403,'Designers & Collections','奢侈品',1),
	(2404,'Shoes & Bags','鞋包',1),
	(2501,'Hotels & Accommodations','酒店',1),
	(2502,'Travel Destination','旅游目的地',1),
	(2503,'Leisure Travel','旅游',0),
	(2504,'Air Travel','航空',0),
	(2505,'Travel Agencies & Services','旅行社',0),
	(2601,'Cooking & Recipes','烹饪和菜谱',1),
	(2602,'Snacks','休闲食品',1),
	(2603,'Restaurants','餐馆美食',1),
	(2604,'Healthy Food','保健食品',1),
	(2605,'Fresh Food','生鲜食品',1),
	(2606,'Local Food','地方特产',1),
	(2607,'Drinks','饮料',1),
	(2701,'Furniture Decoration','家居家装',1),
	(2702,'Domestic Appliance','家用电器',1),
	(2703,'Pets','宠物',1),
	(2901,'Computers and Related Products','电脑及外设',0),
	(2902,'Office Supplies','办公文具',0),
	(3001,'Chinese Liquor/White Spirits','白酒',1),
	(3002,'Wine','葡萄酒',1),
	(3003,'Imported Wine','洋酒',1),
	(3004,'Beer','啤酒',1),
	(3005,'Nutritious Wine','养生酒',1),
	(3101,'Variety & Entertainment','娱乐综艺',1),
	(3102,'Movies','院线电影',1),
	(3103,'TV Dramas','网络影视剧',1),
	(3104,'Comics & Animation','动画漫画',1),
	(3105,'Classical Music & Jazz','高雅音乐',1),
	(3106,'Pop Music','流行音乐',1),
	(3107,'Audio Equipment','音响器材',1),
	(3108,'Musical Instruments','乐器',1),
	(3301,'Christmas/New Year','圣诞节/元旦',0),
	(3302,'Chinese New Year','春节',0),
	(3303,'Lantern Festival','元宵节',0),
	(3304,'Valentine\'s Day','情人节',0),
	(3305,'Tomb-Sweeping Day','清明节',0),
	(3306,'Easter','复活节',0),
	(3307,'Dragon Boat Festival','端午节',0),
	(3308,'Labor Day','劳动节',0),
	(3309,'Mid-Autumn Festival','中秋节',0),
	(3310,'Double Ninth Festival','重阳节',0),
	(3311,'National Day','国庆节',0),
	(3312,'Halloween','万圣节',0),
	(3313,'Thanksgiving','感恩节',0),
	(9901,'Automotive News','汽车资讯',0),
	(9902,'Women\'s Fashion','女性时尚',0),
	(9903,'Maternity & Babies','母婴育儿',0),
	(9904,'Finance','金融财经',0),
	(9905,'Travel','旅游酒店',0),
	(9906,'Food & Beverage','美食吃货',0),
	(9907,'Dating & Social','婚恋交友',0),
	(9908,'Reading and Education','读书教育',0),
	(9909,'Online Games','游戏对战',0),
	(9910,'E-commerce','电子商务',0),
	(9911,'Sports & Fitness','运动健身',0),
	(9912,'Video Entertainment','视频娱乐',0),
	(9913,'Men\'s Fashion','男性时尚',0),
	(120201,'Foreign Language Exam','留学考试',1),
	(120202,'Overseas Education Application','留学申请',1),
	(120203,'Overseas Education Destination','留学移民国家',1),
	(120801,'Private Kindergarten','私立幼儿园',1),
	(120802,'Private Primary School','私立小学',1),
	(120803,'Primary Middle & High School','私立中学',1),
	(160101,'Anti-anging / Wrinkles','抗衰老去皱',1),
	(160102,'Hydration','补水保湿',1),
	(160103,'Brightening & Whitening','美白提亮祛斑',1),
	(160104,'Sunscreen','隔离防晒',1),
	(160105,'Cleansing & Makeup Removal','清洁卸妆',1),
	(160106,'Men\'s Skincare','男士护肤',1),
	(160107,'Acne Removing','祛痘',1),
	(160108,'Anti-allergy','抗过敏',1),
	(160109,'Eyecare','眼部护理',1),
	(160110,'Bodycare','身体护肤',1),
	(160301,'Face Makeup','面部彩妆',1),
	(160302,'Eye Makeup','眼部彩妆',1),
	(160303,'Lip Color','唇部彩妆',1),
	(160304,'Nail Color & Handcare','指甲/手部',1),
	(160305,'Makeup Tools','美发护发',1),
	(171101,'Japan & Korea (Car)','日本韩国车',1),
	(171102,'Germany (Car)','德国车',1),
	(171103,'United States (Car)','美国车',1),
	(171104,'China (Car)','国产车',1),
	(171201,'Sedan','三厢车',1),
	(171202,'Coupe','轿跑车',1),
	(171203,'Hatchback','两厢车',1),
	(171204,'SUV','越野车',1),
	(171205,'Station Wagon','旅行车',1),
	(171206,'Van','面包车',1),
	(171207,'Convertible','敞篷车',1),
	(171208,'MPV','多功能车',1),
	(171209,'Sports Car','跑车',1),
	(200101,'Diaper','婴幼儿尿裤',1),
	(200102,'Baby Feeding','喂养用品',1),
	(200103,'Baby Formula','婴幼奶粉',1),
	(200104,'Baby Food','幼儿食品',1),
	(200105,'Mother\'s Goods','妈妈用品',1),
	(200106,'Baby Care','婴幼护理',1),
	(200107,'Carriers & Strollers','童车推车',1),
	(200108,'Car Seats','汽车安全座椅',1),
	(200109,'Baby Bedding','婴儿寝具',1),
	(210101,'Life Insurance','人寿保险',1),
	(210102,'Health & Medical Insurance','健康保险',1),
	(210103,'Property Insurance','财产保险',1),
	(210201,'Personal Loan & Mortgage','个人贷款',1),
	(210202,'Asset Management','投资和资产管理',1),
	(210203,'Credit Card','信用卡',1),
	(210204,'Retail Banking','银行零售服务',1),
	(210301,'Property Development','开发商',1),
	(210302,'Real Estate Agencies','中介代理',1),
	(210303,'Property Management','物业管理',1),
	(210304,'Real Estate','楼盘',1),
	(250101,'Luxury Hotel','奢华酒店',1),
	(250102,'High-end Hotel','高级酒店',1),
	(250103,'Business Hotel','商务酒店',1),
	(250104,'Economy Hotel','经济型酒店',1),
	(250105,'Vacation Rental','度假型出租',1),
	(250201,'North America (Travel)','北美旅游',1),
	(250202,'SEA (Travel)','东南亚旅游',1),
	(250203,'Japan / Korea (Travel)','日本 / 韩国旅游',1),
	(250204,'Europe (Travel)','欧洲旅游',1),
	(250205,'Africa (Travel)','非洲旅游',1),
	(250206,'Australia & New Zealand (Travel)','大洋洲旅游 （澳洲 & 新西兰）',1),
	(250207,'Hong Kong,Macau and Singapore (Travel)','港澳游',1),
	(300101,'High-End Spirits','高档白酒',1),
	(300102,'Mid-End Spirits','中档白酒',1),
	(300103,'Low-End Spirits','低档白酒',1),
	(300201,'White Wine','白葡萄酒',1),
	(300202,'Red Wine','红葡萄酒',1),
	(300203,'Rosé Wine','桃红葡萄酒',1),
	(300204,'Sparkling Wine','起泡酒',1),
	(300205,'Champagne','香槟',1),
	(300206,'Sweet Wine/ Dessert Wine','甜酒 / 餐后酒',1),
	(300207,'Country of Origin','产地',1),
	(300301,'Whiskey','威士忌',1),
	(300302,'Brandy','白兰地',1),
	(300303,'Vodka','伏特加',1),
	(300304,'Cocktail','鸡尾酒',1),
	(300305,'Rum','朗姆酒',1),
	(300306,'Tequila','龙舌兰',1),
	(300307,'Gin','杜松子酒',1),
	(300401,'Stout','黑啤',1),
	(300402,'Yellow Beer','黄啤',1),
	(300403,'White Beer','白啤',1),
	(300404,'Fruit Beer','果啤',1),
	(300501,'Yellow Rice Wine','黄酒',1),
	(300502,'Tonic','滋补酒',1),
	(300503,'Kumiss','奶酒',1),
	(300504,'Sake','清酒',1),
	(300505,'Shochu','烧酒',1),
	(300506,'Plum','梅酒',1),
	(300507,'Fruit Wine','果酒',1),
	(12020301,'Europe (Education)','留学移民欧洲',1),
	(12020302,'North America (Education)','留学移民北美',1),
	(12020303,'Australia & New Zealand (Education)','留学移民澳洲',1),
	(12020304,'Japan & Korea (Education)','留学移民日韩',1),
	(12020305,'Hong Kong,Macau and Singapore (Education)','留学移民港澳新',1),
	(30020701,'France (Wine)','法国酒',1),
	(30020702,'Italy (Wine)','意大利酒',1),
	(30020703,'Spain / Portugal (Wine)','西班牙 / 葡萄牙酒',1),
	(30020704,'USA (Wine)','美国酒',1),
	(30020705,'Australia / New Zealand (Wine)','澳洲 / 新西兰酒',1),
	(30020706,'UK (Wine)','英国酒',1),
	(30020707,'SA (Wine)','南非酒',1),
	(30020708,'Chile / Argentina (Wine)','智利 / 阿根廷酒',1);

/*!40000 ALTER TABLE `interest_structure` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table locations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `continent_id` int(11) DEFAULT NULL,
  `continent_name_en_us` varchar(100) DEFAULT NULL,
  `continent_name_zh_cn` varchar(100) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `country_name_en_us` varchar(100) DEFAULT NULL,
  `country_name_zh_cn` varchar(100) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL,
  `province_name_en_us` varchar(100) DEFAULT NULL,
  `province_name_zh_cn` varchar(100) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `region_name_en_us` varchar(100) DEFAULT NULL,
  `region_name_zh_cn` varchar(100) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `city_name_en_us` varchar(100) DEFAULT NULL,
  `city_name_zh_cn` varchar(100) DEFAULT NULL,
  `tier_id` int(11) DEFAULT NULL,
  `tier_level` int(11) DEFAULT NULL,
  `tier_name_en_us` varchar(100) DEFAULT NULL,
  `tier_name_zh_cn` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;

INSERT INTO `locations` (`id`, `continent_id`, `continent_name_en_us`, `continent_name_zh_cn`, `country_id`, `country_name_en_us`, `country_name_zh_cn`, `province_id`, `province_name_en_us`, `province_name_zh_cn`, `region_id`, `region_name_en_us`, `region_name_zh_cn`, `city_id`, `city_name_en_us`, `city_name_zh_cn`, `tier_id`, `tier_level`, `tier_name_en_us`, `tier_name_zh_cn`)
VALUES
	(1,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340800,'Anqing','安庆市',1156000023,3,'Third-tier City','三线城市'),
	(2,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340300,'Bengbu','蚌埠市',1156000023,3,'Third-tier City','三线城市'),
	(3,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156341600,'Bozhou','亳州市',1156000020,0,'Non-tier City','未分级城市'),
	(4,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156341700,'Chizhou','池州市',1156000020,0,'Non-tier City','未分级城市'),
	(5,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156341100,'Chuzhou','滁州市',1156000024,4,'Fourth-tier City','四线城市'),
	(6,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156341200,'Fuyang','阜阳市',1156000024,4,'Fourth-tier City','四线城市'),
	(7,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340100,'Hefei','合肥市',1156000022,2,'Second-tier City','二线城市'),
	(8,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340600,'Huaibei','淮北市',1156000020,0,'Non-tier City','未分级城市'),
	(9,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340400,'Huainan','淮南市',1156000023,3,'Third-tier City','三线城市'),
	(10,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156341000,'Huangshan','黄山市',1156000024,4,'Fourth-tier City','四线城市'),
	(11,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156341500,'Liuan','六安市',1156000020,0,'Non-tier City','未分级城市'),
	(12,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340500,'Maanshan','马鞍山市',1156000023,3,'Third-tier City','三线城市'),
	(13,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156341300,'Suzhou','宿州市',1156000020,0,'Non-tier City','未分级城市'),
	(14,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340700,'Tongling','铜陵市',1156000020,0,'Non-tier City','未分级城市'),
	(15,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340200,'Wuhu','芜湖市',1156000023,3,'Third-tier City','三线城市'),
	(16,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156341800,'Xuancheng','宣城市',1156000020,0,'Non-tier City','未分级城市'),
	(17,1000000002,'Asia','亚洲',1156000000,'China','中国',1156340001,'Anhui','安徽省',1156000011,'East','华东地区',1156340000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(18,1000000002,'Asia','亚洲',1156000000,'China','中国',1446000001,'Macao','澳门',1156000012,'HK, MO & TW','港澳台地区',1446000000,'Macao','澳门',1156000020,0,'Non-tier City','未分级城市'),
	(19,1000000002,'Asia','亚洲',1156000000,'China','中国',1156110001,'Beijing','北京市',1156000013,'North','华北地区',1156110000,'Beijing','北京市',1156000021,1,'First-tier City','一线城市'),
	(20,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350100,'Fuzhou','福州市',1156000022,2,'Second-tier City','二线城市'),
	(21,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350800,'Longyan','龙岩市',1156000023,3,'Third-tier City','三线城市'),
	(22,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350700,'Nanping','南平市',1156000024,4,'Fourth-tier City','四线城市'),
	(23,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350900,'Ningde','宁德市',1156000024,4,'Fourth-tier City','四线城市'),
	(24,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350300,'Putian','莆田市',1156000024,4,'Fourth-tier City','四线城市'),
	(25,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350500,'Quanzhou','泉州市',1156000022,2,'Second-tier City','二线城市'),
	(26,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350400,'Sanming','三明市',1156000024,4,'Fourth-tier City','四线城市'),
	(27,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350200,'Xiamen','厦门市',1156000022,2,'Second-tier City','二线城市'),
	(28,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350600,'Zhangzhou','漳州市',1156000023,3,'Third-tier City','三线城市'),
	(29,1000000002,'Asia','亚洲',1156000000,'China','中国',1156350001,'Fujian','福建省',1156000011,'East','华东地区',1156350000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(30,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620400,'Baiyin','白银市',1156000020,0,'Non-tier City','未分级城市'),
	(31,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156621100,'Dingxi','定西市',1156000020,0,'Non-tier City','未分级城市'),
	(32,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156623000,'Gannan','甘南藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(33,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620200,'Jiayuguan','嘉峪关市',1156000020,0,'Non-tier City','未分级城市'),
	(34,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620300,'Jinchang','金昌市',1156000020,0,'Non-tier City','未分级城市'),
	(35,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620900,'Jiuquan','酒泉市',1156000020,0,'Non-tier City','未分级城市'),
	(36,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620100,'Lanzhou','兰州市',1156000023,3,'Third-tier City','三线城市'),
	(37,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156622900,'Linxia','临夏回族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(38,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156621200,'Longnan','陇南市',1156000020,0,'Non-tier City','未分级城市'),
	(39,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620800,'Pingliang','平凉市',1156000020,0,'Non-tier City','未分级城市'),
	(40,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156621000,'Qingyang','庆阳市',1156000020,0,'Non-tier City','未分级城市'),
	(41,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620500,'Tianshui','天水市',1156000023,3,'Third-tier City','三线城市'),
	(42,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620600,'Wuwei','武威市',1156000020,0,'Non-tier City','未分级城市'),
	(43,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620700,'Zhangye','张掖市',1156000020,0,'Non-tier City','未分级城市'),
	(44,1000000002,'Asia','亚洲',1156000000,'China','中国',1156620001,'Gansu','甘肃省',1156000015,'Northwest','西北地区',1156620000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(45,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156445100,'Chaozhou','潮州市',1156000020,0,'Non-tier City','未分级城市'),
	(46,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156441900,'Dongguan','东莞市',1156000022,2,'Second-tier City','二线城市'),
	(47,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440600,'Foshan','佛山市',1156000022,2,'Second-tier City','二线城市'),
	(48,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440100,'Guangzhou','广州市',1156000021,1,'First-tier City','一线城市'),
	(49,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156441600,'Heyuan','河源市',1156000020,0,'Non-tier City','未分级城市'),
	(50,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156441300,'Huizhou','惠州市',1156000023,3,'Third-tier City','三线城市'),
	(51,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440700,'Jiangmen','江门市',1156000023,3,'Third-tier City','三线城市'),
	(52,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156445200,'Jieyang','揭阳市',1156000023,3,'Third-tier City','三线城市'),
	(53,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440900,'Maoming','茂名市',1156000023,3,'Third-tier City','三线城市'),
	(54,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156441400,'Meizhou','梅州市',1156000024,4,'Fourth-tier City','四线城市'),
	(55,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156441800,'Qingyuan','清远市',1156000024,4,'Fourth-tier City','四线城市'),
	(56,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440500,'Shantou','汕头市',1156000023,3,'Third-tier City','三线城市'),
	(57,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156441500,'Shanwei','汕尾市',1156000020,0,'Non-tier City','未分级城市'),
	(58,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440200,'Shaoguan','韶关市',1156000024,4,'Fourth-tier City','四线城市'),
	(59,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440300,'Shenzhen','深圳市',1156000021,1,'First-tier City','一线城市'),
	(60,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156441700,'Yangjiang','阳江市',1156000024,4,'Fourth-tier City','四线城市'),
	(61,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156445300,'Yunfu','云浮市',1156000020,0,'Non-tier City','未分级城市'),
	(62,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440800,'Zhanjiang','湛江市',1156000024,4,'Fourth-tier City','四线城市'),
	(63,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156441200,'Zhaoqing','肇庆市',1156000023,3,'Third-tier City','三线城市'),
	(64,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156442000,'Zhongshan','中山市',1156000023,3,'Third-tier City','三线城市'),
	(65,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440400,'Zhuhai','珠海市',1156000023,3,'Third-tier City','三线城市'),
	(66,1000000002,'Asia','亚洲',1156000000,'China','中国',1156440001,'Guangdong','广东省',1156000016,'South','华南地区',1156440000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(67,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450500,'Beihai','北海市',1156000023,3,'Third-tier City','三线城市'),
	(68,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156451000,'Bose','百色市',1156000020,0,'Non-tier City','未分级城市'),
	(69,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156451400,'Chongzuo','崇左市',1156000020,0,'Non-tier City','未分级城市'),
	(70,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450600,'Fangchenggang','防城港市',1156000020,0,'Non-tier City','未分级城市'),
	(71,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450800,'Guigang','贵港市',1156000020,0,'Non-tier City','未分级城市'),
	(72,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450300,'Guilin','桂林市',1156000023,3,'Third-tier City','三线城市'),
	(73,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156451200,'Hechi','河池市',1156000020,0,'Non-tier City','未分级城市'),
	(74,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156451100,'Hezhou','贺州市',1156000020,0,'Non-tier City','未分级城市'),
	(75,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156451300,'Laibin','来宾市',1156000020,0,'Non-tier City','未分级城市'),
	(76,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450200,'Liuzhou','柳州市',1156000023,3,'Third-tier City','三线城市'),
	(77,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450100,'Nanning','南宁市',1156000022,2,'Second-tier City','二线城市'),
	(78,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450700,'Qinzhou','钦州市',1156000020,0,'Non-tier City','未分级城市'),
	(79,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450400,'Wuzhou','梧州市',1156000020,0,'Non-tier City','未分级城市'),
	(80,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450900,'Yulin','玉林市',1156000023,3,'Third-tier City','三线城市'),
	(81,1000000002,'Asia','亚洲',1156000000,'China','中国',1156450001,'Guangxi','广西壮族自治区',1156000016,'South','华南地区',1156450000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(82,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156520400,'Anshun','安顺市',1156000020,0,'Non-tier City','未分级城市'),
	(83,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156520500,'Bijie','毕节市',1156000020,0,'Non-tier City','未分级城市'),
	(84,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156520100,'Guiyang','贵阳市',1156000022,2,'Second-tier City','二线城市'),
	(85,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156520000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(86,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156522600,'Qiandongnan','黔东南苗族侗族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(87,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156522700,'Qiannan','黔南布依族苗族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(88,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156522300,'Qianxinan','黔西南布依族苗族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(89,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156520200,'Liupanshui','六盘水市',1156000020,0,'Non-tier City','未分级城市'),
	(90,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156520600,'Tongren','铜仁市',1156000020,0,'Non-tier City','未分级城市'),
	(91,1000000002,'Asia','亚洲',1156000000,'China','中国',1156520001,'Guizhou','贵州省',1156000017,'Southwest','西南地区',1156520300,'Zunyi','遵义市',1156000024,4,'Fourth-tier City','四线城市'),
	(92,1000000002,'Asia','亚洲',1156000000,'China','中国',1156460001,'Hainan','海南省',1156000016,'South','华南地区',1156460100,'Haikou','海口市',1156000023,3,'Third-tier City','三线城市'),
	(93,1000000002,'Asia','亚洲',1156000000,'China','中国',1156460001,'Hainan','海南省',1156000016,'South','华南地区',1156469000,'Hainanother','省直辖县级行政区划',1156000020,0,'Non-tier City','未分级城市'),
	(94,1000000002,'Asia','亚洲',1156000000,'China','中国',1156460001,'Hainan','海南省',1156000016,'South','华南地区',1156460000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(95,1000000002,'Asia','亚洲',1156000000,'China','中国',1156460001,'Hainan','海南省',1156000016,'South','华南地区',1156460200,'Sanya','三亚市',1156000023,3,'Third-tier City','三线城市'),
	(96,1000000002,'Asia','亚洲',1156000000,'China','中国',1156460001,'Hainan','海南省',1156000016,'South','华南地区',1156460400,'Zhanzhou','儋州市',1156000020,0,'Non-tier City','未分级城市'),
	(97,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130600,'Baoding','保定市',1156000023,3,'Third-tier City','三线城市'),
	(98,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130900,'Cangzhou','沧州市',1156000023,3,'Third-tier City','三线城市'),
	(99,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130800,'Chengde','承德市',1156000023,3,'Third-tier City','三线城市'),
	(100,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130400,'Handan','邯郸市',1156000023,3,'Third-tier City','三线城市'),
	(101,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156131000,'Langfang','廊坊市',1156000023,3,'Third-tier City','三线城市'),
	(102,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(103,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130300,'Qinhuangdao','秦皇岛市',1156000023,3,'Third-tier City','三线城市'),
	(104,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156131100,'Hengshui','衡水市',1156000020,0,'Non-tier City','未分级城市'),
	(105,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130100,'Shijiazhuang','石家庄市',1156000022,2,'Second-tier City','二线城市'),
	(106,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130200,'Tangshan','唐山市',1156000023,3,'Third-tier City','三线城市'),
	(107,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130500,'Xingtai','邢台市',1156000023,3,'Third-tier City','三线城市'),
	(108,1000000002,'Asia','亚洲',1156000000,'China','中国',1156130001,'Hebei','河北省',1156000013,'North','华北地区',1156130700,'Zhangjiakou','张家口市',1156000024,4,'Fourth-tier City','四线城市'),
	(109,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410500,'Anyang','安阳市',1156000023,3,'Third-tier City','三线城市'),
	(110,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410800,'Jiaozuo','焦作市',1156000024,4,'Fourth-tier City','四线城市'),
	(111,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156419000,'Henanohter','省直辖县级行政区划',1156000020,0,'Non-tier City','未分级城市'),
	(112,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410200,'Kaifeng','开封市',1156000020,0,'Non-tier City','未分级城市'),
	(113,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410300,'Luoyang','洛阳市',1156000023,3,'Third-tier City','三线城市'),
	(114,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156411300,'Nanyang','南阳市',1156000023,3,'Third-tier City','三线城市'),
	(115,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156411100,'Luohe','漯河市',1156000020,0,'Non-tier City','未分级城市'),
	(116,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410400,'Pingdingshan','平顶山市',1156000023,3,'Third-tier City','三线城市'),
	(117,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410900,'Puyang','濮阳市',1156000023,3,'Third-tier City','三线城市'),
	(118,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(119,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410600,'Hebi','鹤壁市',1156000020,0,'Non-tier City','未分级城市'),
	(120,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156411200,'Sanmenxia','三门峡市',1156000020,0,'Non-tier City','未分级城市'),
	(121,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156411400,'Shangqiu','商丘市',1156000020,0,'Non-tier City','未分级城市'),
	(122,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410700,'Xinxiang','新乡市',1156000023,3,'Third-tier City','三线城市'),
	(123,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156411500,'Xinyang','信阳市',1156000020,0,'Non-tier City','未分级城市'),
	(124,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156411000,'Xuchang','许昌市',1156000024,4,'Fourth-tier City','四线城市'),
	(125,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156410100,'Zhengzhou','郑州市',1156000022,2,'Second-tier City','二线城市'),
	(126,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156411600,'Zhoukou','周口市',1156000020,0,'Non-tier City','未分级城市'),
	(127,1000000002,'Asia','亚洲',1156000000,'China','中国',1156410001,'Henan','河南省',1156000010,'Central','华中地区',1156411700,'Zhumadian','驻马店市',1156000020,0,'Non-tier City','未分级城市'),
	(128,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156232700,'Da','大兴安岭地区',1156000020,0,'Non-tier City','未分级城市'),
	(129,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230600,'Daqing','大庆市',1156000023,3,'Third-tier City','三线城市'),
	(130,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230100,'Harbin','哈尔滨市',1156000022,2,'Second-tier City','二线城市'),
	(131,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230400,'Hegang','鹤岗市',1156000020,0,'Non-tier City','未分级城市'),
	(132,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156231100,'Heihe','黑河市',1156000020,0,'Non-tier City','未分级城市'),
	(133,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156231000,'Mudanjiang','牡丹江市',1156000024,4,'Fourth-tier City','四线城市'),
	(134,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230800,'Jiamusi','佳木斯市',1156000020,0,'Non-tier City','未分级城市'),
	(135,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230900,'Qitaihe','七台河市',1156000020,0,'Non-tier City','未分级城市'),
	(136,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(137,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230300,'Jixi','鸡西市',1156000020,0,'Non-tier City','未分级城市'),
	(138,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230200,'Qiqihaer','齐齐哈尔市',1156000023,3,'Third-tier City','三线城市'),
	(139,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230500,'Shuangyashan','双鸭山市',1156000020,0,'Non-tier City','未分级城市'),
	(140,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156231200,'Suihua','绥化市',1156000020,0,'Non-tier City','未分级城市'),
	(141,1000000002,'Asia','亚洲',1156000000,'China','中国',1156230001,'Heilongjiang','黑龙江省',1156000014,'Northeast','东北地区',1156230700,'Yichun','伊春市',1156000020,0,'Non-tier City','未分级城市'),
	(142,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156422800,'Enshi','恩施土家族苗族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(143,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420700,'Ezhou','鄂州市',1156000020,0,'Non-tier City','未分级城市'),
	(144,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420200,'Huangshi','黄石市',1156000024,4,'Fourth-tier City','四线城市'),
	(145,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420800,'Jingmen','荆门市',1156000024,4,'Fourth-tier City','四线城市'),
	(146,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156429000,'Hubeiother','省直辖县级行政区划',1156000020,0,'Non-tier City','未分级城市'),
	(147,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156421000,'Jingzhou','荆州市',1156000023,3,'Third-tier City','三线城市'),
	(148,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(149,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156421100,'Huanggang','黄冈市',1156000020,0,'Non-tier City','未分级城市'),
	(150,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420300,'Shiyan','十堰市',1156000020,0,'Non-tier City','未分级城市'),
	(151,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156421300,'Suizhou','随州市',1156000020,0,'Non-tier City','未分级城市'),
	(152,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420100,'Wuhan','武汉市',1156000022,2,'Second-tier City','二线城市'),
	(153,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420600,'Xiangyang','襄阳市',1156000020,0,'Non-tier City','未分级城市'),
	(154,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156421200,'Xianning','咸宁市',1156000020,0,'Non-tier City','未分级城市'),
	(155,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420900,'Xiaogan','孝感市',1156000024,4,'Fourth-tier City','四线城市'),
	(156,1000000002,'Asia','亚洲',1156000000,'China','中国',1156420001,'Hubei','湖北省',1156000010,'Central','华中地区',1156420500,'Yichang','宜昌市',1156000023,3,'Third-tier City','三线城市'),
	(157,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430700,'Changde','常德市',1156000024,4,'Fourth-tier City','四线城市'),
	(158,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430100,'Changsha','长沙市',1156000022,2,'Second-tier City','二线城市'),
	(159,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156431000,'Chenzhou','郴州市',1156000023,3,'Third-tier City','三线城市'),
	(160,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430400,'Hengyang','衡阳市',1156000023,3,'Third-tier City','三线城市'),
	(161,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156431300,'Loudi','娄底市',1156000024,4,'Fourth-tier City','四线城市'),
	(162,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(163,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156431200,'Huaihua','怀化市',1156000024,4,'Fourth-tier City','四线城市'),
	(164,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430500,'Shaoyang','邵阳市',1156000024,4,'Fourth-tier City','四线城市'),
	(165,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430300,'Xiangtan','湘潭市',1156000023,3,'Third-tier City','三线城市'),
	(166,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156433100,'Xiangxi','湘西土家族苗族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(167,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430900,'Yiyang','益阳市',1156000024,4,'Fourth-tier City','四线城市'),
	(168,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156431100,'Yongzhou','永州市',1156000020,0,'Non-tier City','未分级城市'),
	(169,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430600,'Yueyang','岳阳市',1156000023,3,'Third-tier City','三线城市'),
	(170,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430800,'Zhangjiajie','张家界市',1156000020,0,'Non-tier City','未分级城市'),
	(171,1000000002,'Asia','亚洲',1156000000,'China','中国',1156430001,'Hunan','湖南省',1156000010,'Central','华中地区',1156430200,'Zhuzhou','株洲市',1156000023,3,'Third-tier City','三线城市'),
	(172,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220800,'Baicheng','白城市',1156000020,0,'Non-tier City','未分级城市'),
	(173,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220600,'Baishan','白山市',1156000020,0,'Non-tier City','未分级城市'),
	(174,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220100,'Changchun','长春市',1156000022,2,'Second-tier City','二线城市'),
	(175,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220400,'Liaoyuan','辽源市',1156000020,0,'Non-tier City','未分级城市'),
	(176,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(177,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220200,'Jilin','吉林市',1156000023,3,'Third-tier City','三线城市'),
	(178,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220300,'Siping','四平市',1156000020,0,'Non-tier City','未分级城市'),
	(179,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220700,'Songyuan','松原市',1156000020,0,'Non-tier City','未分级城市'),
	(180,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156220500,'Tonghua','通化市',1156000020,0,'Non-tier City','未分级城市'),
	(181,1000000002,'Asia','亚洲',1156000000,'China','中国',1156220001,'Jilin','吉林省',1156000014,'Northeast','东北地区',1156222400,'Yanbian','延边朝鲜族自治州',1156000024,4,'Fourth-tier City','四线城市'),
	(182,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320400,'Changzhou','常州市',1156000023,3,'Third-tier City','三线城市'),
	(183,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320800,'Huaian','淮安市',1156000023,3,'Third-tier City','三线城市'),
	(184,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320700,'Lianyungang','连云港市',1156000023,3,'Third-tier City','三线城市'),
	(185,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320100,'Nanjing','南京市',1156000022,2,'Second-tier City','二线城市'),
	(186,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320600,'Nantong','南通市',1156000023,3,'Third-tier City','三线城市'),
	(187,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(188,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156321300,'Suqian','宿迁市',1156000024,4,'Fourth-tier City','四线城市'),
	(189,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320500,'Suzhou','苏州市',1156000022,2,'Second-tier City','二线城市'),
	(190,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156321200,'Taizhou','泰州市',1156000023,3,'Third-tier City','三线城市'),
	(191,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320200,'Wuxi','无锡市',1156000020,0,'Non-tier City','未分级城市'),
	(192,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320300,'Xuzhou','徐州市',1156000023,3,'Third-tier City','三线城市'),
	(193,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156320900,'Yancheng','盐城市',1156000023,3,'Third-tier City','三线城市'),
	(194,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156321000,'Yangzhou','扬州市',1156000023,3,'Third-tier City','三线城市'),
	(195,1000000002,'Asia','亚洲',1156000000,'China','中国',1156320001,'Jiangsu','江苏省',1156000011,'East','华东地区',1156321100,'Zhenjiang','镇江市',1156000023,3,'Third-tier City','三线城市'),
	(196,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156361000,'Fuzhou','抚州市',1156000020,0,'Non-tier City','未分级城市'),
	(197,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360700,'Ganzhou','赣州市',1156000023,3,'Third-tier City','三线城市'),
	(198,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360800,'Ji\'An','吉安市',1156000020,0,'Non-tier City','未分级城市'),
	(199,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360400,'Jiujiang','九江市',1156000023,3,'Third-tier City','三线城市'),
	(200,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360100,'Nanchang','南昌市',1156000022,2,'Second-tier City','二线城市'),
	(201,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360300,'Pingxiang','萍乡市',1156000020,0,'Non-tier City','未分级城市'),
	(202,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(203,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360200,'Jingdezhen','景德镇市',1156000024,4,'Fourth-tier City','四线城市'),
	(204,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156361100,'Shangrao','上饶市',1156000024,4,'Fourth-tier City','四线城市'),
	(205,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360500,'Xinyu','新余市',1156000023,3,'Third-tier City','三线城市'),
	(206,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360900,'Yichun','宜春市',1156000020,0,'Non-tier City','未分级城市'),
	(207,1000000002,'Asia','亚洲',1156000000,'China','中国',1156360001,'Jiangxi','江西省',1156000010,'Central','华中地区',1156360600,'Yingtan','鹰潭市',1156000020,0,'Non-tier City','未分级城市'),
	(208,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210300,'Anshan','鞍山市',1156000023,3,'Third-tier City','三线城市'),
	(209,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210500,'Benxi','本溪市',1156000023,3,'Third-tier City','三线城市'),
	(210,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156211300,'Chaoyang','朝阳市',1156000020,0,'Non-tier City','未分级城市'),
	(211,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210200,'Dalian','大连市',1156000022,2,'Second-tier City','二线城市'),
	(212,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210600,'Dandong','丹东市',1156000023,3,'Third-tier City','三线城市'),
	(213,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210400,'Fushun','抚顺市',1156000020,0,'Non-tier City','未分级城市'),
	(214,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210900,'Fuxin','阜新市',1156000020,0,'Non-tier City','未分级城市'),
	(215,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156211400,'Huludao','葫芦岛市',1156000024,4,'Fourth-tier City','四线城市'),
	(216,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210700,'Jinzhou','锦州市',1156000023,3,'Third-tier City','三线城市'),
	(217,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156211100,'Panjin','盘锦市',1156000020,0,'Non-tier City','未分级城市'),
	(218,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(219,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156211000,'Liaoyang','辽阳市',1156000023,3,'Third-tier City','三线城市'),
	(220,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210100,'Shenyang','沈阳市',1156000022,2,'Second-tier City','二线城市'),
	(221,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156211200,'Tieling','铁岭市',1156000020,0,'Non-tier City','未分级城市'),
	(222,1000000002,'Asia','亚洲',1156000000,'China','中国',1156210001,'Liaoning','辽宁省',1156000014,'Northeast','东北地区',1156210800,'Yingkou','营口市',1156000023,3,'Third-tier City','三线城市'),
	(223,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156152900,'Alashan','阿拉善盟',1156000020,0,'Non-tier City','未分级城市'),
	(224,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150200,'Baotou','包头市',1156000022,2,'Second-tier City','二线城市'),
	(225,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150800,'Bayannur','巴彦淖尔市',1156000020,0,'Non-tier City','未分级城市'),
	(226,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150400,'Chifeng','赤峰市',1156000024,4,'Fourth-tier City','四线城市'),
	(227,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150600,'Eerduosi','鄂尔多斯市',1156000023,3,'Third-tier City','三线城市'),
	(228,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156152200,'Hinggan','兴安盟',1156000020,0,'Non-tier City','未分级城市'),
	(229,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150100,'Hohhot','呼和浩特市',1156000022,2,'Second-tier City','二线城市'),
	(230,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150700,'Hulun','呼伦贝尔市',1156000020,0,'Non-tier City','未分级城市'),
	(231,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(232,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150500,'Tongliao','通辽市',1156000024,4,'Fourth-tier City','四线城市'),
	(233,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150900,'Ulanqab','乌兰察布市',1156000020,0,'Non-tier City','未分级城市'),
	(234,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156150300,'Wuhai','乌海市',1156000024,4,'Fourth-tier City','四线城市'),
	(235,1000000002,'Asia','亚洲',1156000000,'China','中国',1156150001,'Neimeng','内蒙古自治区',1156000013,'North','华北地区',1156152500,'Xilin','锡林郭勒盟',1156000020,0,'Non-tier City','未分级城市'),
	(236,1000000002,'Asia','亚洲',1156000000,'China','中国',1156640001,'Ningxia','宁夏回族自治区',1156000015,'Northwest','西北地区',1156640400,'Guyuan','固原市',1156000020,0,'Non-tier City','未分级城市'),
	(237,1000000002,'Asia','亚洲',1156000000,'China','中国',1156640001,'Ningxia','宁夏回族自治区',1156000015,'Northwest','西北地区',1156640000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(238,1000000002,'Asia','亚洲',1156000000,'China','中国',1156640001,'Ningxia','宁夏回族自治区',1156000015,'Northwest','西北地区',1156640200,'Shizuishan','石嘴山市',1156000020,0,'Non-tier City','未分级城市'),
	(239,1000000002,'Asia','亚洲',1156000000,'China','中国',1156640001,'Ningxia','宁夏回族自治区',1156000015,'Northwest','西北地区',1156640300,'Wuzhong','吴忠市',1156000020,0,'Non-tier City','未分级城市'),
	(240,1000000002,'Asia','亚洲',1156000000,'China','中国',1156640001,'Ningxia','宁夏回族自治区',1156000015,'Northwest','西北地区',1156640100,'Yinchuan','银川市',1156000023,3,'Third-tier City','三线城市'),
	(241,1000000002,'Asia','亚洲',1156000000,'China','中国',1156640001,'Ningxia','宁夏回族自治区',1156000015,'Northwest','西北地区',1156640500,'Zhongwei','中卫市',1156000020,0,'Non-tier City','未分级城市'),
	(242,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156632600,'Golog','果洛藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(243,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156632200,'Haibei','海北藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(244,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156630200,'Haidong','海东市',1156000020,0,'Non-tier City','未分级城市'),
	(245,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156632500,'Hainan','海南藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(246,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156632800,'Haixi','海西蒙古族藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(247,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156632300,'Huangnan','黄南藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(248,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156630000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(249,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156630100,'Xining','西宁市',1156000023,3,'Third-tier City','三线城市'),
	(250,1000000002,'Asia','亚洲',1156000000,'China','中国',1156630001,'Qinghai','青海省',1156000015,'Northwest','西北地区',1156632700,'Yushu','玉树藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(251,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156371600,'Binzhou','滨州市',1156000023,3,'Third-tier City','三线城市'),
	(252,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156371400,'Dezhou','德州市',1156000024,4,'Fourth-tier City','四线城市'),
	(253,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370500,'Dongying','东营市',1156000023,3,'Third-tier City','三线城市'),
	(254,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156371700,'Heze','菏泽市',1156000020,0,'Non-tier City','未分级城市'),
	(255,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370100,'Jinan','济南市',1156000022,2,'Second-tier City','二线城市'),
	(256,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370800,'Jining','济宁市',1156000023,3,'Third-tier City','三线城市'),
	(257,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156371200,'Laiwu','莱芜市',1156000020,0,'Non-tier City','未分级城市'),
	(258,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156371500,'Liaocheng','聊城市',1156000023,3,'Third-tier City','三线城市'),
	(259,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156371300,'Linyi','临沂市',1156000023,3,'Third-tier City','三线城市'),
	(260,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(261,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156371100,'Rizhao','日照市',1156000023,3,'Third-tier City','三线城市'),
	(262,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370200,'Qingdao','青岛市',1156000022,2,'Second-tier City','二线城市'),
	(263,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370900,'Tai\'An','泰安市',1156000023,3,'Third-tier City','三线城市'),
	(264,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370700,'Weifang','潍坊市',1156000023,3,'Third-tier City','三线城市'),
	(265,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156371000,'Weihai','威海市',1156000023,3,'Third-tier City','三线城市'),
	(266,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370600,'Yantai','烟台市',1156000022,2,'Second-tier City','二线城市'),
	(267,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370400,'Zaozhuang','枣庄市',1156000024,4,'Fourth-tier City','四线城市'),
	(268,1000000002,'Asia','亚洲',1156000000,'China','中国',1156370001,'Shandong','山东省',1156000013,'North','华北地区',1156370300,'Zibo','淄博市',1156000023,3,'Third-tier City','三线城市'),
	(269,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140400,'Changzhi','长治市',1156000023,3,'Third-tier City','三线城市'),
	(270,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140200,'Datong','大同市',1156000023,3,'Third-tier City','三线城市'),
	(271,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140500,'Jincheng','晋城市',1156000020,0,'Non-tier City','未分级城市'),
	(272,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140700,'Jinzhong','晋中市',1156000020,0,'Non-tier City','未分级城市'),
	(273,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156141000,'Linfen','临汾市',1156000024,4,'Fourth-tier City','四线城市'),
	(274,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156141100,'Lvliang','吕梁市',1156000020,0,'Non-tier City','未分级城市'),
	(275,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(276,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140600,'Shuozhou','朔州市',1156000024,4,'Fourth-tier City','四线城市'),
	(277,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140100,'Taiyuan','太原市',1156000022,2,'Second-tier City','二线城市'),
	(278,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140900,'Xinzhou','忻州市',1156000020,0,'Non-tier City','未分级城市'),
	(279,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140300,'Yangquan','阳泉市',1156000024,4,'Fourth-tier City','四线城市'),
	(280,1000000002,'Asia','亚洲',1156000000,'China','中国',1156140001,'Shanxi','山西省',1156000013,'North','华北地区',1156140800,'Yuncheng','运城市',1156000024,4,'Fourth-tier City','四线城市'),
	(281,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610900,'Ankang','安康市',1156000020,0,'Non-tier City','未分级城市'),
	(282,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610300,'Baoji','宝鸡市',1156000023,3,'Third-tier City','三线城市'),
	(283,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610700,'Hanzhong','汉中市',1156000020,0,'Non-tier City','未分级城市'),
	(284,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(285,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156611000,'Shangluo','商洛市',1156000020,0,'Non-tier City','未分级城市'),
	(286,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610200,'Tongchuan','铜川市',1156000020,0,'Non-tier City','未分级城市'),
	(287,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610500,'Weinan','渭南市',1156000024,4,'Fourth-tier City','四线城市'),
	(288,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610100,'Xi\'An','西安市',1156000022,2,'Second-tier City','二线城市'),
	(289,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610400,'Xianyang','咸阳市',1156000022,2,'Second-tier City','二线城市'),
	(290,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610600,'Yan\'An','延安市',1156000024,4,'Fourth-tier City','四线城市'),
	(291,1000000002,'Asia','亚洲',1156000000,'China','中国',1156610001,'Shanxi1','陕西省',1156000015,'Northwest','西北地区',1156610800,'Yulin','榆林市',1156000023,3,'Third-tier City','三线城市'),
	(292,1000000002,'Asia','亚洲',1156000000,'China','中国',1156310001,'Shanghai','上海市',1156000011,'East','华东地区',1156310000,'Shanghai','上海市',1156000021,1,'First-tier City','一线城市'),
	(293,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156513200,'Aba','阿坝藏族羌族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(294,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511900,'Bazhong','巴中市',1156000020,0,'Non-tier City','未分级城市'),
	(295,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510100,'Chengdu','成都市',1156000022,2,'Second-tier City','二线城市'),
	(296,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511700,'Dazhou','达州市',1156000020,0,'Non-tier City','未分级城市'),
	(297,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510600,'Deyang','德阳市',1156000023,3,'Third-tier City','三线城市'),
	(298,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156513300,'Garze','甘孜藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(299,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511600,'Guang\'An','广安市',1156000020,0,'Non-tier City','未分级城市'),
	(300,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510800,'Guangyuan','广元市',1156000020,0,'Non-tier City','未分级城市'),
	(301,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511100,'Leshan','乐山市',1156000024,4,'Fourth-tier City','四线城市'),
	(302,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156513400,'Liangshan','凉山彝族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(303,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510500,'Luzhou','泸州市',1156000024,4,'Fourth-tier City','四线城市'),
	(304,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511400,'Meishan','眉山市',1156000020,0,'Non-tier City','未分级城市'),
	(305,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510700,'Mianyang','绵阳市',1156000023,3,'Third-tier City','三线城市'),
	(306,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511300,'Nanchong','南充市',1156000024,4,'Fourth-tier City','四线城市'),
	(307,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511000,'Neijiang','内江市',1156000024,4,'Fourth-tier City','四线城市'),
	(308,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510400,'Panzhihua','攀枝花市',1156000024,4,'Fourth-tier City','四线城市'),
	(309,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(310,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510900,'Suining','遂宁市',1156000020,0,'Non-tier City','未分级城市'),
	(311,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511800,'Ya\'An','雅安市',1156000020,0,'Non-tier City','未分级城市'),
	(312,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156511500,'Yibin','宜宾市',1156000024,4,'Fourth-tier City','四线城市'),
	(313,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156510300,'Zigong','自贡市',1156000020,0,'Non-tier City','未分级城市'),
	(314,1000000002,'Asia','亚洲',1156000000,'China','中国',1156510001,'Sichuan','四川省',1156000017,'Southwest','西南地区',1156512000,'Ziyang','资阳市',1156000020,0,'Non-tier City','未分级城市'),
	(315,1000000002,'Asia','亚洲',1156000000,'China','中国',1158000001,'Taiwan','台湾',1156000012,'HK, MO & TW','港澳台地区',1158000000,'Taiwan','台湾',1156000020,0,'Non-tier City','未分级城市'),
	(316,1000000002,'Asia','亚洲',1156000000,'China','中国',1156120001,'Tianjin','天津市',1156000013,'North','华北地区',1156120000,'Tianjin','天津市',1156000022,2,'Second-tier City','二线城市'),
	(317,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156542500,'Ali','阿里地区',1156000020,0,'Non-tier City','未分级城市'),
	(318,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156542100,'Changdu','昌都地区',1156000020,0,'Non-tier City','未分级城市'),
	(319,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156540300,'Changducity','昌都市',1156000020,0,'Non-tier City','未分级城市'),
	(320,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156540100,'Lasa','拉萨市',1156000020,0,'Non-tier City','未分级城市'),
	(321,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156542600,'Linzhi','林芝地区',1156000020,0,'Non-tier City','未分级城市'),
	(322,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156540400,'Linzhicity','林芝市',1156000020,0,'Non-tier City','未分级城市'),
	(323,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156542400,'Naqu','那曲地区',1156000020,0,'Non-tier City','未分级城市'),
	(324,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156540000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(325,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156540200,'Rikaze','日喀则市',1156000020,0,'Non-tier City','未分级城市'),
	(326,1000000002,'Asia','亚洲',1156000000,'China','中国',1156540001,'Xizang','西藏自治区',1156000017,'Southwest','西南地区',1156540500,'Shannan','山南市',1156000020,0,'Non-tier City','未分级城市'),
	(327,1000000002,'Asia','亚洲',1156000000,'China','中国',1344000001,'Hongkong','香港',1156000012,'HK, MO & TW','港澳台地区',1344000000,'Hongkong','香港',1156000020,0,'Non-tier City','未分级城市'),
	(328,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156652900,'Aksu','阿克苏地区',1156000020,0,'Non-tier City','未分级城市'),
	(329,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156654300,'Altay','阿勒泰地区',1156000020,0,'Non-tier City','未分级城市'),
	(330,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156652800,'Bayingolin','巴音郭楞蒙古自治州',1156000020,0,'Non-tier City','未分级城市'),
	(331,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156652700,'Bortala','博尔塔拉蒙古自治州',1156000020,0,'Non-tier City','未分级城市'),
	(332,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156652300,'Changji','昌吉回族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(333,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156653100,'Gashi','喀什地区',1156000020,0,'Non-tier City','未分级城市'),
	(334,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156652200,'Hami','哈密地区',1156000020,0,'Non-tier City','未分级城市'),
	(335,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156653200,'Hotan','和田地区',1156000020,0,'Non-tier City','未分级城市'),
	(336,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156654000,'Ili','伊犁哈萨克自治州',1156000020,0,'Non-tier City','未分级城市'),
	(337,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156650200,'Kelamayi','克拉玛依市',1156000023,3,'Third-tier City','三线城市'),
	(338,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156653000,'Kezilesu','克孜勒苏柯尔克孜自治州',1156000020,0,'Non-tier City','未分级城市'),
	(339,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156650000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(340,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156654200,'Tacheng','塔城地区',1156000020,0,'Non-tier City','未分级城市'),
	(341,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156652100,'Turpan','吐鲁番地区',1156000020,0,'Non-tier City','未分级城市'),
	(342,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156650400,'Turpancity','吐鲁番市',1156000020,0,'Non-tier City','未分级城市'),
	(343,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156650100,'Urumqi','乌鲁木齐市',1156000023,3,'Third-tier City','三线城市'),
	(344,1000000002,'Asia','亚洲',1156000000,'China','中国',1156650001,'Xinjiang','新疆维吾尔自治区',1156000015,'Northwest','西北地区',1156659000,'Xinjiangother','自治区直辖县级行政区划',1156000020,0,'Non-tier City','未分级城市'),
	(345,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530500,'Baoshan','保山市',1156000020,0,'Non-tier City','未分级城市'),
	(346,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156532300,'Chuxiong','楚雄彝族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(347,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156532900,'Dali','大理白族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(348,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156533100,'Dehong','德宏傣族景颇族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(349,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156533400,'Diqing','迪庆藏族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(350,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156532500,'Honghe','红河哈尼族彝族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(351,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530100,'Kunming','昆明市',1156000022,2,'Second-tier City','二线城市'),
	(352,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530700,'Lijiang','丽江市',1156000020,0,'Non-tier City','未分级城市'),
	(353,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530900,'Lincang','临沧市',1156000020,0,'Non-tier City','未分级城市'),
	(354,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156533300,'Nujiang','怒江傈僳族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(355,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530800,'Puer','普洱市',1156000020,0,'Non-tier City','未分级城市'),
	(356,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(357,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530300,'Qujing','曲靖市',1156000024,4,'Fourth-tier City','四线城市'),
	(358,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156532600,'Wenshan','文山壮族苗族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(359,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156532800,'Xishuangbanna','西双版纳傣族自治州',1156000020,0,'Non-tier City','未分级城市'),
	(360,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530400,'Yuxi','玉溪市',1156000023,3,'Third-tier City','三线城市'),
	(361,1000000002,'Asia','亚洲',1156000000,'China','中国',1156530001,'Yunnan','云南省',1156000017,'Southwest','西南地区',1156530600,'Zhaotong','昭通市',1156000020,0,'Non-tier City','未分级城市'),
	(362,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330100,'Hangzhou','杭州市',1156000022,2,'Second-tier City','二线城市'),
	(363,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330500,'Huzhou','湖州市',1156000023,3,'Third-tier City','三线城市'),
	(364,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330400,'Jiaxing','嘉兴市',1156000023,3,'Third-tier City','三线城市'),
	(365,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330700,'Jinhua','金华市',1156000023,3,'Third-tier City','三线城市'),
	(366,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156331100,'Lishui','丽水市',1156000024,4,'Fourth-tier City','四线城市'),
	(367,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330200,'Ningbo','宁波市',1156000022,2,'Second-tier City','二线城市'),
	(368,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330000,'Qita','其他',1156000020,0,'Non-tier City','未分级城市'),
	(369,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330800,'Quzhou','衢州市',1156000023,3,'Third-tier City','三线城市'),
	(370,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330600,'Shaoxing','绍兴市',1156000023,3,'Third-tier City','三线城市'),
	(371,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156331000,'Taizhou','台州市',1156000023,3,'Third-tier City','三线城市'),
	(372,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330300,'Wenzhou','温州市',1156000023,3,'Third-tier City','三线城市'),
	(373,1000000002,'Asia','亚洲',1156000000,'China','中国',1156330001,'Zhejiang','浙江省',1156000011,'East','华东地区',1156330900,'Zhoushan','舟山市',1156000023,3,'Third-tier City','三线城市'),
	(374,1000000002,'Asia','亚洲',1156000000,'China','中国',1156500001,'Chongqing','重庆市',1156000017,'Southwest','西南地区',1156500000,'Chongqing','重庆市',1156000022,2,'Second-tier City','二线城市'),
	(375,1000000001,'Afrika','非洲',1012000000,'Algeria','阿尔及利亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(376,1000000001,'Afrika','非洲',1818000000,'Egypt','埃及',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(377,1000000001,'Afrika','非洲',1231000000,'Ethiopia','埃塞俄比亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(378,1000000001,'Afrika','非洲',1024000000,'Angola','安哥拉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(379,1000000001,'Afrika','非洲',1204000000,'Benin','贝宁',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(380,1000000001,'Afrika','非洲',1072000000,'Botswana','博茨瓦纳',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(381,1000000001,'Afrika','非洲',1854000000,'Burkina Faso','布基纳法索',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(382,1000000001,'Afrika','非洲',1108000000,'Burundi','布隆迪',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(383,1000000001,'Afrika','非洲',1226000000,'Equatorial Guinea','赤道几内亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(384,1000000001,'Afrika','非洲',1768000000,'Togo','多哥',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(385,1000000001,'Afrika','非洲',1232000000,'Eritrea','厄立特里亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(386,1000000001,'Afrika','非洲',1260000000,'French Southern Territories','法属南部领地',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(387,1000000001,'Afrika','非洲',1132000000,'Cape Verde','佛得角',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(388,1000000001,'Afrika','非洲',1270000000,'Gambia','冈比亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(389,1000000001,'Afrika','非洲',1178000000,'Congo (Brazzaville)','刚果（布）',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(390,1000000001,'Afrika','非洲',1180000000,'Congo (DRC)','刚果（金）',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(391,1000000001,'Afrika','非洲',1262000000,'Djibouti','吉布提',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(392,1000000001,'Afrika','非洲',1324000000,'Guinea','几内亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(393,1000000001,'Afrika','非洲',1624000000,'Guinea-Bissau','几内亚比绍',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(394,1000000001,'Afrika','非洲',1288000000,'Ghana','加纳',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(395,1000000001,'Afrika','非洲',1266000000,'Gabon','加蓬',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(396,1000000001,'Afrika','非洲',1716000000,'Zimbabwe','津巴布韦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(397,1000000001,'Afrika','非洲',1120000000,'Cameroon','喀麦隆',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(398,1000000001,'Afrika','非洲',1174000000,'Comoros','科摩罗',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(399,1000000001,'Afrika','非洲',1384000000,'Ivory Coast','科特迪瓦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(400,1000000001,'Afrika','非洲',1404000000,'Kenya','肯尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(401,1000000001,'Afrika','非洲',1426000000,'Lesotho','莱索托',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(402,1000000001,'Afrika','非洲',1430000000,'Liberia','利比里亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(403,1000000001,'Afrika','非洲',1434000000,'Libya','利比亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(404,1000000001,'Afrika','非洲',1638000000,'Reunion','留尼汪',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(405,1000000001,'Afrika','非洲',1646000000,'Rwanda','卢旺达',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(406,1000000001,'Afrika','非洲',1450000000,'Madagascar','马达加斯加',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(407,1000000001,'Afrika','非洲',1454000000,'Mawlawi','马拉维',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(408,1000000001,'Afrika','非洲',1466000000,'Mali','马里',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(409,1000000001,'Afrika','非洲',1175000000,'Mayotte','马约特',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(410,1000000001,'Afrika','非洲',1480000000,'Mauritius','毛里求斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(411,1000000001,'Afrika','非洲',1478000000,'Mauritania','毛里塔尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(412,1000000001,'Afrika','非洲',1504000000,'Morocco','摩洛哥',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(413,1000000001,'Afrika','非洲',1508000000,'Mozambique','莫桑比克',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(414,1000000001,'Afrika','非洲',1516000000,'Namibia','纳米比亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(415,1000000001,'Afrika','非洲',1710000000,'South Africa','南非',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(416,1000000001,'Afrika','非洲',1728000000,'South Sultan','南苏丹',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(417,1000000001,'Afrika','非洲',1562000000,'Niger','尼日尔',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(418,1000000001,'Afrika','非洲',1566000000,'Nigeria','尼日利亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(419,1000000001,'Afrika','非洲',1694000000,'Sierra Leone','塞拉利昂',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(420,1000000001,'Afrika','非洲',1686000000,'Senegal','塞内加尔',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(421,1000000001,'Afrika','非洲',1690000000,'Seychelles','塞舌尔',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(422,1000000001,'Afrika','非洲',1678000000,'Sao Tome and Principe','圣多美和普林西比',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(423,1000000001,'Afrika','非洲',1654000000,'St. Helena','圣赫勒拿',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(424,1000000001,'Afrika','非洲',1748000000,'Swaziland','斯威士兰',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(425,1000000001,'Afrika','非洲',1729000000,'Sudan','苏丹',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(426,1000000001,'Afrika','非洲',1706000000,'Somalia','索马里',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(427,1000000001,'Afrika','非洲',1834000000,'Tanzania','坦桑尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(428,1000000001,'Afrika','非洲',1788000000,'Tunisia','突尼斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(429,1000000001,'Afrika','非洲',1800000000,'Uganda','乌干达',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(430,1000000001,'Afrika','非洲',1732000000,'Western Sahara','西撒哈拉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(431,1000000001,'Afrika','非洲',1894000000,'Zambia','赞比亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(432,1000000001,'Afrika','非洲',1148000000,'Chad','乍得',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(433,1000000001,'Afrika','非洲',1140000000,'Central African Republic','中非',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(434,1000000002,'Asia','亚洲',1004000000,'Afghanistan','阿富汗',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(435,1000000002,'Asia','亚洲',1784000000,'The United Arab Emirates','阿联酋',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(436,1000000002,'Asia','亚洲',1512000000,'Oman','阿曼',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(437,1000000002,'Asia','亚洲',1031000000,'Azerbaijan','阿塞拜疆',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(438,1000000002,'Asia','亚洲',1586000000,'Pakistan','巴基斯坦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(439,1000000002,'Asia','亚洲',1275000000,'Palestinian','巴勒斯坦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(440,1000000002,'Asia','亚洲',1048000000,'Bahrain','巴林',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(441,1000000002,'Asia','亚洲',1064000000,'Bhutan','不丹',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(442,1000000002,'Asia','亚洲',1408000000,'North Korea','朝鲜',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(443,1000000002,'Asia','亚洲',1626000000,'East Timor','东帝汶',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(444,1000000002,'Asia','亚洲',1608000000,'Philippines','菲律宾',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(445,1000000002,'Asia','亚洲',1268000000,'Georgia','格鲁吉亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(446,1000000002,'Asia','亚洲',1398000000,'Kazakhstan','哈萨克斯坦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(447,1000000002,'Asia','亚洲',1410000000,'South Korea','韩国',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(448,1000000002,'Asia','亚洲',1417000000,'Kyrgyzstan','吉尔吉斯斯坦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(449,1000000002,'Asia','亚洲',1116000000,'Cambodia','柬埔寨',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(450,1000000002,'Asia','亚洲',1634000000,'Qatar','卡塔尔',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(451,1000000002,'Asia','亚洲',1414000000,'Kuwait','科威特',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(452,1000000002,'Asia','亚洲',1418000000,'Laos','老挝',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(453,1000000002,'Asia','亚洲',1422000000,'Lebanon','黎巴嫩',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(454,1000000002,'Asia','亚洲',1462000000,'Maldives','马尔代夫',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(455,1000000002,'Asia','亚洲',1458000000,'Malaysia','马来西亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(456,1000000002,'Asia','亚洲',1496000000,'Mongolia','蒙古国；蒙古',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(457,1000000002,'Asia','亚洲',1050000000,'Bengal','孟加拉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(458,1000000002,'Asia','亚洲',1104000000,'Myanmar','缅甸',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(459,1000000002,'Asia','亚洲',1524000000,'Nepal','尼泊尔',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(460,1000000002,'Asia','亚洲',1392000000,'Japan','日本',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(461,1000000002,'Asia','亚洲',1196000000,'Cyprus','塞浦路斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(462,1000000002,'Asia','亚洲',1682000000,'Saudi Arabia','沙特阿拉伯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(463,1000000002,'Asia','亚洲',1144000000,'Sri Lanka','斯里兰卡',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(464,1000000002,'Asia','亚洲',1762000000,'Tajikistan','塔吉克斯坦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(465,1000000002,'Asia','亚洲',1764000000,'Thailand','泰国',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(466,1000000002,'Asia','亚洲',1792000000,'Turkey','土耳其',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(467,1000000002,'Asia','亚洲',1795000000,'Turkmenistan','土库曼斯坦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(468,1000000002,'Asia','亚洲',1096000000,'Brunei','文莱',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(469,1000000002,'Asia','亚洲',1860000000,'Uzbekistan','乌兹别克斯坦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(470,1000000002,'Asia','亚洲',1702000000,'Singapore','新加坡',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(471,1000000002,'Asia','亚洲',1760000000,'Syria','叙利亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(472,1000000002,'Asia','亚洲',1051000000,'Armenia','亚美尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(473,1000000002,'Asia','亚洲',1887000000,'Yemen','也门',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(474,1000000002,'Asia','亚洲',1368000000,'Iraq','伊拉克',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(475,1000000002,'Asia','亚洲',1364000000,'Iran','伊朗',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(476,1000000002,'Asia','亚洲',1376000000,'Israel','以色列',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(477,1000000002,'Asia','亚洲',1356000000,'India','印度',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(478,1000000002,'Asia','亚洲',1360000000,'Indonesia','印尼',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(479,1000000002,'Asia','亚洲',1400000000,'Jordan','约旦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(480,1000000002,'Asia','亚洲',1704000000,'Vietnam','越南',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(481,1000000002,'Asia','亚洲',1156000000,'China','中国',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(482,1000000003,'Europe','欧洲',1008000000,'Albania','阿尔巴尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(483,1000000003,'Europe','欧洲',1372000000,'Ireland','爱尔兰',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(484,1000000003,'Europe','欧洲',1233000000,'Estonia','爱沙尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(485,1000000003,'Europe','欧洲',1020000000,'Andorra','安道尔',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(486,1000000003,'Europe','欧洲',1660000000,'Anguilla','安圭拉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(487,1000000003,'Europe','欧洲',1040000000,'Austria','奥地利',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(488,1000000003,'Europe','欧洲',1112000000,'Belarus','白俄罗斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(489,1000000003,'Europe','欧洲',1060000000,'Bermuda','百慕大',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(490,1000000003,'Europe','欧洲',1100000000,'Bulgaria','保加利亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(491,1000000003,'Europe','欧洲',1056000000,'Belgium','比利时',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(492,1000000003,'Europe','欧洲',1352000000,'Iceland','冰岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(493,1000000003,'Europe','欧洲',1070000000,'Bosnia and Herzegovina','波黑',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(494,1000000003,'Europe','欧洲',1616000000,'Poland','波兰',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(495,1000000003,'Europe','欧洲',1208000000,'Denmark','丹麦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(496,1000000003,'Europe','欧洲',1276000000,'Germany','德国',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(497,1000000003,'Europe','欧洲',1643000000,'Russia','俄罗斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(498,1000000003,'Europe','欧洲',1250000000,'France','法国',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(499,1000000003,'Europe','欧洲',1234000000,'Faroe Islands','法罗群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(500,1000000003,'Europe','欧洲',1663000000,'French Saint Martin','法属圣马丁',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(501,1000000003,'Europe','欧洲',1336000000,'Vatican','梵蒂冈',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(502,1000000003,'Europe','欧洲',1246000000,'Finland','芬兰',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(503,1000000003,'Europe','欧洲',1831000000,'Guernsey','根西岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(504,1000000003,'Europe','欧洲',1528000000,'Netherlands','荷兰',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(505,1000000003,'Europe','欧洲',1535000000,'Netherlands Saint Martin','荷属圣马丁',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(506,1000000003,'Europe','欧洲',1534000000,'Caribbean Netherlands','荷兰加勒比区',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(507,1000000003,'Europe','欧洲',1499000000,'Montenegro','黑山',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(508,1000000003,'Europe','欧洲',1203000000,'Czech','捷克',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(509,1000000003,'Europe','欧洲',1191000000,'Croatia','克罗地亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(510,1000000003,'Europe','欧洲',1428000000,'Latvia','拉脱维亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(511,1000000003,'Europe','欧洲',1440000000,'Lithuania','立陶宛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(512,1000000003,'Europe','欧洲',1438000000,'Liechtenstein','列支敦士登',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(513,1000000003,'Europe','欧洲',1442000000,'Luxembourg','卢森堡',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(514,1000000003,'Europe','欧洲',1642000000,'Romania','罗马尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(515,1000000003,'Europe','欧洲',1833000000,'Isle of Man','马恩岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(516,1000000003,'Europe','欧洲',1238000000,'Malvinas Islands (Falkland)','马尔维纳斯群岛（福克兰）',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(517,1000000003,'Europe','欧洲',1470000000,'Malta','马耳他',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(518,1000000003,'Europe','欧洲',1807000000,'Macedonia','马其顿',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(519,1000000003,'Europe','欧洲',1474000000,'Martinique','马提尼克',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(520,1000000003,'Europe','欧洲',1500000000,'Montserrat','蒙塞拉特岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(521,1000000003,'Europe','欧洲',1498000000,'Moldova','摩尔多瓦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(522,1000000003,'Europe','欧洲',1492000000,'Monaco','摩纳哥',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(523,1000000003,'Europe','欧洲',1239000000,'South Georgia and The South Sandwich Islands','南乔治亚岛和南桑威奇群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(524,1000000003,'Europe','欧洲',1578000000,'Norway','挪威',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(525,1000000003,'Europe','欧洲',1620000000,'Portugal','葡萄牙',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(526,1000000003,'Europe','欧洲',1752000000,'Sweden','瑞典',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(527,1000000003,'Europe','欧洲',1756000000,'Switzerland','瑞士',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(528,1000000003,'Europe','欧洲',1688000000,'Serbia','塞尔维亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(529,1000000003,'Europe','欧洲',1674000000,'San Marino','圣马力诺',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(530,1000000003,'Europe','欧洲',1703000000,'Slovakia','斯洛伐克',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(531,1000000003,'Europe','欧洲',1705000000,'Slovenia','斯洛文尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(532,1000000003,'Europe','欧洲',1744000000,'Svalbard and Jan Mayen','斯瓦尔巴群岛和扬马延岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(533,1000000003,'Europe','欧洲',1804000000,'Ukraine','乌克兰',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(534,1000000003,'Europe','欧洲',1724000000,'Spain','西班牙',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(535,1000000003,'Europe','欧洲',1300000000,'Greece','希腊',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(536,1000000003,'Europe','欧洲',1348000000,'Hungary','匈牙利',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(537,1000000003,'Europe','欧洲',1380000000,'Italy','意大利',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(538,1000000003,'Europe','欧洲',1826000000,'United Kingdom','英国',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(539,1000000003,'Europe','欧洲',1086000000,'British India Ocean Territory','英属印度洋领地',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(540,1000000003,'Europe','欧洲',1832000000,'Jersey','泽西岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(541,1000000003,'Europe','欧洲',1292000000,'Gibraltar','直布罗陀',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(542,1000000004,'North','北美洲',1028000000,'Antigua and Barbuda','安提瓜和巴布达',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(543,1000000004,'North','北美洲',1052000000,'Barbados','巴巴多斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(544,1000000004,'North','北美洲',1044000000,'The Bahamas','巴哈马',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(545,1000000004,'North','北美洲',1591000000,'Panama','巴拿马',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(546,1000000004,'North','北美洲',1580000000,'Northern Mariana Islands','北马里亚纳群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(547,1000000004,'North','北美洲',1630000000,'Puerto Rico','波多黎各',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(548,1000000004,'North','北美洲',1084000000,'Belize','伯利兹',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(549,1000000004,'North','北美洲',1214000000,'Dominican Republic','多米尼加',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(550,1000000004,'North','北美洲',1212000000,'Dominica','多米尼克',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(551,1000000004,'North','北美洲',1188000000,'Costa Rica','哥斯达黎加',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(552,1000000004,'North','北美洲',1308000000,'Grenada','格林纳达',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(553,1000000004,'North','北美洲',1304000000,'Greenland','格陵兰',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(554,1000000004,'North','北美洲',1192000000,'Cuba','古巴',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(555,1000000004,'North','北美洲',1312000000,'Guadeloupe','瓜德罗普',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(556,1000000004,'North','北美洲',1332000000,'Haiti','海地',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(557,1000000004,'North','北美洲',1340000000,'Honduras','洪都拉斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(558,1000000004,'North','北美洲',1124000000,'Canada','加拿大',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(559,1000000004,'North','北美洲',1136000000,'Cayman Islands','开曼群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(560,1000000004,'North','北美洲',1531000000,'Curacao','库拉索',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(561,1000000004,'North','北美洲',1840000000,'United States','美国',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(562,1000000004,'North','北美洲',1581000000,'United States Minor Outlying Islands','美国本土外小岛屿',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(563,1000000004,'North','北美洲',1850000000,'United States Virgin Islands','美属维尔京群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(564,1000000004,'North','北美洲',1484000000,'Mexico','墨西哥',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(565,1000000004,'North','北美洲',1558000000,'Nicaragua','尼加拉瓜',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(566,1000000004,'North','北美洲',1222000000,'El Salvador','萨尔瓦多',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(567,1000000004,'North','北美洲',1652000000,'St. Barthelemy','圣巴泰勒米岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(568,1000000004,'North','北美洲',1659000000,'Saint Kitts and Nevis','圣基茨和尼维斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(569,1000000004,'North','北美洲',1662000000,'Saint Lucia','圣卢西亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(570,1000000004,'North','北美洲',1666000000,'St Pierre and Miquelon','圣皮埃尔和密克隆',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(571,1000000004,'North','北美洲',1670000000,'Saint Vincent and the Grenadines','圣文森特和格林纳丁斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(572,1000000004,'North','北美洲',1780000000,'Trinidad and Tobago','特立尼达和多巴哥',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(573,1000000004,'North','北美洲',1320000000,'Guatemala','危地马拉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(574,1000000004,'North','北美洲',1388000000,'Jamaica','牙买加',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(575,1000000004,'North','北美洲',1092000000,'British Virgin Islands','英属维尔京群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(576,1000000005,'Oceania','大洋洲',1036000000,'Australia','澳大利亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(577,1000000005,'Oceania','大洋洲',1598000000,'Papua New Guinea','巴布亚新几内亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(578,1000000005,'Oceania','大洋洲',1258000000,'French Polynesia','法属波利尼西亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(579,1000000005,'Oceania','大洋洲',1242000000,'Fiji Islands','斐济群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(580,1000000005,'Oceania','大洋洲',1316000000,'Guam','关岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(581,1000000005,'Oceania','大洋洲',1334000000,'Heard Island and McDonald Islands','赫德岛和麦克唐纳群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(582,1000000005,'Oceania','大洋洲',1296000000,'Kiribati','基里巴斯',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(583,1000000005,'Oceania','大洋洲',1166000000,'The Cocos Islands','科科斯群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(584,1000000005,'Oceania','大洋洲',1184000000,'Cook Islands','库克群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(585,1000000005,'Oceania','大洋洲',1584000000,'Marshall Islands','马绍尔群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(586,1000000005,'Oceania','大洋洲',1016000000,'American Samoa','美属萨摩亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(587,1000000005,'Oceania','大洋洲',1583000000,'Federated States of Micronesia','密克罗尼西亚联邦',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(588,1000000005,'Oceania','大洋洲',1520000000,'Nauru','瑙鲁',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(589,1000000005,'Oceania','大洋洲',1570000000,'Niue','纽埃',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(590,1000000005,'Oceania','大洋洲',1574000000,'Norfolk Island','诺福克岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(591,1000000005,'Oceania','大洋洲',1585000000,'Palau','帕劳',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(592,1000000005,'Oceania','大洋洲',1612000000,'Pitcairn Islands','皮特凯恩群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(593,1000000005,'Oceania','大洋洲',1882000000,'Samoa','萨摩亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(594,1000000005,'Oceania','大洋洲',1162000000,'Christmas Island','圣诞岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(595,1000000005,'Oceania','大洋洲',1090000000,'Salomon Islands','所罗门群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(596,1000000005,'Oceania','大洋洲',1776000000,'Tonga','汤加',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(597,1000000005,'Oceania','大洋洲',1796000000,'Turks and Caicos Islands','特克斯和凯科斯群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(598,1000000005,'Oceania','大洋洲',1798000000,'Tuvalu','图瓦卢',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(599,1000000005,'Oceania','大洋洲',1772000000,'Tokelau','托克劳',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(600,1000000005,'Oceania','大洋洲',1876000000,'Wallis and Futuna','瓦利斯和富图纳',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(601,1000000005,'Oceania','大洋洲',1548000000,'Vanuatu','瓦努阿图',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(602,1000000005,'Oceania','大洋洲',1540000000,'New Caledonia','新喀里多尼亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(603,1000000005,'Oceania','大洋洲',1554000000,'New Zealand','新西兰',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(604,1000000006,'South','南美洲',1032000000,'Argentina','阿根廷',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(605,1000000006,'South','南美洲',1533000000,'Aruba','阿鲁巴',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(606,1000000006,'South','南美洲',1248000000,'Aland Islands','奥兰群岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(607,1000000006,'South','南美洲',1600000000,'Paraguay','巴拉圭',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(608,1000000006,'South','南美洲',1076000000,'Brazil','巴西',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(609,1000000006,'South','南美洲',1068000000,'Bolivia','玻利维亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(610,1000000006,'South','南美洲',1074000000,'Bouvet Island','布韦岛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(611,1000000006,'South','南美洲',1218000000,'Ecuador','厄瓜多尔',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(612,1000000006,'South','南美洲',1254000000,'French Guiana','法属圭亚那',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(613,1000000006,'South','南美洲',1170000000,'Colombia','哥伦比亚',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(614,1000000006,'South','南美洲',1328000000,'Guyana','圭亚那',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(615,1000000006,'South','南美洲',1604000000,'Peru','秘鲁',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(616,1000000006,'South','南美洲',1740000000,'Suriname','苏里南',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(617,1000000006,'South','南美洲',1862000000,'Venezuela','委内瑞拉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(618,1000000006,'South','南美洲',1858000000,'Uruguay','乌拉圭',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(619,1000000006,'South','南美洲',1152000000,'Chile','智利',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(620,1000000007,'Global','全球',1000000000,'Global','全球',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table message_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `message_template`;

CREATE TABLE `message_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `locale` varchar(10) NOT NULL,
  `module_id` int(11) NOT NULL,
  `message_code` varchar(50) NOT NULL COMMENT '代表模板用于哪个功能',
  PRIMARY KEY (`id`),
  KEY `fk_message_template_module1_idx` (`module_id`),
  CONSTRAINT `fk_message_template_module1` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `message_template` WRITE;
/*!40000 ALTER TABLE `message_template` DISABLE KEYS */;

INSERT INTO `message_template` (`id`, `title`, `content`, `locale`, `module_id`, `message_code`)
VALUES
	(1,'app购买申请','您好，你的操作员申请购买app，url为<a href=\"{0}\">{0}</a>','zh_CN',6,'AGENCY_OPERATOR_GET_APP');

/*!40000 ALTER TABLE `message_template` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table module
# ------------------------------------------------------------

DROP TABLE IF EXISTS `module`;

CREATE TABLE `module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '默认的名称',
  `visible` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 不显示，1显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;

INSERT INTO `module` (`id`, `name`, `visible`)
VALUES
	(1,'iAudience',1),
	(2,'iAccess',1),
	(3,'iActive',1),
	(4,'iExperience',1),
	(5,'iNsights',1),
	(6,'iApps',1);

/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table operation_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `operation_log`;

CREATE TABLE `operation_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_code` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip` varchar(30) NOT NULL,
  `operation_time` datetime NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_operation_log_module1_idx` (`module_id`),
  CONSTRAINT `fk_operation_log_module1` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table preview_pictures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `preview_pictures`;

CREATE TABLE `preview_pictures` (
  `id` int(11) NOT NULL,
  `url` varchar(1000) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_preview_pictures_app_info1_idx` (`app_id`),
  CONSTRAINT `fk_preview_pictures_app_info1` FOREIGN KEY (`app_id`) REFERENCES `app_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `preview_pictures` WRITE;
/*!40000 ALTER TABLE `preview_pictures` DISABLE KEYS */;

INSERT INTO `preview_pictures` (`id`, `url`, `app_id`)
VALUES
	(1,'http://static.symphony.optimix.local/images/test.png',1),
	(2,'http://static.symphony.optimix.local/images/test2.png',1),
	(3,'http://static.symphony.optimix.local/images/test.png',1),
	(4,'http://static.symphony.optimix.local/images/test.png',2),
	(5,'http://static.symphony.optimix.local/images/test2.png',2),
	(6,'http://static.symphony.optimix.local/images/test.png',3),
	(7,'http://static.symphony.optimix.local/images/test.png',3),
	(8,'http://static.symphony.optimix.local/images/test2.png',4),
	(9,'http://static.symphony.optimix.local/images/test.png',4),
	(10,'http://static.symphony.optimix.local/images/test.png',5),
	(11,'http://static.symphony.optimix.local/images/test2.png',5),
	(12,'http://static.symphony.optimix.local/images/test.png',6),
	(13,'http://static.symphony.optimix.local/images/test.png',6),
	(14,'http://static.symphony.optimix.local/images/test2.png',7),
	(15,'http://static.symphony.optimix.local/images/test.png',7),
	(16,'http://static.symphony.optimix.local/images/test.png',8),
	(17,'http://static.symphony.optimix.local/images/test2.png',8),
	(18,'http://static.symphony.optimix.local/images/test.png',8),
	(19,'http://static.symphony.optimix.local/images/test.png',9),
	(20,'http://static.symphony.optimix.local/images/test2.png',9),
	(21,'http://static.symphony.optimix.local/images/test.png',9),
	(22,'http://static.symphony.optimix.local/images/test.png',10),
	(23,'http://static.symphony.optimix.local/images/test2.png',10),
	(24,'http://static.symphony.optimix.local/images/test.png',10),
	(25,'http://static.symphony.optimix.local/images/test.png',11),
	(26,'http://static.symphony.optimix.local/images/test2.png',11),
	(27,'http://static.symphony.optimix.local/images/test.png',11);

/*!40000 ALTER TABLE `preview_pictures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table site_message
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site_message`;

CREATE TABLE `site_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `send_user_id` int(11) NOT NULL,
  `send_time` datetime NOT NULL,
  `receive_user_id` int(11) NOT NULL,
  `batch_code` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `template_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_site_message_message_template1_idx` (`template_id`),
  CONSTRAINT `fk_site_message_message_template1` FOREIGN KEY (`template_id`) REFERENCES `message_template` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `site_message` WRITE;
/*!40000 ALTER TABLE `site_message` DISABLE KEYS */;

INSERT INTO `site_message` (`id`, `title`, `content`, `send_user_id`, `send_time`, `receive_user_id`, `batch_code`, `status`, `template_id`)
VALUES
	(1,'app购买申请','您好，你的操作员申请购买app，url为<a href=\"http://symphony.optimix.asia:8080/iapps/app/list?openAppId=1&priceId=null\">http://symphony.optimix.asia:8080/iapps/app/list?openAppId=1&priceId=null</a>',2,'2017-04-12 18:06:47',1,NULL,1,1);

/*!40000 ALTER TABLE `site_message` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_app
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_app`;

CREATE TABLE `user_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `active_time` datetime NOT NULL,
  `buy_num` int(11) DEFAULT '0',
  `use_num` int(11) DEFAULT '0',
  `expire_time` datetime DEFAULT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_app_app_info1_idx` (`app_id`),
  CONSTRAINT `fk_user_app_app_info1` FOREIGN KEY (`app_id`) REFERENCES `app_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_app` WRITE;
/*!40000 ALTER TABLE `user_app` DISABLE KEYS */;

INSERT INTO `user_app` (`id`, `user_id`, `active_time`, `buy_num`, `use_num`, `expire_time`, `app_id`)
VALUES
	(1,1,'2017-04-12 08:05:51',0,0,'2017-05-12 08:05:51',1),
	(4,1,'2017-04-13 08:04:59',0,0,NULL,4),
	(5,1,'2017-04-13 08:13:14',0,0,'2017-07-13 08:13:14',2);

/*!40000 ALTER TABLE `user_app` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Dumping routines (FUNCTION) for database 'iaudience'
--
DELIMITER ;;

# Dump of FUNCTION click_kwid_lookup
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `click_kwid_lookup` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
# Dump of FUNCTION click_kw_text_lookup
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `click_kw_text_lookup` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
# Dump of FUNCTION csa_update_logged
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `csa_update_logged` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
# Dump of FUNCTION FIRST_DAY
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `FIRST_DAY` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
# Dump of FUNCTION get_eff_cx_rate
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `get_eff_cx_rate` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
# Dump of FUNCTION get_eff_cx_rate_map
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `get_eff_cx_rate_map` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
# Dump of FUNCTION SPLIT_STR
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `SPLIT_STR` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
# Dump of FUNCTION url_decode
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `url_decode` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
# Dump of FUNCTION url_decode_2
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `url_decode_2` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
