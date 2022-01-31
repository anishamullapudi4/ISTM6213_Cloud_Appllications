-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 12, 2021 at 02:00 PM
-- Server version: 5.7.24
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clearwater`
--
CREATE DATABASE IF NOT EXISTS `clearwater` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `clearwater`;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` smallint(2) NOT NULL,
  `category_desc` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_desc`) VALUES
(1, 'Women\'s Clothing'),
(2, 'Children\'s Clothing'),
(3, 'Men\'s Clothing'),
(4, 'Outdoor Gear');

-- --------------------------------------------------------

--
-- Table structure for table `color`
--

DROP TABLE IF EXISTS `color`;
CREATE TABLE IF NOT EXISTS `color` (
  `color` varchar(20) NOT NULL,
  PRIMARY KEY (`color`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `color`
--

INSERT INTO `color` (`color`) VALUES
('Blue'),
('Bright Pink'),
('Eggplant'),
('Khaki'),
('Light Grey'),
('Navy'),
('Red'),
('Royal'),
('Sky Blue'),
('Spruce'),
('Turquoise');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `cust_id` mediumint(5) NOT NULL,
  `last` varchar(30) DEFAULT NULL,
  `first` varchar(30) DEFAULT NULL,
  `mi` char(1) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `d_phone` varchar(10) DEFAULT NULL,
  `e_phone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cust_id`, `last`, `first`, `mi`, `address`, `city`, `state`, `zip`, `d_phone`, `e_phone`) VALUES
(107, 'Harris', 'Paula', 'E', '1156 Water Street, Apt. #3', 'Osseo', 'WI', '54705', '7155558943', '7155559035'),
(232, 'Edwards', 'Mitch', 'M', '4204 Garner Street', 'Washburn', 'WI', '54891', '7155558243', '7155556975'),
(133, 'Garcia', 'Maria', 'H', '2211 Pine Drive', 'Radisson', 'WI', '54867', '7155558332', '7155558332'),
(154, 'Miller', 'Lee', NULL, '699 Pluto St. NW', 'Silver Lake', 'WI', '53821', '7155554978', '7155559002'),
(179, 'Chang', 'Alissa', 'R', '987 Durham Rd.', 'Sister Bay', 'WI', '54234', '7155557651', '7155550087');

-- --------------------------------------------------------

--
-- Table structure for table `cust_order`
--

DROP TABLE IF EXISTS `cust_order`;
CREATE TABLE IF NOT EXISTS `cust_order` (
  `order_id` int(8) NOT NULL,
  `order_date` date DEFAULT NULL,
  `meth_pmt` varchar(10) DEFAULT NULL,
  `cust_id` mediumint(5) DEFAULT NULL,
  `order_source_id` smallint(3) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `cust_id` (`cust_id`),
  KEY `order_source_id` (`order_source_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cust_order`
--

INSERT INTO `cust_order` (`order_id`, `order_date`, `meth_pmt`, `cust_id`, `order_source_id`) VALUES
(1057, '2003-05-29', 'CC', 107, 2),
(1058, '2003-05-29', 'CC', 232, 6),
(1059, '2003-05-31', 'CHECK', 133, 2),
(1060, '2003-05-31', 'CC', 154, 3),
(1061, '2003-06-01', 'CC', 179, 6),
(1062, '2003-06-01', 'CC', 179, 3);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `inv_id` bigint(10) NOT NULL,
  `item_id` int(8) DEFAULT NULL,
  `item_size` varchar(10) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  `qoh` smallint(4) DEFAULT NULL,
  PRIMARY KEY (`inv_id`),
  KEY `item_id` (`item_id`),
  KEY `color` (`color`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inv_id`, `item_id`, `item_size`, `color`, `price`, `qoh`) VALUES
(11668, 786, NULL, 'Sky Blue', '259.99', 16),
(11669, 786, NULL, 'Light Grey', '259.99', 12);

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `item_id` int(8) NOT NULL,
  `item_desc` varchar(100) NOT NULL,
  `category_id` smallint(2) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `item_desc`, `category_id`) VALUES
(894, 'Women\'s Hiking Shorts', 1),
(897, 'Women\'s Fleece Pullover', 1),
(995, 'Children\'s Beachcomber Sandals', 2),
(559, 'Men\'s Expedition Parka', 3),
(786, '3-Season Tent', 4);

-- --------------------------------------------------------

--
-- Table structure for table `order_line`
--

DROP TABLE IF EXISTS `order_line`;
CREATE TABLE IF NOT EXISTS `order_line` (
  `order_id` int(8) NOT NULL,
  `inv_id` bigint(10) NOT NULL,
  `order_quantity` smallint(4) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`inv_id`),
  KEY `order_id` (`order_id`),
  KEY `inv_id` (`inv_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `order_source`
--

DROP TABLE IF EXISTS `order_source`;
CREATE TABLE IF NOT EXISTS `order_source` (
  `order_source_id` smallint(3) NOT NULL,
  `source_desc` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`order_source_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_source`
--

INSERT INTO `order_source` (`order_source_id`, `source_desc`) VALUES
(1, 'Winter 2002'),
(2, 'Spring 2003'),
(3, 'Summer 2003'),
(4, 'Outdoor 2003'),
(5, 'Children\'s 2003'),
(6, 'Web Site');

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
CREATE TABLE IF NOT EXISTS `shipment` (
  `shipment_id` bigint(10) NOT NULL,
  `date_expected` date DEFAULT NULL,
  PRIMARY KEY (`shipment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shipment_line`
--

DROP TABLE IF EXISTS `shipment_line`;
CREATE TABLE IF NOT EXISTS `shipment_line` (
  `shipment_id` bigint(10) NOT NULL,
  `inv_id` bigint(10) NOT NULL,
  `ship_quantity` smallint(4) DEFAULT NULL,
  `date_received` date DEFAULT NULL,
  PRIMARY KEY (`shipment_id`,`inv_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `inv_id` (`inv_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
--
-- Database: `company`
--
CREATE DATABASE IF NOT EXISTS `company` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `company`;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `FNAME` varchar(255) NOT NULL,
  `LNAME` varchar(255) NOT NULL,
  `SSN` int(11) NOT NULL,
  `BDATE` date NOT NULL,
  `ADDRESS` text NOT NULL,
  `SEX` varchar(255) NOT NULL,
  `SALARY` double(11,2) NOT NULL,
  `DNO` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`FNAME`, `LNAME`, `SSN`, `BDATE`, `ADDRESS`, `SEX`, `SALARY`, `DNO`) VALUES
('Ramesh', 'Narayan ', 666884444, '1952-09-15', '975 Fire Oak, Humble, TX', 'M', 38000.00, 5),
('Joyce', 'English ', 453453453, '1962-07-31', '5631 Rice, Houston, TX', 'F', 25000.00, 5),
('John', 'Smith', 123456789, '1955-01-09', '731 Fondren, Houston, TX', 'M', 30000.00, 5),
('Franklin', 'Wong', 333445555, '1945-12-08', '638 Voss, Houston, TX ', 'M', 40000.00, 5),
('James', 'Borg', 888665555, '1927-10-10', '450 Stone, Houston, TX ', 'M', 55000.00, 1),
('Jennifer', 'Wallace', 987654321, '1931-07-20', 'Berry, Bellaire, TX 291', 'F', 43000.00, 4),
('Ahmad', 'Jabbar', 987987987, '1959-03-29', '980 Dallas, Houston, TX ', 'M', 25000.00, 4),
('Alicia', 'Zelaya', 999887777, '1958-07-19', '3321 Castle, SPring, TX', 'F', 25000.00, 4);
--
-- Database: `finalexam`
--
CREATE DATABASE IF NOT EXISTS `finalexam` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `finalexam`;

-- --------------------------------------------------------

--
-- Table structure for table `exchangerate`
--

DROP TABLE IF EXISTS `exchangerate`;
CREATE TABLE IF NOT EXISTS `exchangerate` (
  `EX_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE` date NOT NULL,
  `TIME_UPDATED` datetime NOT NULL,
  `USD` float NOT NULL,
  `AUD` float NOT NULL,
  `CAD` float NOT NULL,
  `CHF` float NOT NULL,
  `CNY` float NOT NULL,
  `EUR` float NOT NULL,
  `GBP` float NOT NULL,
  `HKD` float NOT NULL,
  PRIMARY KEY (`EX_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exchangerate`
--

INSERT INTO `exchangerate` (`EX_ID`, `DATE`, `TIME_UPDATED`, `USD`, `AUD`, `CAD`, `CHF`, `CNY`, `EUR`, `GBP`, `HKD`) VALUES
(4, '2021-12-12', '2021-12-12 00:00:01', 1, 1.3963, 1.271, 0.9223, 6.3815, 0.8855, 0.7565, 7.7988);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
