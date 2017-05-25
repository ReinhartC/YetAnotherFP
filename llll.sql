/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.1.21-MariaDB : Database - mydragon
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mydragon` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `mydragon`;

/*Table structure for table `naga` */

DROP TABLE IF EXISTS `naga`;

CREATE TABLE `naga` (
  `spesies_ID` tinyint(4) NOT NULL,
  `spesies_nama` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`spesies_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `naga` */

insert  into `naga`(`spesies_ID`,`spesies_nama`) values (1,'Western Dragon'),(2,'Eastern Dragon'),(3,'Furdragon'),(4,'Wyvern'),(5,'Lizardus'),(6,'Dino'),(7,'Pterodragon'),(8,'Felidragon'),(9,'Dark Dragon'),(10,'Plesiodragon'),(11,'Canidragon');

/*Table structure for table `naga_player` */

DROP TABLE IF EXISTS `naga_player`;

CREATE TABLE `naga_player` (
  `naga_ID` smallint(6) NOT NULL AUTO_INCREMENT,
  `usr_ID` int(8) DEFAULT NULL,
  `spesies_ID` tinyint(4) DEFAULT NULL,
  `naga_nama` varchar(16) DEFAULT NULL,
  `naga_tgl_lahir` date DEFAULT NULL,
  `naga_level` tinyint(4) DEFAULT NULL,
  `XP` smallint(6) DEFAULT NULL,
  `lapar` tinyint(4) DEFAULT NULL,
  `senang` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`naga_ID`),
  KEY `fk_jenis_naga` (`spesies_ID`),
  KEY `fk_pemilik_naga` (`usr_ID`),
  CONSTRAINT `fk_jenis_naga` FOREIGN KEY (`spesies_ID`) REFERENCES `naga` (`spesies_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pemilik_naga` FOREIGN KEY (`usr_ID`) REFERENCES `usr_account` (`usr_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `naga_player` */

insert  into `naga_player`(`naga_ID`,`usr_ID`,`spesies_ID`,`naga_nama`,`naga_tgl_lahir`,`naga_level`,`XP`,`lapar`,`senang`) values (1,1,5,'naga','2017-05-22',0,0,100,100),(2,2,5,'tes1','2017-05-22',0,0,100,100),(3,3,5,'otong','2017-05-22',0,0,100,100),(4,4,5,'azka','2017-05-23',35,767,100,100),(5,5,5,'hehe','2017-05-23',0,0,100,100),(6,6,5,NULL,'2017-05-23',0,0,100,100),(7,4,6,'yasin','2017-05-24',0,0,100,100);

/*Table structure for table `usr_account` */

DROP TABLE IF EXISTS `usr_account`;

CREATE TABLE `usr_account` (
  `usr_ID` int(8) NOT NULL AUTO_INCREMENT,
  `usr_nama` varchar(32) NOT NULL,
  `usr_email` varchar(32) NOT NULL,
  `usr_password` char(32) NOT NULL,
  `usr_uang` int(11) DEFAULT NULL,
  `usr_t0` datetime DEFAULT NULL,
  `usr_jumlah_naga` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`usr_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `usr_account` */

insert  into `usr_account`(`usr_ID`,`usr_nama`,`usr_email`,`usr_password`,`usr_uang`,`usr_t0`,`usr_jumlah_naga`) values (1,'coba','coba@gmail.com','c3ec0f7b054e729c5a716c8125839829',NULL,NULL,NULL),(2,'tes','tes@gmail.com','28b662d883b6d76fd96e4ddc5e9ba780',NULL,NULL,NULL),(3,'otong','otong@gmail.com','f8210b5a6219450b5f0082654fecd92c',NULL,NULL,NULL),(4,'azka','azka@gmail.com','cac4ad62a53731fc058f16a244d5a3cb',NULL,'2017-05-23 15:03:03',2),(5,'hehe','hehehe@gmail.com','529ca8050a00180790cf88b63468826a',NULL,NULL,NULL),(6,'yeye','yeye@gmail.com','d9d5cba7c445bd9f8dfb1f8616b2380d',32767,'2017-05-23 15:03:03',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
