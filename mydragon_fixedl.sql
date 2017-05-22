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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `naga_player` */

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
  PRIMARY KEY (`usr_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `usr_account` */

/* Function  structure for function  `fn_id` */

/*!50003 DROP FUNCTION IF EXISTS `fn_id` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fn_id`(p_nama varchar (32)) RETURNS tinyint(4)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @id;
	
	return @id;
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
			INSERT INTO usr_account (usr_nama, usr_email, usr_password)VALUES(p_nama, p_email, MD5(p_password));
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

/* Procedure structure for procedure `sp_setnamanaga` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_setnamanaga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_setnamanaga`(
	p_nama VARCHAR (32),
	p_nama_naga varchar (32)
)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @IDU;
	SELECT naga_id FROM naga_player WHERE usr_id = @IDU AND naga_nama IS NULL INTO @ID;
	UPDATE naga_player SET naga_nama = p_nama_naga WHERE naga_ID = @ID;
	
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

/* Procedure structure for procedure `sp_uang` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_uang` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_uang`( 
	p_email VARCHAR(32)
    )
BEGIN
	SELECT usr_uang FROM usr_account WHERE usr_email = p_email
		INTO @uang;
	
	set @uangnew = @uang + 100*3600;
	
	IF EXISTS(SELECT 1 FROM usr_account WHERE usr_email = p_email) THEN
			UPDATE usr_account SET usr_uang = @uangnew WHERE usr_email = p_email;
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
