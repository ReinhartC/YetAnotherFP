/*
SQLyog Ultimate v12.4.1 (64 bit)
MySQL - 10.1.21-MariaDB : Database - mydragon
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

/*Table structure for table `aktivitas` */

DROP TABLE IF EXISTS `aktivitas`;

CREATE TABLE `aktivitas` (
  `aktivitas_ID` tinyint(4) NOT NULL,
  `aktivitas_nama` varchar(64) DEFAULT NULL,
  `efek_XP` smallint(6) DEFAULT NULL,
  `efek_lapar` tinyint(4) DEFAULT NULL,
  `efek_senang` tinyint(4) DEFAULT NULL,
  `efek_uang` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`aktivitas_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `aktivitas` */

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `item_ID` tinyint(4) NOT NULL,
  `item_nama` varchar(32) DEFAULT NULL,
  `foto` varchar(64) DEFAULT NULL,
  `tambah_XP` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `item` */

/*Table structure for table `naga` */

DROP TABLE IF EXISTS `naga`;

CREATE TABLE `naga` (
  `spesies_ID` tinyint(4) NOT NULL,
  `spesies_nama` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`spesies_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `naga` */

insert  into `naga`(`spesies_ID`,`spesies_nama`) values 
(1,'Western Dragon'),
(2,'Eastern Dragon'),
(3,'Furdragon'),
(4,'Wyvern'),
(5,'Lizardus'),
(6,'Dino'),
(7,'Pterodragon'),
(8,'Felidragon'),
(9,'Dark Dragon'),
(10,'Plesiodragon'),
(11,'Canidragon');

/*Table structure for table `naga_item` */

DROP TABLE IF EXISTS `naga_item`;

CREATE TABLE `naga_item` (
  `item_naga_ID` smallint(6) NOT NULL,
  `naga_ID` smallint(6) DEFAULT NULL,
  `item_ID` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`item_naga_ID`),
  KEY `fk_jenis_item` (`item_ID`),
  KEY `fk_pemilik_item` (`naga_ID`),
  CONSTRAINT `fk_jenis_item` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pemilik_item` FOREIGN KEY (`naga_ID`) REFERENCES `naga_player` (`naga_ID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `naga_item` */

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `naga_player` */

insert  into `naga_player`(`naga_ID`,`usr_ID`,`spesies_ID`,`naga_nama`,`naga_tgl_lahir`,`naga_level`,`XP`,`lapar`,`senang`) values 
(1,1,5,'naga','2017-05-22',0,0,100,100),
(2,2,5,'tes1','2017-05-22',0,0,100,100),
(3,3,5,'otong','2017-05-22',0,0,100,100),
(4,4,5,'azka','2017-05-23',35,767,100,100),
(5,5,5,'hehe','2017-05-23',0,0,100,100),
(6,6,5,NULL,'2017-05-23',0,0,100,100),
(7,4,6,'yasin','2017-05-24',0,0,100,100),
(8,7,5,NULL,'2017-05-23',0,0,100,100),
(9,8,5,NULL,'2017-05-23',0,0,100,100),
(10,9,5,'Dominator','2017-05-23',0,0,100,100);

/*Table structure for table `setting` */

DROP TABLE IF EXISTS `setting`;

CREATE TABLE `setting` (
  `V` smallint(6) DEFAULT NULL,
  `dt` smallint(6) DEFAULT NULL,
  `exp_V` smallint(6) DEFAULT NULL,
  `exp_dt` smallint(6) DEFAULT NULL,
  `exp_Vmax` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `setting` */

insert  into `setting`(`V`,`dt`,`exp_V`,`exp_dt`,`exp_Vmax`) values 
(100,5,10,5,1000);

/*Table structure for table `setting_energi` */

DROP TABLE IF EXISTS `setting_energi`;

CREATE TABLE `setting_energi` (
  `V` smallint(6) DEFAULT NULL,
  `dt` smallint(6) DEFAULT NULL,
  `Vmax` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `setting_energi` */

/*Table structure for table `stage` */

DROP TABLE IF EXISTS `stage`;

CREATE TABLE `stage` (
  `stage_ID` tinyint(4) NOT NULL,
  `stage` tinyint(4) DEFAULT NULL,
  `image` varchar(64) DEFAULT NULL,
  `icon` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`stage_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `stage` */

insert  into `stage`(`stage_ID`,`stage`,`image`,`icon`) values 
(1,1,'images/CaniDragon/1.gif','images/CaniDragon/i1.gif'),
(2,1,'images/CaniDragon/2.gif','images/CaniDragon/i2.gif'),
(3,1,'images/CaniDragon/3.gif','images/CaniDragon/i3.gif'),
(4,1,'images/CaniDragon/4.gif','images/CaniDragon/i4.gif'),
(5,1,'images/CaniDragon/5.gif','images/CaniDragon/i5.gif'),
(6,1,'images/CaniDragon/6.gif','images/CaniDragon/i6.gif'),
(7,2,'images/DarkDragon/1.gif','images/DarkDragon/i1.gif'),
(8,2,'images/DarkDragon/2.gif','images/DarkDragon/i2.gif'),
(9,2,'images/DarkDragon/3.gif','images/DarkDragon/i3.gif'),
(10,2,'images/DarkDragon/4.gif','images/DarkDragon/i4.gif'),
(11,2,'images/DarkDragon/5.gif','images/DarkDragon/i5.gif'),
(12,2,'images/DarkDragon/6.gif','images/DarkDragon/i6.gif'),
(13,3,'images/Dino/1.gif','images/Dino/i1.gif'),
(14,3,'images/Dino/2.gif','images/Dino/i2.gif'),
(15,3,'images/Dino/3.gif','images/Dino/i3.gif'),
(16,3,'images/Dino/4.gif','images/Dino/i4.gif'),
(17,3,'images/Dino/5.gif','images/Dino/i5.gif'),
(18,3,'images/Dino/6.gif','images/Dino/i6.gif'),
(19,4,'images/EasternDragon/1.gif','images/EasternDragon/i1.gif'),
(20,4,'images/EasternDragon/2.gif','images/EasternDragon/i2.gif'),
(21,4,'images/EasternDragon/3.gif','images/EasternDragon/i3.gif'),
(22,4,'images/EasternDragon/4.gif','images/EasternDragon/i4.gif'),
(23,4,'images/EasternDragon/5.gif','images/EasternDragon/i5.gif'),
(24,4,'images/EasternDragon/6.gif','images/EasternDragon/i6.gif'),
(25,5,'images/FeliDragon/1.gif','images/FeliDragon/i1.gif'),
(26,5,'images/FeliDragon/2.gif','images/FeliDragon/i2.gif'),
(27,5,'images/FeliDragon/3.gif','images/FeliDragon/i3.gif'),
(28,5,'images/FeliDragon/4.gif','images/FeliDragon/i4.gif'),
(29,5,'images/FeliDragon/5.gif','images/FeliDragon/i5.gif'),
(30,5,'images/FeliDragon/6.gif','images/FeliDragon/i6.gif'),
(31,6,'images/FurdDragon/1.gif','images/FurdDragon/i1.gif'),
(32,6,'images/FurdDragon/2.gif','images/FurdDragon/i2.gif'),
(33,6,'images/FurdDragon/3.gif','images/FurdDragon/i3.gif'),
(34,6,'images/FurdDragon/4.gif','images/FurdDragon/i4.gif'),
(35,6,'images/FurdDragon/5.gif','images/FurdDragon/i5.gif'),
(36,6,'images/FurdDragon/6.gif','images/FurdDragon/i6.gif'),
(37,7,'images/Lizardus/1.gif','images/Lizardus/i1.gif'),
(38,7,'images/Lizardus/2.gif','images/Lizardus/i2.gif'),
(39,7,'images/Lizardus/3.gif','images/Lizardus/i3.gif'),
(40,7,'images/Lizardus/4.gif','images/Lizardus/i4.gif'),
(41,7,'images/Lizardus/5.gif','images/Lizardus/i5.gif'),
(42,7,'images/Lizardus/6.gif','images/Lizardus/i6.gif'),
(43,8,'images/PlesioDragon/1.gif','images/PlesioDragon/i1.gif'),
(44,8,'images/PlesioDragon/2.gif','images/PlesioDragon/i2.gif'),
(45,8,'images/PlesioDragon/3.gif','images/PlesioDragon/i3.gif'),
(46,8,'images/PlesioDragon/4.gif','images/PlesioDragon/i4.gif'),
(47,8,'images/PlesioDragon/5.gif','images/PlesioDragon/i5.gif'),
(48,8,'images/PlesioDragon/6.gif','images/PlesioDragon/i6.gif'),
(49,9,'images/PteroDragon/1.gif','images/PteroDragon/i1.gif'),
(50,9,'images/PteroDragon/2.gif','images/PteroDragon/i2.gif'),
(51,9,'images/PteroDragon/3.gif','images/PteroDragon/i3.gif'),
(52,9,'images/PteroDragon/4.gif','images/PteroDragon/i4.gif'),
(53,9,'images/PteroDragon/5.gif','images/PteroDragon/i5.gif'),
(54,9,'images/PteroDragon/6.gif','images/PteroDragon/i6.gif'),
(55,10,'images/WesternDragon/1.gif','images/WesternDragon/i1.gif'),
(56,10,'images/WesternDragon/2.gif','images/WesternDragon/i2.gif'),
(57,10,'images/WesternDragon/3.gif','images/WesternDragon/i3.gif'),
(58,10,'images/WesternDragon/4.gif','images/WesternDragon/i4.gif'),
(59,10,'images/WesternDragon/5.gif','images/WesternDragon/i5.gif'),
(60,10,'images/WesternDragon/6.gif','images/WesternDragon/i6.gif'),
(61,11,'images/Wyvern/1.gif','images/Wyvern/i1.gif'),
(62,11,'images/Wyvern/2.gif','images/Wyvern/i2.gif'),
(63,11,'images/Wyvern/3.gif','images/Wyvern/i3.gif'),
(64,11,'images/Wyvern/4.gif','images/Wyvern/i4.gif'),
(65,11,'images/Wyvern/5.gif','images/Wyvern/i5.gif'),
(66,11,'images/Wyvern/6.gif','images/Wyvern/i6.gif');

/*Table structure for table `stage_naga` */

DROP TABLE IF EXISTS `stage_naga`;

CREATE TABLE `stage_naga` (
  `spesies_ID` tinyint(4) DEFAULT NULL,
  `stage_ID` tinyint(4) DEFAULT NULL,
  KEY `fk_spesies_naga` (`spesies_ID`),
  KEY `fk_stage_naga` (`stage_ID`),
  CONSTRAINT `fk_spesies_naga` FOREIGN KEY (`spesies_ID`) REFERENCES `naga` (`spesies_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stage_naga` FOREIGN KEY (`stage_ID`) REFERENCES `stage` (`stage_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `stage_naga` */

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `usr_account` */

insert  into `usr_account`(`usr_ID`,`usr_nama`,`usr_email`,`usr_password`,`usr_uang`,`usr_t0`,`usr_jumlah_naga`) values 
(1,'coba','coba@gmail.com','c3ec0f7b054e729c5a716c8125839829',NULL,NULL,NULL),
(2,'tes','tes@gmail.com','28b662d883b6d76fd96e4ddc5e9ba780',NULL,NULL,NULL),
(3,'otong','otong@gmail.com','f8210b5a6219450b5f0082654fecd92c',NULL,NULL,NULL),
(4,'azka','azka@gmail.com','cac4ad62a53731fc058f16a244d5a3cb',NULL,'2017-05-23 15:03:03',2),
(5,'hehe','hehehe@gmail.com','529ca8050a00180790cf88b63468826a',NULL,NULL,NULL),
(6,'yeye','yeye@gmail.com','d9d5cba7c445bd9f8dfb1f8616b2380d',32767,'2017-05-23 15:03:03',NULL),
(7,'b','obio','084fbd8e3d514837b19d1a8ea23565a1',NULL,'2017-05-23 19:28:11',NULL),
(8,'bio','coba@coba.com','3b5f54699c3bcb4c91d9e6aed65adead',NULL,'2017-05-23 19:28:23',1),
(9,'ReinhartC','sgs3.rc@gmail.com','e99a18c428cb38d5f260853678922e03',100,'2017-05-23 19:29:20',1);

/* Function  structure for function  `fn_EN` */

/*!50003 DROP FUNCTION IF EXISTS `fn_EN` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fn_EN`(p_Exp_s0 TINYINT, p_Exp_t0 DATETIME) RETURNS tinyint(4)
BEGIN
		SELECT exp_V, exp_dt, exp_Vmax FROM _setting
			INTO @Exp_v, @Exp_durasi_in_sec, @Exp_max;
		
		SET @Exp = p_Exp_s0 + (@Exp_v/@Exp_durasi_in_sec) 
			* (TIMEDIFF( NOW(), p_Exp_t0));
		
		IF (@Exp > @Exp_max) THEN
			SET @Exp = @Exp_max;
		END IF;
	RETURN @Exp;
    END */$$
DELIMITER ;

/* Function  structure for function  `fn_id` */

/*!50003 DROP FUNCTION IF EXISTS `fn_id` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fn_id`(p_nama varchar (32)) RETURNS tinyint(4)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @id;
	
	return @id;
    END */$$
DELIMITER ;

/* Function  structure for function  `fn_nambah_uang` */

/*!50003 DROP FUNCTION IF EXISTS `fn_nambah_uang` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fn_nambah_uang`(
	p_pmn_AP_s0 INT, 
	p_pmn_AP_t0 DATETIME) RETURNS smallint(6)
BEGIN
		SELECT V, dt FROM setting INTO @AP_v, @AP_dt_in_sec;
		SET @AP = p_pmn_AP_s0 + FLOOR(@AP_v * TIMEDIFF( NOW(), p_pmn_AP_t0) / @AP_dt_in_sec);
	   
		RETURN @AP;
	    END */$$
DELIMITER ;

/* Function  structure for function  `fn_nambah_xp` */

/*!50003 DROP FUNCTION IF EXISTS `fn_nambah_xp` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fn_nambah_xp`(
	p_pmn_AP_s0 INT, 
	p_pmn_AP_t0 DATETIME) RETURNS smallint(6)
BEGIN
		SELECT exp_V, exp_dt FROM setting INTO @AP_v, @AP_dt_in_sec;
		SET @AP = p_pmn_AP_s0 + FLOOR(@AP_v * TIMEDIFF( NOW(), p_pmn_AP_t0) / @AP_dt_in_sec);
	   
		RETURN @AP;
	    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_ceknamaawalnaga` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_ceknamaawalnaga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ceknamaawalnaga`(
	p_nama VARCHAR (32)
)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @IDU;
	IF EXISTS (SELECT naga_id FROM naga_player WHERE usr_id = @IDU AND naga_nama IS NULL) then
		SELECT 0, 'Nama belum ditambahkan';
	else
		select 1, 'Nama sudah ditambahkan';
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_daftar` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_daftar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_daftar`(
	p_nama VARCHAR (32),
	p_email varchar (32),
	p_password VARCHAR (32)
)
BEGIN
	IF NOT EXISTS(SELECT 1 FROM usr_account WHERE usr_email = p_email) THEN
		IF NOT EXISTS(SELECT 1 FROM usr_account WHERE usr_nama = p_nama) THEN
			INSERT INTO usr_account (usr_nama, usr_email, usr_password, usr_t0)VALUES(p_nama, p_email, MD5(p_password), now());
			SELECT 0, 'Pendaftaran sukses!';
			SELECT usr_id FROM usr_account WHERE usr_email = p_email into @id;
			call sp_set_awalnaga (@id);
		ELSE
			SELECT -2, 'Username sudah ada!';
		END IF;
	ELSE
		SELECT -1, 'Pendaftaran gagal! Email sudah digunakan';
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_hitung_naga` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_hitung_naga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_hitung_naga`(
	p_nama VARCHAR (32)
)
BEGIN
	SELECT usr_id INTO @IDU FROM usr_account WHERE usr_nama = p_nama ;
	select count(naga_ID)from naga_player where usr_ID = @IDU into @hitung;
	update usr_account set usr_jumlah_naga = @hitung where usr_ID = @IDU;
	select 1, "jumlah diperbaharui";
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login`(
	p_nama varchar (32),
	p_password varchar (32)
)
BEGIN
	IF EXISTS(SELECT 1 FROM usr_account WHERE usr_nama = p_nama) THEN
		IF EXISTS(SELECT 2 FROM usr_account WHERE MD5(p_password) = usr_password AND usr_nama = p_nama) THEN
			SELECT 0,'Login sukes';
		ELSE
			SELECT -2,'Password salah';
		END IF;
	ELSE
		SELECT -1,'Username tidak terdaftar';
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_main` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_main` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_main`( 
	p_email VARCHAR(32),
	p_id VARCHAR(32),
	p_password VARCHAR(32) 
    )
BEGIN
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET XP = XP + 300 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM usr_account WHERE usr_email = p_email) THEN
			UPDATE usr_account SET usr_uang = usr_uang - 800 WHERE usr_email = p_email;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET lapar = lapar - 20 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET senang = senang + 100 WHERE naga_id = p_id;
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_makan` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_makan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_makan`( 
	p_email VARCHAR(32),
	p_id VARCHAR(32),
	p_password VARCHAR(32) 
    )
BEGIN
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET XP = XP + 50 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM usr_account WHERE usr_email = p_email) THEN
			UPDATE usr_account SET usr_uang = usr_uang - 100 WHERE usr_email = p_email;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET lapar = lapar + 40 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET senang = senang + 10 WHERE naga_id = p_id;
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_mandi` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_mandi` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mandi`( 
	p_id VARCHAR(32),
	p_password VARCHAR(32) 
    )
BEGIN
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET XP = XP + 100 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET lapar = lapar - 20 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET senang = senang + 20 WHERE naga_id = p_id;
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_naga_data` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_naga_data` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_naga_data`(
	p_ID VARCHAR(32)
)
BEGIN
	IF EXISTS (SELECT 1 FROM usr_account WHERE `usr_ID`=p_ID) THEN 
		SELECT
		    `naga_id`
		FROM
		    `mydragon`.`naga_player`
		WHERE usr_ID=p_ID;
	ELSE
		SELECT "gagal" AS kode, "Gagal";
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_setnamaawalnaga` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_setnamaawalnaga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_setnamaawalnaga`(
	p_nama VARCHAR (32),
	p_nama_naga varchar (32)
)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @IDU;
	SELECT naga_id FROM naga_player WHERE usr_id = @IDU AND naga_nama IS NULL INTO @ID;
	UPDATE naga_player SET naga_nama = p_nama_naga WHERE naga_ID = @ID;
	
	select 0, 'Nama ditambahkan';
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_set_awalnaga` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_set_awalnaga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_set_awalnaga`(
	p_ID int (8)
)
BEGIN
	insert into naga_player (usr_ID, spesies_id, naga_tgl_lahir, naga_level , XP ,lapar, senang)
	values (p_ID, 5, CURDATE(), 0, 0 ,100 , 100);
	select 1, 'Naga ditambahhkan!';
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_set_naga` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_set_naga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_set_naga`(
	p_ID int (8)
)
BEGIN
	insert into naga_player (usr_ID, spesies_id, naga_tgl_lahir, naga_level , XP ,lapar, senang)
	values (p_ID, 5, CURDATE(), 0, 0 ,100 , 100);
	select 1, 'Naga ditambahhkan!';
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_set_uang` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_set_uang` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_set_uang`(
	p_ID INT(5),
	p_jumlah_uang INT(5)
	)
BEGIN
	UPDATE usr_account SET usr_uang = p_jumlah_uang WHERE usr_ID = p_ID;
	UPDATE usr_account SET usr_t0 = NOW() WHERE usr_ID = P_ID ;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_set_xp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_set_xp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_set_xp`(
	p_ID INT(5),
	P_ID_naga INT (10),
	p_jumlah_xp INT(5)
	)
BEGIn
	select exp_Vmax from setting into @maksimal;
	while (p_jumlah_xp > @maksimal) do
	begin
	UPDATE naga_player SET naga_level = naga_level + 1 WHERE usr_ID = P_ID AND naga_ID = P_ID_naga;
	set p_jumlah_xp = p_jumlah_xp - @maksimal;
	end;
	end while;
	UPDATE naga_player SET XP = p_jumlah_xp WHERE usr_ID = P_ID AND naga_ID = P_ID_naga;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_tambah_uang` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_tambah_uang` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tambah_uang`(
	 P_ID INT(10)
	 )
BEGIN
	SELECT usr_uang FROM usr_account WHERE usr_ID = P_ID into @uang;
	SELECT usr_t0 FROM usr_account WHERE usr_ID = P_ID INTO @t0;
	SELECT fn_nambah_uang (@uang,@t0) INTO @pmn_AP3;
	CALL sp_set_uang (P_ID,@pmn_AP3);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_tambah_xp` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_tambah_xp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tambah_xp`(
	 P_ID INT(10),
	 P_ID_naga int (10)
	 )
BEGIN
	
	SELECT XP FROM naga_player WHERE usr_ID = P_ID and naga_ID = P_ID_naga into @xp;
	SELECT usr_t0 FROM usr_account WHERE usr_ID = P_ID INTO @t0;
	SELECT fn_nambah_xp (@xp,@t0) INTO @pmn_AP3;
	CALL sp_set_xp (P_ID,P_ID_naga, @pmn_AP3);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_tampilkan_naga` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_tampilkan_naga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tampilkan_naga`(
	p_nama VARCHAR (32)
)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @IDU;
	select naga_ID from naga_player where usr_ID = @IDU;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_usr_data` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_usr_data` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usr_data`(
	p_username VARCHAR(32)
)
BEGIN
	IF EXISTS (SELECT 1 FROM usr_account WHERE `usr_nama`=p_username) THEN 
		SELECT
		    `usr_ID`
		    , `usr_nama`
		    , `usr_email`
		    , `usr_uang`
		    , `usr_t0`
		    , `usr_jumlah_naga`

		FROM
		    `mydragon`.`usr_account`
		WHERE usr_nama=p_username;
	ELSE
		SELECT "gagal" AS kode, "Gagal";
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_visit` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_visit` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_visit`( 
	p_email VARCHAR(32),
	p_id VARCHAR(32),
	p_password VARCHAR(32) 
    )
BEGIN
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET XP = XP + 50 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM usr_account WHERE usr_email = p_email) THEN
			UPDATE usr_account SET usr_uang = usr_uang - 50 WHERE usr_email = p_email;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET lapar = lapar + 10 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET senang = senang + 20 WHERE naga_id = p_id;
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_visited` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_visited` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_visited`( 
	p_id VARCHAR(32),
	p_password VARCHAR(32) 
    )
BEGIN
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET XP = XP + 50 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET lapar = lapar + 10 WHERE naga_id = p_id;
	END IF;
	
	IF EXISTS(SELECT 1 FROM naga_player WHERE naga_id = p_id) THEN
			UPDATE naga_player SET senang = senang + 20 WHERE naga_id = p_id;
	END IF;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
