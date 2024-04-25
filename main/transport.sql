-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 01, 2023 at 05:15 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `transport`
--
CREATE DATABASE IF NOT EXISTS `transport` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `transport`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `abcd`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `abcd` (IN `push` INT)  NO SQL SELECT* from user_info$$

DROP PROCEDURE IF EXISTS `kashish`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `kashish` ()   BEGIN
  DECLARE done BOOLEAN DEFAULT FALSE;
  DECLARE user_name VARCHAR(30);
  DECLARE user_id INT;
  DECLARE user_email VARCHAR(50);
  DECLARE user_age INT;
  DECLARE cur CURSOR FOR SELECT name, uid, email, age FROM user_info WHERE age > 50;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN cur;
  
  read_loop: LOOP
    FETCH cur INTO user_name, user_id, user_email, user_age;
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    -- Do something with the fetched data
    
  END LOOP;
  
  CLOSE cur;
  
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `a_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `psw` varchar(30) NOT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `admin`:
--

--
-- Dumping data for table `admin`
--

INSERT DELAYED IGNORE INTO `admin` (`a_id`, `name`, `psw`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `booking_det`
--

DROP TABLE IF EXISTS `booking_det`;
CREATE TABLE IF NOT EXISTS `booking_det` (
  `bus_id` int(11) NOT NULL,
  `vacant` int(11) NOT NULL,
  `jdate` varchar(30) NOT NULL,
  `bfrom` varchar(30) NOT NULL,
  `bto` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `booking_det`:
--

--
-- Dumping data for table `booking_det`
--

INSERT DELAYED IGNORE INTO `booking_det` (`bus_id`, `vacant`, `jdate`, `bfrom`, `bto`) VALUES
(3, 75, '2023-04-11', 'Bhind ', 'Delhi'),
(2, 74, '2023-04-16', 'Bhind ', 'Delhi'),
(5, 70, '2023-04-21', 'Bangalore', 'Ladakh'),
(2, 76, '2023-09-21', 'Bhind ', 'Delhi'),
(2, 75, '2023-04-21', 'Patiala', 'Delhi');

--
-- Triggers `booking_det`
--
DROP TRIGGER IF EXISTS `booking_de`;
DELIMITER $$
CREATE TRIGGER `booking_de` BEFORE DELETE ON `booking_det` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('booking', 'bus_id')
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `booking_in`;
DELIMITER $$
CREATE TRIGGER `booking_in` BEFORE INSERT ON `booking_det` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('booking', 'bus_id')
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `booking_up`;
DELIMITER $$
CREATE TRIGGER `booking_up` BEFORE UPDATE ON `booking_det` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('booking', 'bus_id')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bus_details`
--

DROP TABLE IF EXISTS `bus_details`;
CREATE TABLE IF NOT EXISTS `bus_details` (
  `bus_id` int(11) NOT NULL AUTO_INCREMENT,
  `bname` varchar(30) NOT NULL,
  `bno` varchar(20) NOT NULL,
  `bfrom` varchar(30) NOT NULL,
  `bto` varchar(30) NOT NULL,
  `time` varchar(10) NOT NULL,
  `type` varchar(10) NOT NULL,
  `no_seat` int(11) NOT NULL,
  `fare` int(11) NOT NULL,
  PRIMARY KEY (`bus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `bus_details`:
--

--
-- Dumping data for table `bus_details`
--

INSERT DELAYED IGNORE INTO `bus_details` (`bus_id`, `bname`, `bno`, `bfrom`, `bto`, `time`, `type`, `no_seat`, `fare`) VALUES
(2, 'Bijli R', '246789', 'Patiala', 'Delhi', '6pm', 'Ac', 80, 1000),
(3, 'PRTC', '29567', 'Patiala', 'Bathinda', '7 pm', 'Non Ac', 80, 400),
(5, 'express', '356983', 'Patiala', 'Hydrabad', '8AM', 'Ac', 80, 5000),
(6, 'Orbit', '19946', 'Patiala', 'Chandigarh', '9:40 am', 'Ac', 47, 100);

--
-- Triggers `bus_details`
--
DROP TRIGGER IF EXISTS `bus_de`;
DELIMITER $$
CREATE TRIGGER `bus_de` AFTER DELETE ON `bus_details` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('bus', 'bus_id')
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `bus_in`;
DELIMITER $$
CREATE TRIGGER `bus_in` AFTER INSERT ON `bus_details` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('bus', 'bus_id')
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `bus_up`;
DELIMITER $$
CREATE TRIGGER `bus_up` AFTER UPDATE ON `bus_details` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('bus', 'bus_id')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `name` varchar(30) NOT NULL,
  `uname` varchar(30) NOT NULL,
  `rating` int(2) NOT NULL,
  `phno` int(10) NOT NULL,
  `comm` text NOT NULL,
  PRIMARY KEY (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `feedback`:
--

--
-- Dumping data for table `feedback`
--

INSERT DELAYED IGNORE INTO `feedback` (`name`, `uname`, `rating`, `phno`, `comm`) VALUES
('ka', 'ka', 9, 933586, 'Good'),
('Kashish Aggarwal', 'kas', 8, 590830, 'Good');

--
-- Triggers `feedback`
--
DROP TRIGGER IF EXISTS `feedback_in`;
DELIMITER $$
CREATE TRIGGER `feedback_in` AFTER INSERT ON `feedback` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('feedback', 'name')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `table_name` varchar(30) NOT NULL,
  `columns_changed` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `log`:
--

--
-- Dumping data for table `log`
--

INSERT DELAYED IGNORE INTO `log` (`table_name`, `columns_changed`) VALUES
('ticket', 'uid'),
('feedback', 'name');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
CREATE TABLE IF NOT EXISTS `ticket` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `bus_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `seat_no` varchar(30) NOT NULL,
  `no_seat` int(11) NOT NULL,
  `ticket_status` varchar(30) NOT NULL,
  `jdate` varchar(30) NOT NULL,
  `booking_date` date NOT NULL,
  `pname` varchar(30) NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `ticket`:
--

--
-- Dumping data for table `ticket`
--

INSERT DELAYED IGNORE INTO `ticket` (`tid`, `bus_id`, `uid`, `seat_no`, `no_seat`, `ticket_status`, `jdate`, `booking_date`, `pname`) VALUES
(5, 2, 4, ' 3 4 5 6', 4, 'Conform', '2023-04-16', '2023-04-25', 'Kashish'),
(6, 2, 4, ' 1 2 3 4', 4, 'Conform', '2023-09-21', '2023-04-28', 'ak'),
(7, 2, 5, ' 1 2 3 4 5', 5, 'Conform', '2023-04-21', '2023-04-28', 'Kashish Aggarwal ');

--
-- Triggers `ticket`
--
DROP TRIGGER IF EXISTS `ticket_in`;
DELIMITER $$
CREATE TRIGGER `ticket_in` AFTER INSERT ON `ticket` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('ticket', 'tid')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
CREATE TABLE IF NOT EXISTS `user_info` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `uname` varchar(30) NOT NULL,
  `age` varchar(30) NOT NULL,
  `adhar_no` varchar(30) NOT NULL,
  `psw` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- RELATIONSHIPS FOR TABLE `user_info`:
--

--
-- Dumping data for table `user_info`
--

INSERT DELAYED IGNORE INTO `user_info` (`uid`, `name`, `uname`, `age`, `adhar_no`, `psw`, `email`) VALUES
(4, 'Kashish Aggarwal ', 'ka', '21', '2567', 'ka', 'agg@m.com'),
(5, 'kASD', 'KAS', '23', '1435787', 'KAS', 'A@M.COM'),
(6, 'Kashish Aggarwal ', 'k', '23', '345678', 'k', 'k@gmail.com');

--
-- Triggers `user_info`
--
DROP TRIGGER IF EXISTS `user_in`;
DELIMITER $$
CREATE TRIGGER `user_in` AFTER INSERT ON `user_info` FOR EACH ROW INSERT INTO log(table_name, columns_changed)
    VALUES ('user', 'uid')
$$
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
