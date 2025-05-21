-- MySQL dump 10.13  Distrib 9.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: webshoes
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (2,'Phạm Đăng Khoa','khoapham123@gmail.com','abc123','0982238465'),(5,'Trịnh Trung Hào','haotrung123test@gmail.com','123456789','0987832335'),(10,'Trịnh Trung Hào','hao123@gmail.com','123abc','0973627342');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Adidas','Adidas_Logo.svg.png'),(2,'Nike','nike_logo.jpg'),(3,'Puma','puma_logo.png'),(4,'Gucci','gucci_logo.jpg'),(5,'Jordan','Jordan_logo.png'),(6,'Ananas','ananas.png'),(7,'Biti\'s','bitis.png'),(8,'Vans','vans.png'),(9,'Balenciaga','balenciaga.png'),(17,'MLB','mlblogo.jpg');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderid` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `paymentType` varchar(100) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (5,'ORD-20241117095201','Đã vận chuyển','Tiền mặt',1,'2024-11-17 14:52:02'),(6,'ORD-20241118110741','Đã vận chuyển','Tiền mặt',3,'2024-11-18 16:07:41'),(7,'ORD-20241119082530','Đã giao hàng','Tiền mặt',3,'2024-11-19 01:25:30'),(8,'ORD-20241119043351','Đã vận chuyển','Tiền mặt',3,'2024-11-19 09:33:52'),(9,'ORD-20241124103635','Đã đặt hàng','Tiền mặt',3,'2024-11-24 03:36:35'),(10,'ORD-20241124112941','Đã đặt hàng','Tiền mặt',3,'2024-11-24 04:29:41'),(11,'ORD-20241124113035','Đã đặt hàng','Tiền mặt',3,'2024-11-24 04:30:36'),(12,'ORD-20241124114839','Đã đặt hàng','Tiền mặt',3,'2024-11-24 04:48:39'),(13,'ORD-20241124114920','Đã giao hàng','Tiền mặt',3,'2024-11-24 04:49:21'),(14,'ORD-20241124115137','Đã đặt hàng','Tiền mặt',3,'2024-11-24 04:51:38'),(15,'ORD-20241125100915','Hủy bỏ đơn hàng','Tiền mặt',3,'2024-11-25 03:09:16'),(16,'ORD-20241125043239','Hủy bỏ đơn hàng','Tiền mặt',4,'2024-11-25 09:32:39'),(17,'ORD-20241125043406','Đã giao hàng','Tiền mặt',3,'2024-11-25 09:34:07'),(18,'ORD-20241125083521','Đã giao hàng','Tiền mặt',1,'2024-11-25 13:35:22'),(19,'ORD-20241125085358','Hủy bỏ đơn hàng','Tiền mặt',3,'2024-11-25 13:53:58'),(20,'ORD-20241204032337','Hủy bỏ đơn hàng','Tiền mặt',3,'2024-12-04 08:23:38'),(24,'ORD-20241206113613','Đã giao hàng','Tiền mặt',11,'2024-12-06 04:36:13'),(26,'ORD-20241206035520','Đã giao hàng','Tiền mặt',13,'2024-12-06 08:55:20'),(27,'ORD-20241206072702','Đã giao hàng','Tiền mặt',14,'2024-12-06 12:27:03'),(28,'ORD-20241206074435','Đã giao hàng','Tiền mặt',14,'2024-12-06 12:44:35'),(29,'ORD-20241206080409','Đã đặt hàng','Tiền mặt',14,'2024-12-06 13:04:10'),(30,'ORD-20241206080704','Đã đặt hàng','Tiền mặt',14,'2024-12-06 13:07:05'),(31,'ORD-20241206080847','Đã đặt hàng','Tiền mặt',14,'2024-12-06 13:08:47'),(32,'ORD-20241206081138','Đã đặt hàng','Tiền mặt',14,'2024-12-06 13:11:38'),(33,'ORD-20241206081657','Đã đặt hàng','Tiền mặt',14,'2024-12-06 13:16:58'),(34,'ORD-20241207040913','Đã đặt hàng','Tiền mặt',3,'2024-12-07 09:09:14'),(35,'ORD-20241207042645','Hủy bỏ đơn hàng','Tiền mặt',3,'2024-12-07 09:26:46'),(36,'ORD-20241207075426','Đã giao hàng','Tiền mặt',16,'2024-12-07 12:54:26');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_product`
--

DROP TABLE IF EXISTS `ordered_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_product` (
  `oid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `orderid` int DEFAULT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_product`
--

LOCK TABLES `ordered_product` WRITE;
/*!40000 ALTER TABLE `ordered_product` DISABLE KEYS */;
INSERT INTO `ordered_product` VALUES (1,'ULTRABOOST LIGHT CORE BLACK LUCID LIME [ MEN ]',1,'935000.0','ultraboost_light_core_black_lucid-lime.jpg',1),(2,'Giày Thể Thao Nike Air Max Đế Hơi Nam',1,'296000.0','Nike_Air_Max.jpg',2),(3,'Giày Gucci Rhyton logo NY',1,'289000.0','Gucci_Rhyton_NY.jpg',3),(4,'Giày Thể Thao Adidas Alphabounce 2020 Nam',1,'308000.0','Alphabounce_Adidas_2020.jpg',4),(5,'Giày Thể Thao Nike Air Max Đế Hơi Nam',1,'296000.0','Nike_Air_Max.jpg',5),(6,'Giày Thể Thao Adidas Alphabounce 2020 Nam',1,'308000.0','Alphabounce_Adidas_2020.jpg',6),(7,'Giày Gucci Rhyton logo NY',10,'289000.0','Gucci_Rhyton_NY.jpg',7),(8,'ULTRABOOST LIGHT CORE BLACK LUCID LIME [ MEN ]',1,'935000.0','ultraboost_light_core_black_lucid-lime.jpg',8),(9,'ULTRABOOST LIGHT CORE BLACK LUCID LIME [ MEN ]',1,'935000.0','ultraboost_light_core_black_lucid-lime.jpg',9),(10,'Giày Thể Thao Nike Air Max Đế Hơi Nam',1,'296000.0','Nike_Air_Max.jpg',10),(11,'Giày Thể Thao Nike Air Max Đế Hơi Nam',1,'296000.0','Nike_Air_Max.jpg',11),(12,'Giày Thể Thao Nike Air Max Đế Hơi Nam',1,'296000.0','Nike_Air_Max.jpg',12),(13,'Giày Thể Thao Nike Air Max Đế Hơi Nam',1,'296000.0','Nike_Air_Max.jpg',13),(14,'Giày Gucci Rhyton logo NY',1,'289000.0','Gucci_Rhyton_NY.jpg',14),(15,'Giày Balenciaga Triple S Clear Sole Black BTS08',1,'1000000.0','balenciaga_shoes1.jpg',15),(16,'Giày Balenciaga Triple S Clear Sole Black BTS08',2,'1000000.0','balenciaga_shoes1.jpg',16),(17,'Giày Vans Old Skool Black White ',1,'229500.0','vans_shoes1.jpeg',17),(18,'Giày Thể Thao Nike Air Max Đế Hơi Nam',1,'296000.0','Nike_Air_Max.jpg',18),(19,'Giày Thể Thao Adidas Alphabounce 2020 Nam',4,'308000.0','Alphabounce_Adidas_2020.jpg',19),(20,'Giày thể thao Ananas TRACK 6 UTILITY GUM SOLE - LOW TOP - NAVY PEONY/GUM A6T008',3,'888250.0','ananastrack6utility.jpg',20),(21,'Giày Thể Thao Ni̲ke Zoom Pegasus 39',2,'1100000.0','nikezoompegasus.jpg',21),(22,'Giày thể thao Nike zoom N206',2,'228000.0','nikezoomn206.jpg',22),(23,'Giày Thể Thao PUMA RS-X COLOUR THEORY \' LIGHT GREY CELANDINE - SECONDHAND',1,'433380.0','pumars-x.jpg',23),(24,'Giày Thể Thao Puma RS-X 3D Low-Cut Sneakers 390025 Màu Đen Phối Màu',1,'1300000.0','pumars-x3d.jpg',24),(25,'Giày Thể Thao Nike Zoom 2021 Nam',1,'281600.0','nikezoom2021.jpg',25),(26,'Giày Thể Thao PUMA RS-X COLOUR THEORY \' LIGHT GREY CELANDINE - SECONDHAND',1,'433380.0','pumars-x.jpg',26),(27,'Giày Thể Thao Nam Biti\'s Hunter Core HSM003200DEN ',1,'748200.0','bitisHSM003200.jpg',27),(28,'GIÀY THỂ THAO NAM ',2,'3430000.0','adidaszx2k.jpg',28),(29,'Giày Thể Thao Ni̲ke Zoom Pegasus 39',2,'1129000.0','nikezoompegasus.jpg',29),(30,'Giày Thể Thao PUMA RS-X COLOUR THEORY \' LIGHT GREY CELANDINE - SECONDHAND',2,'433380.0','pumars-x.jpg',30),(31,'Giày Thể Thao Puma RS-X 3D Low-Cut Sneakers 390025 Màu Đen Phối Màu',2,'1329000.0','pumars-x3d.jpg',31),(32,'Giày Thể Thao Puma RS-X 3D Low-Cut Sneakers 390025 Màu Đen Phối Màu',1,'1329000.0','pumars-x3d.jpg',32),(33,'Giày Thể Thao Puma RS-X 3D Low-Cut Sneakers 390025 Màu Đen Phối Màu',2,'1314500.0','pumars-x3d.jpg',33),(34,'\"Adidas ZX 2K Boost \'White Multi\' Marathon Running Shoes/Sneakers\" FX8835',2,'3444500.0','adidaszx2k.jpg',34),(35,'Giày Thể Thao Adidas 8152 Nam',1,'317000.0','adidas8512.jpg',35),(36,'Giày Thể Thao Nike Air Max Đế Hơi Nam',1,'325000.0','Nike_Air_Max.jpg',36);
/*!40000 ALTER TABLE `ordered_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `price` varchar(20) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `cid` int DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'ULTRABOOST LIGHT CORE BLACK LUCID LIME [ MEN ]','Giày có kích cỡ 40. Phù hợp để đi chơi, leo núi, chơi thể thao. Màu đen kết hợp với xanh dương và xanh lá phù hợp cho nam giới','1100000.0',88,15,'ultraboost_light_core_black_lucid-lime.jpg',1),(2,'Giày Thể Thao Adidas Alphabounce 2020 Nam','Phù hợp cho nam nữ. Size: 39. Có thể đi chơi, làm việc','350000.0',74,12,'Alphabounce_Adidas_2020.jpg',1),(3,'Giày Gucci Rhyton logo NY','Phù hợp cho nam nữ. Size: 38. Có thể đi chơi, đi làm','340000.0',0,15,'Gucci_Rhyton_NY.jpg',4),(4,'Giày Thể Thao Nike Air Max Đế Hơi Nam','Phù hợp cho nam. Size: 40. Thích hợp để chơi thể thao, đi chơi','370000.0',92,20,'Nike_Air_Max.jpg',2),(5,'Giày Nike Air Jordan 1 Low Nữ','Phù hợp cho nữ. Size: 36. Thích hợp để đi chơi, đi làm','340000.0',100,25,'Nike_Air_Jordan.jpg',5),(6,'PUMA MB 02 FLARE','Phù hợp cho nam. Size: 40. Thích hợp để chơi bóng rổ','1100000.0',100,13,'giay_bong_ro.jpg',3),(7,'Basas Simple Life NE - Low Top - Black','Giữ vững nét tối giản đặc trưng thuộc dòng Basas, Basas Simple Life - NE (New Episode) sở hữu những đặc điểm nâng cấp ở chất liệu cùng họa tiết foxing mới, sự kết hợp tinh giản không hề đơn điệu, bình thường nhưng không tầm thường cho những ai thực sự yêu thích sự thoải mái đơn giản cho ngày dài hoạt động.','490000.0',80,20,'ananas_shoes1.jpg',6),(8,'Giày thể thao nam Biti’s Hunter Feast','Kiểu dáng giày đơn giản, không có nhiều điểm nhấn nhá. Phần lưới trên thân giày tạo độ phồng, nhẹ với hai gam màu trắng, đen kết hợp hài hòa, tinh tế.','650000.0',100,35,'bitis_shoes1.jpg',7),(9,'Giày Vans Old Skool Black White ','Thiết kế sang trọng, đẹp, phù hợp cho cả nam lẫn nữ','255000.0',149,10,'vans_shoes1.jpeg',8),(10,'Giày Balenciaga Triple S Clear Sole Black BTS08','Cam kết hàng chuẩn siêu cấp like auth 1:1 nói không với hàng kém chất lượng như trên thị trường. Kiểu dáng, chi tiết, chất liệu da và độ hoàn thiện như hình 100%.','4000000.0',97,75,'balenciaga_shoes1.jpg',9),(11,'Giày Thể Thao Adidas 8152 Nam','Chất liệu sản phẩm cao cấp, form chuẩn, phần đế thiết kế chống trơn trượt, đẹp từng chi tiết, hình ảnh chụp thật 100%. Một đôi giày thể thao hoàn hảo để chơi thể thao, chạy bộ, tập gym, hoăc dạo phố đều thích hợp. ','320000.0',69,10,'adidas8512.jpg',1),(13,'Giày thể thao X_PLR PHASE adidas - IG4767','Đôi giày hoàn trả năng lượng có sử dụng chất liệu tái chế','2500000.0',100,30,'adidasgx3602.jpg',1),(14,'Giày Nike Nam Thể Thao Renew Ride 3 ‘Black’ DC8185-001','Thương hiệu: Nike. Mã sản phẩm: DC8185-001. Kiểu dáng: Ôm vừa, có dây buộc. Màu sắc: Đen, trắng. Chất liệu thân giày: Thân giày bằng da mềm mại\r\nCông nghệ đặc trưng: Đệm Renew. Giới tính: Nam','2318963.0',80,28,'nikedc8185.jpg',2),(15,'Giày Thể Thao Ni̲ke Zoom Pegasus 39','Thương hiệu: NIKE. Chiều rộng phù hợp: Không. Loại Khóa: Khóa dây. Da ngoài: Mờ. Xuất xứ: Việt Nam','2000000.0',96,45,'nikezoompegasus.jpg',2),(16,'Giày Thể Thao Nike Zoom 2021 Nam','Sản phẩm đảm bảo chất lượng và phù hợp với xu thế thị trường.','320000.0',149,12,'nikezoom2021.jpg',2),(17,'Giày thể thao Nike zoom N206','Chất liệu giày tái chế. Xuất xứ: Việt Nam','240000.0',98,5,'nikezoomn206.jpg',2),(19,'Giày Thể Thao PUMA RS-X COLOUR THEORY \' LIGHT GREY CELANDINE - SECONDHAND','Form ôm cần tăng lên 1 size so với size chuẩn thường mang. Condition: Giày chính hãng đã qua sử dụng. Giá tiền của sản phẩm sẽ phụ thuộc vào độ mới của từng đôi','699000.0',36,38,'pumars-x.jpg',3),(20,'Giày Thể Thao Puma RS-X 3D Low-Cut Sneakers 390025 Màu Đen Phối Màu','Giày Thể Thao Puma RS-X 3D Low-Cut Sneakers 390025 Màu Đen Phối Màu là đôi giày thể thao thời trang, được thiết kế với phong cách trẻ trung. Mẫu giày với gam màu đẹp mắt cùng form dáng trẻ trung đi lên chân vô cùng năng động.','2600000.0',94,50,'pumars-x3d.jpg',3),(21,'Giày thể thao Puma authentic chống trơn trượt nữ ','Giày thể thao Puma. Size: 36.5 - 37. Màu sắc: Đen, xanh. Nam, nữ, trẻ em lớn. Đế chống trơn trượt. Phù hợp đi bộ, leo dốc, chạy ngắn','138000.0',90,0,'pumaauthentic.jpg',3),(23,'Giày thể thao Gucci nữ siêu cấp','Giày thể thao Gucci sẵn size 35 nữ siêu cấp','2500000.0',100,25,'guccinu.jpg',4),(24,'GIÀY GUCCI RHYTON','Giày thể thao phù hợp cho cả nam và nữ','1800000.0',60,16,'guccithyton.jpg',4),(25,'Giày thể thao Puma Rs-0 Red 370709-03 2hand','Giày Thể Thao Puma RS-X 3D Low-Cut Sneakers 390025 Màu Đen Phối Màu là đôi giày thể thao thời trang, được thiết kế với phong cách trẻ trung. Mẫu giày với gam màu đẹp mắt cùng form dáng trẻ trung đi lên chân vô cùng năng động.','950000.0',20,12,'pumarsred.jpg',3),(26,'SNEAKER - Giày Thể Thao Gucci - Nam - GNTT216','Đặc tính: Sneaker, Giày thể thao.\r\nXuất xứ: Hong Kong.\r\nThương hiệu: Gucci.\r\nMặt khóa: Kim loại cao cấp chống hoen gỉ và bay màu.\r\nChất liệu: Da bò.\r\nĐế: Cao su Latex thiên nhiên bền bỉ, chịu ma sát chống trơn trượt.\r\nMàu sắc: Nâu be.','3250000.0',100,50,'GucciGNTT216.jpg',4),(28,'Giày Thể Thao Nike Air Jordan 1 Mid Metallic Red 554724-122','Air Jordan 1 Mid Matelic Red được thiết kế với sự phá cách tuyệt đối về màu sắc kết hợp từ 3 tông màu nổi bật đen-trắng-đỏ','5900000.0',100,15,'jordan1midmetalic.jpg',5),(29,'Giày Thể Thao Nike Air Jordan 1 Elevated High White Black DN3253-100 Màu Trắng Đen','Giới tính: Nam và nữ.\r\nMàu sắc: Đen trắng/\r\nKiểu dáng: Giày thể thao.\r\nChất liệu: Da cao cấp.','6700000.0',80,14,'jordan1elecvated.jpg',5),(30,'NIKE AIR JORDAN 4 BRED','Giày cổ cao, phù hợp cho cả nam và nữ','1200000.0',10,12,'jordan4jd4.jpg',5),(31,'GIÀY THỂ THAO NIKE AIR JORDAN 1 MID -TRẮNG','Giày Thể Thao Nike Air Jordan 1 Mid - một trong những dòng giày huyền thoại của Nike.\r\nVới chất liệu da cao cấp ôm lấy chân bạn một cách mềm mại, thoải mái kết hợp thiết kế cao cổ hợp thời trang. Giày Thể Thao Nike Air Jordan 1 Mid có thể sử dụng mục đích đi hàng ngày, đi chơi hay đi tập thể thao như bóng rổ đều được.','3610000.0',100,15,'jordan1mid.jpg',5),(32,'Giày thể thao Ananas TRACK 6 UTILITY GUM SOLE - LOW TOP - NAVY PEONY/GUM A6T008','Thương hiệu: ananas.\r\nXuất xứ: Việt Nam.','1045000.0',87,15,'ananastrack6utility.jpg',6),(33,'TRACK 6 CLASS E - LOW TOP - BOTANIST GREEN','Sử dụng chất da bò Nappa có bề mặt nhẵn bóng, kết hợp cùng mesh và Suede (da lộn) thường xuất hiện ở các đôi Sneaker cao cấp. Track 6 Class E (Essential, Enthusiasm) ngoài thể hiện nét trang trọng và tinh tế qua từng mảng chất liệu, còn tập trung vào cách bố trí và sắp xếp màu sắc tạo điểm nhấn nhẹ nhàng cho tổng thể. ','1190000.0',100,0,'ananastrack6classe.jpg',6),(34,'GIÀY SNEAAKER ANANAS LOW TOP - BLACK/GUM','Gender: Nam và nữ. Size run: 38.\r\nUpper: Canvas. Outsole: Rubber','720000.0',100,65,'ananassneaker.jpg',6),(35,'VINTAS THE NEW MILITARY - LOW TOP - CAPULET OLIVE','Mang vẻ ngoài bụi bặm, mộc mạc và được lấy cảm hứng từ những bộ quân phục của nhiều binh chủng trong quân đội, Vintas \"The New Military\" đem lại một \"chất lính\" rất riêng cho những ai yêu phong cách \"Military\" và những tâm hồn điềm đạm, kiên cường đầy tinh tế.','465000.0',100,15,'ananasvintas.jpg',6),(36,'Giày Thể Thao Nam Biti\'s BSM001100','Giày Thể Thao Nam Biti\'s BSM001100 là một trong những mẫu thiết kế nổi bật nhất của nhà Biti’s. Với thiết kế sang trọng, tinh tế, ẩn chứa sự mạnh mẽ và nam tính. Thiết kế chắc chắn sẽ là mẫu giày tuyệt vời dành cho phái mạnh.','752000.0',100,25,'bitisbsm001100.jpg',7),(37,'Giày Thể Thao Nam Hunter Core - Gravity Leap Collection DSMH10900','Nếu bạn dự định sở hữu một đôi giày thể thao cho nam vừa bắt “trend”, vừa chất lượng thì Giày Thể Thao Nam Hunter Core - Gravity Leap Collection DSMH10900 là một lựa chọn không thể bỏ qua. ','834000.0',100,55,'bitisdsmh10900.jpg',7),(38,'Giày Thể Thao Nam Biti\'s Hunter Core HSM003200DEN ','Tên sản phẩm: Giày Thể Thao Nam Biti\'s Hunter Core HSM003200DEN (Đen).\r\nSản xuất tại: Việt Nam.\r\nGiày: Thể thao biti\'shunter core nữ mới.','860000.0',99,13,'bitisHSM003200.jpg',7),(39,'Giày Thể Thao Nam Hunter X - X-NITE 22 Collection DSMH10500','Giày thể thao nam Hunter X - X-NITE 22 Collection DSMH10500 sở hữu thiết kế mạnh mẽ, lấy ý tưởng từ ánh sáng của pháo hoa và lửa. Cách phối màu đem lại cho người mang cảm giác tươi trẻ, tự do, phù hợp với hoạt động thể thao như đi bộ, chạy và các hoạt động khác.','981000.0',100,29,'bitishunterx.jpg',7),(41,'Giày VANS ERA CLASSIC SPORT BLACK/WATERFALL','Với sự kết hợp của màu sắc BLACK/WATERFALL, Giày VANS ERA CLASSIC SPORT thêm phần sang trọng và tươi mát. Đây là một lựa chọn thời trang đa dụng, dễ dàng phối hợp với nhiều loại trang phục khác nhau, từ trang phục thể thao đến trang phục hàng ngày.','1450000.0',100,15,'vansera.jpg',8),(42,'VANS OLD SKOOL MODULAR TURTLEDOV/TRUE WHITE','Dòng sản phẩm: Old Skool.\r\nMã SKU: VN0007P18NL.\r\nChất liệu:	56.2% Leather, 43.8% Textile.\r\nMàu sắc: Turtledove/True White.\r\nGiới tính:	Nam và nữ.','2350000.0',100,18,'vansoldskoolmodular.jpg',8),(43,'Giày VANS KNU SKOOL GREEN WHITE VN0009QCBGN','Khi bàn về thương hiệu giày thể thao hàng đầu thế giới, nhắc đến Vans không chỉ ta sẽ nhớ hình ảnh của những đôi giày, mà còn là sự sáng tạo không ngừng và phong cách đậm chất cá nhân. Thương hiệu Vans tạo ra các sản phẩm thời trang góp phần xây dựng nên một cộng đồng đam mê style thể thao đường phố, nơi mà cá nhân được thể hiện và tôn vinh qua từng đôi giày.','2400000.0',100,30,'vansvn0009.jpg',8),(44,'GIÀY THỂ THAO SNEAKER BALENCIAGA TESS S.GOMMA VALENCIA GAS NEAKERS','Phù hợp cho cả nam và nữ, cá tính, sang chảnh','2734800.0',100,27,'balenciagatess.jpg',9),(45,'Giày Balenciaga Speed Run','Giày Balenciaga Speed Run là một trong những đôi giày thể thao sáng tạo và táo bạo nhất từng được sản xuất. Với thiết kế lấy cảm hứng từ tất chạy bộ truyền thống và được nâng cấp với công nghệ hiện đại, Speed Run đã trở thành một biểu tượng của phong cách thời trang đường phố avant-garde.','460000.0',100,0,'balenciagaspeedrun.jpg',9),(46,'Giày Balenciaga Logo-Print | Giày Thể Thao | Giày Khủng Bố','','2900000.0',100,45,'balenciagalogoprint.jpg',9),(47,'Giày Balenciaga Triple S Royal Blue 483565W06E11022','Giày Balenciaga Triple S Royal Blue  483565W06E11022 tiếp tục mang tới nhiều sự thay đổi cho các tín đồ của dòng sản phẩm Triple S, với sự cách tân đặc sắc trên những phối màu đã có nhằm tối giản hóa công việc lựa chọn đau đầu.','2100000.0',100,19,'balenciagaroyalblue.jpg',9),(51,'\"Adidas ZX 2K Boost \'White Multi\' Marathon Running Shoes/Sneakers\" FX8835','Sản phảm này là sự lựa chọn hoàn hảo cho những ai yêu thích phong cách thể thao và năng động. Với thiết kế đa dạng, màu sắc tươi sáng và chất liệu cao cấp, mẫu giày này mang đến cho bạn sự thoải mái, bền bỉ và thời trang.','4900000.0',76,30,'adidaszx2k.jpg',1),(54,'Giày Thể Thao Nike Air Max Pulse FQ8733-010','Giày Thể Thao Nike Air Max Pulse FQ8733-010 Màu Đen là mẫu giày thể thao trẻ trung, khỏe khoắn của thương hiệu Nike nổi tiếng của Mỹ. Đôi giày với gam màu hiện đại cùng chất liệu cao cấp, bền đẹp.\r\n','3500000.0',100,15,'nike_air_max_pluse.jpg',2),(56,'Giày Sneaker Nike Court Royale Nam','Thương hiệu: Nike. Giới tính: Nam. Chất liệu: Cao cấp, không đau chân','1290000.0',50,20,'nike_court_royal.jpg',2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `registerdate` timestamp NOT NULL,
  `address` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'Trịnh Trung Hào','22110316@student.hcmute.edu.vn','1234','0382553081','Nam','2024-11-18 13:30:36','484 Lê Văn Việt','Hồ Chí Minh'),(11,'Trịnh Trung Hào','trinhtrunghao2003@gmail.com','12345','0978672375','Nam','2024-12-06 04:33:53','1 Võ Văn Ngân, TP Thủ Đức','Hồ Chí Minh'),(13,'Nguyễn Văn A','dohao1112003@gmail.com','1234','0978632632','Nam','2024-12-06 08:53:41','1 Võ Văn Ngân, TP Thủ Đức','Hồ Chí Minh'),(14,'Trung Hào','haotrinh2003.com@gmail.com','1234','0369157487','Nam','2024-12-06 12:26:16','Ấp 5, xã Nhị Thành, Thủ Thừa','Long An'),(16,'Nguyễn Hoàng Nam','jennyhuynhda@gmail.com','1234','0876735536','Nam','2024-12-07 12:53:24','123 Lê Trung Trực','Hồ Chí Minh');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `idwishlist` int NOT NULL AUTO_INCREMENT,
  `iduser` int DEFAULT NULL,
  `idproduct` int DEFAULT NULL,
  PRIMARY KEY (`idwishlist`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (1,1,2),(3,3,10),(4,3,4),(5,3,15),(6,7,20),(7,7,11),(8,8,13),(9,10,24),(10,11,2),(12,12,19),(14,14,15),(15,14,16),(17,3,3),(18,16,15),(19,16,16);
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-02 11:17:06
