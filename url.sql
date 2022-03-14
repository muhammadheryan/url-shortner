-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.20-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for url_shortener
CREATE DATABASE IF NOT EXISTS `url_shortener` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `url_shortener`;

-- Dumping structure for table url_shortener.url
CREATE TABLE IF NOT EXISTS `url` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url_origin` varchar(500) NOT NULL,
  `url_shorten` varchar(50) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `url_shorten_idx` (`url_shorten`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table url_shortener.url: ~6 rows (approximately)
/*!40000 ALTER TABLE `url` DISABLE KEYS */;
INSERT INTO `url` (`id`, `url_origin`, `url_shorten`, `create_time`) VALUES
	(1, 'google.com', 'http://127.0.0.1:5000/xyz', '2022-03-13 19:24:13'),
	(8, 'http://www.stackoverflow.com', 'http://127.0.0.1:5000/redirect?url=viJiXd3v', '2022-03-13 22:02:08'),
	(11, 'http://www.google.com', 'http://127.0.0.1:5000/redirect?url=AJRfOeXL', '2022-03-13 22:36:23'),
	(12, 'http://www.facebook.com', 'http://127.0.0.1:5000/redirect?url=wtwu8WID', '2022-03-13 22:38:30'),
	(13, 'http://www.facebookz.com', 'http://127.0.0.1:5000/redirect?url=zkeUMFpo', '2022-03-13 22:38:49'),
	(14, 'http://www.sdasdasdasdasd.com', 'http://127.0.0.1:5000/redirect?url=YLDl79MH', '2022-03-13 22:38:55');
/*!40000 ALTER TABLE `url` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
