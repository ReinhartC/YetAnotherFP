-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Inang: 127.0.0.1
-- Waktu pembuatan: 21 Mei 2017 pada 17.10
-- Versi Server: 5.6.14
-- Versi PHP: 5.5.6

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Basis data: `mydragon`
--

DELIMITER $$
--
-- Prosedur
--
DROP PROCEDURE IF EXISTS `sp_ceknamaawalnaga`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ceknamaawalnaga`(
	p_nama VARCHAR (32)
)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @IDU;
	IF EXISTS (SELECT naga_id FROM naga_player WHERE usr_id = @IDU AND naga_nama IS NULL) then
		SELECT 0, 'Nama belum ditambahkan';
	else
		select 1, 'Nama sudah ditambahkan';
	end if;
    END$$

DROP PROCEDURE IF EXISTS `sp_daftar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_daftar`(
	p_nama VARCHAR (32),
	p_email varchar (32),
	p_password VARCHAR (32)
)
BEGIN
	IF NOT EXISTS(SELECT 1 FROM usr_account WHERE usr_email = p_email) THEN
		IF NOT EXISTS(SELECT 1 FROM usr_account WHERE usr_nama = p_nama) THEN
			INSERT INTO usr_account (usr_nama, usr_email, usr_password)VALUES(p_nama, p_email, MD5(p_password));
			SELECT 0, 'pendaftaran sukses!';
			SELECT usr_id FROM usr_account WHERE usr_email = p_email into @id;
			call sp_set_awalnaga (@id);
		ELSE
			SELECT -2, 'username sudah ada';
		END IF;
	ELSE
		SELECT -1, 'pendaftaran gagal! email sudah digunakan';
	END IF;
    END$$

DROP PROCEDURE IF EXISTS `sp_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login`(
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
    END$$

DROP PROCEDURE IF EXISTS `sp_main`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_main`( 
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
END$$

DROP PROCEDURE IF EXISTS `sp_makan`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_makan`( 
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
END$$

DROP PROCEDURE IF EXISTS `sp_mandi`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mandi`( 
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
END$$

DROP PROCEDURE IF EXISTS `sp_setnamaawalnaga`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_setnamaawalnaga`(
	p_nama VARCHAR (32),
	p_nama_naga varchar (32)
)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @IDU;
	SELECT naga_id FROM naga_player WHERE usr_id = @IDU AND naga_nama IS NULL INTO @ID;
	UPDATE naga_player SET naga_nama = p_nama_naga WHERE naga_ID = @ID;
	
    END$$

DROP PROCEDURE IF EXISTS `sp_set_awalnaga`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_set_awalnaga`(
	p_ID int (8)
)
BEGIN
	insert into naga_player (usr_ID, spesies_id, naga_tgl_lahir, naga_level , XP ,lapar, senang)
	values (p_ID, 5, CURDATE(), 0, 0 ,100 , 100);
	select 1, 'Naga ditambahhkan!';
    END$$

DROP PROCEDURE IF EXISTS `sp_uang`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_uang`( 
	p_email VARCHAR(32)
    )
BEGIN
	SELECT usr_uang FROM usr_account WHERE usr_email = p_email
		INTO @uang;
	
	set @uangnew = @uang + 100*3600;
	
	IF EXISTS(SELECT 1 FROM usr_account WHERE usr_email = p_email) THEN
			UPDATE usr_account SET usr_uang = @uangnew WHERE usr_email = p_email;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_visit`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_visit`( 
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
END$$

DROP PROCEDURE IF EXISTS `sp_visited`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_visited`( 
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
END$$

--
-- Fungsi
--
DROP FUNCTION IF EXISTS `fn_id`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_id`(p_nama varchar (32)) RETURNS tinyint(4)
BEGIN
	SELECT usr_id FROM usr_account WHERE usr_nama = p_nama INTO @id;
	
	return @id;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `aktivitas`
--

DROP TABLE IF EXISTS `aktivitas`;
CREATE TABLE IF NOT EXISTS `aktivitas` (
  `aktivitas_ID` tinyint(4) NOT NULL,
  `aktivitas_nama` varchar(64) DEFAULT NULL,
  `efek_XP` smallint(6) DEFAULT NULL,
  `efek_lapar` tinyint(4) DEFAULT NULL,
  `efek_senang` tinyint(4) DEFAULT NULL,
  `efek_uang` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`aktivitas_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `item_ID` tinyint(4) NOT NULL,
  `item_nama` varchar(32) DEFAULT NULL,
  `foto` varchar(64) DEFAULT NULL,
  `tambah_XP` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `naga`
--

DROP TABLE IF EXISTS `naga`;
CREATE TABLE IF NOT EXISTS `naga` (
  `spesies_ID` tinyint(4) NOT NULL,
  `spesies_nama` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`spesies_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `naga`
--

INSERT INTO `naga` (`spesies_ID`, `spesies_nama`) VALUES
(1, 'Western Dragon'),
(2, 'Eastern Dragon'),
(3, 'Furdragon'),
(4, 'Wyvern'),
(5, 'Lizardus'),
(6, 'Dino'),
(7, 'Pterodragon'),
(8, 'Felidragon'),
(9, 'Dark Dragon'),
(10, 'Plesiodragon'),
(11, 'Canidragon');

-- --------------------------------------------------------

--
-- Struktur dari tabel `naga_item`
--

DROP TABLE IF EXISTS `naga_item`;
CREATE TABLE IF NOT EXISTS `naga_item` (
  `item_naga_ID` smallint(6) NOT NULL,
  `naga_ID` smallint(6) DEFAULT NULL,
  `item_ID` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`item_naga_ID`),
  KEY `fk_jenis_item` (`item_ID`),
  KEY `fk_pemilik_item` (`naga_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `naga_player`
--

DROP TABLE IF EXISTS `naga_player`;
CREATE TABLE IF NOT EXISTS `naga_player` (
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
  KEY `fk_pemilik_naga` (`usr_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data untuk tabel `naga_player`
--

INSERT INTO `naga_player` (`naga_ID`, `usr_ID`, `spesies_ID`, `naga_nama`, `naga_tgl_lahir`, `naga_level`, `XP`, `lapar`, `senang`) VALUES
(2, 6, 5, 'coba=coba', '2017-05-21', 0, 0, 100, 100),
(3, 7, 5, NULL, '2017-05-21', 0, 0, 100, 100),
(4, 8, 5, NULL, '2017-05-21', 0, 0, 100, 100);

-- --------------------------------------------------------

--
-- Struktur dari tabel `setting_energi`
--

DROP TABLE IF EXISTS `setting_energi`;
CREATE TABLE IF NOT EXISTS `setting_energi` (
  `V` smallint(6) DEFAULT NULL,
  `dt` smallint(6) DEFAULT NULL,
  `Vmax` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `stage`
--

DROP TABLE IF EXISTS `stage`;
CREATE TABLE IF NOT EXISTS `stage` (
  `stage_ID` tinyint(4) NOT NULL,
  `stage` tinyint(4) DEFAULT NULL,
  `image` varchar(64) DEFAULT NULL,
  `icon` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`stage_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `stage_naga`
--

DROP TABLE IF EXISTS `stage_naga`;
CREATE TABLE IF NOT EXISTS `stage_naga` (
  `spesies_ID` tinyint(4) DEFAULT NULL,
  `stage_ID` tinyint(4) DEFAULT NULL,
  KEY `fk_spesies_naga` (`spesies_ID`),
  KEY `fk_stage_naga` (`stage_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `usr_account`
--

DROP TABLE IF EXISTS `usr_account`;
CREATE TABLE IF NOT EXISTS `usr_account` (
  `usr_ID` int(8) NOT NULL AUTO_INCREMENT,
  `usr_nama` varchar(32) NOT NULL,
  `usr_email` varchar(32) NOT NULL,
  `usr_password` char(32) NOT NULL,
  `usr_uang` int(11) DEFAULT NULL,
  PRIMARY KEY (`usr_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data untuk tabel `usr_account`
--

INSERT INTO `usr_account` (`usr_ID`, `usr_nama`, `usr_email`, `usr_password`, `usr_uang`) VALUES
(6, 'coba', 'coba@gmail.com', 'c3ec0f7b054e729c5a716c8125839829', NULL),
(7, 'tes', 'tes@gmail.com', '28b662d883b6d76fd96e4ddc5e9ba780', NULL),
(8, 'abcde', 'abcde@gmail.com', '7bc6c31880aeda581aa34e218af25753', NULL);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `naga_item`
--
ALTER TABLE `naga_item`
  ADD CONSTRAINT `fk_pemilik_item` FOREIGN KEY (`naga_ID`) REFERENCES `naga_player` (`naga_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_jenis_item` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `naga_player`
--
ALTER TABLE `naga_player`
  ADD CONSTRAINT `fk_jenis_naga` FOREIGN KEY (`spesies_ID`) REFERENCES `naga` (`spesies_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pemilik_naga` FOREIGN KEY (`usr_ID`) REFERENCES `usr_account` (`usr_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `stage_naga`
--
ALTER TABLE `stage_naga`
  ADD CONSTRAINT `fk_spesies_naga` FOREIGN KEY (`spesies_ID`) REFERENCES `naga` (`spesies_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stage_naga` FOREIGN KEY (`stage_ID`) REFERENCES `stage` (`stage_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
