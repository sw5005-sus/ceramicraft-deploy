-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- 主机： mysql:3306
-- 生成日期： 2025-10-27 12:05:16
-- 服务器版本： 8.0.43
-- PHP 版本： 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
CREATE DATABASE IF NOT EXISTS `product_db`;
USE `product_db`;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `product_db`
--

-- --------------------------------------------------------

--
-- 表的结构 `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `price` bigint NOT NULL,
  `desc` text NOT NULL,
  `stock` bigint NOT NULL,
  `pic_info` text NOT NULL,
  `dimensions` varchar(255) DEFAULT NULL,
  `material` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `capacity` varchar(255) DEFAULT NULL,
  `care_instructions` text,
  `status` int NOT NULL,
  `version` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `products`
--

INSERT INTO `products` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `category`, `price`, `desc`, `stock`, `pic_info`, `dimensions`, `material`, `weight`, `capacity`, `care_instructions`, `status`, `version`) VALUES
(1, '2025-10-03 06:54:31.105', '2025-10-26 12:54:36.486', NULL, 'Blue-and-white bowl', 'pottery', 3500, 'Exquisite ceramic bowls with a warm, lustrous glaze, perfect for everyday dining.', 456177, '[\"1870d5478d6b226b.png\"]', 'Diameter: 15 cm, Height: 7 cm', 'Ceramic', '350g', '500ml', 'Dishwasher safe. Avoid extreme temperature changes.', 1, 0),
(2, '2025-10-03 06:54:46.659', '2025-10-24 09:04:08.279', NULL, 'White Glaze Mug', 'pottery', 2800, 'A minimalist ceramic mug, perfect for coffee or tea.', 0, '[\"1870d56bd3e30b54.png\"]', '8cm*10cm', 'Ceramic', '280g', '300ml', 'Hand wash is recommended; avoid prolonged soaking.', 1, 0),
(3, '2025-10-03 06:55:19.858', '2025-10-24 09:04:08.416', NULL, 'Handmade Vase', 'vases', 12000, 'Hand-thrown vase, perfect for display in the living room or study.', 0, '[\"1870d5322bc167e0.png\"]', 'Height 25cm Diameter 12cm', 'Ceramic', '1.2kg', '50ml', 'Regularly dust and avoid direct exposure to strong sunlight.', 1, 0),
(4, '2025-10-03 06:55:37.103', '2025-10-23 09:02:18.927', NULL, 'Storage tank', 'pottery', 8000, 'Large-capacity ceramic jar, suitable for storing tea leaves or dried goods', 903, '[\"1870d51e8d7bd300.png\"]', 'Height: 22 cm, Diameter: 15 cm', 'Ceramic', '1.5kg', '1.5L', 'Avoid sudden temperature changes; hand washing is recommended.', 1, 0),
(5, '2025-10-03 06:55:55.649', '2025-10-23 08:55:03.649', NULL, 'Premium Ceramic Oil Jug', 'pottery', 9500, 'Premium ceramic oil bottle with superior sealing properties, ideal for storing various cooking oils in the kitchen.', 15, '[\"1870d559379dc150.png\"]', '10x8x15cm', 'Ceramic', '0.5kg', '500ml', 'Avoid dropping; store at room temperature.', 1, 0),
(6, '2025-10-03 15:41:41.242', '2025-10-03 15:41:41.242', NULL, 'Test Product', 'pottery', 14222, 'test', 10, '', '1', '2', '3', '4', '5', 0, 0),
(7, '2025-10-03 16:34:14.940', '2025-10-03 16:34:14.940', NULL, 'Pic upload', 'vases', 432, 'qwq', 4, '186b084fc8799c13.png', '', '', '', '', '', 0, 0),
(8, '2025-10-04 03:58:22.928', '2025-10-23 13:03:35.168', NULL, '测试多图商品', 'vases', 5000, '这是一个用来测试多图片切换功能的商品', 1216, '[\"68dbb946.png\",\"186b084fc8799c13.png\"]', '', '', '', '', '', 0, 0),
(9, '2025-10-22 10:17:12.631', '2025-10-22 14:11:02.857', NULL, 'Blue and white porcelain', 'vases', 10000, 'elegant', 1, '[\"1870c8a7cceb7f65.png\"]', '10*5*3', 'porcelain', '2.5 lbs', '16 oz', 'Dishwasher safe', 1, 0),
(10, '2025-10-22 15:02:49.863', '2025-10-23 09:14:07.865', NULL, 'Dipping sauce bowl', 'pottery', 5000, 'A minimalist and elegant set of dipping sauce bowls designed for everyday dining and entertaining. Perfect for serving soy sauce, vinegar, olive oil, ketchup, mustard, or small snacks. Their smooth glaze finish and compact size make them both functional and aesthetically pleasing for any table setting.', 40, '[\"1870d83c531a398e.png\"]', 'Diameter: 3.5 in / 9 cm  Height: 1.2 in / 3 cm', 'High-fired porcelain with lead-free, non-toxic glaze', 'Single bowl: 90 g (3.2 oz)', '60 ml (2 fl oz) per bowl', 'Dishwasher safe\nMicrowave and oven safe up to 220°C (428°F)\nAvoid sudden temperature changes to prevent cracking\nStore stacked carefully to prevent chipping', 1, 0),
(11, '2025-10-23 10:43:30.149', '2025-10-23 10:52:55.018', NULL, 'Porcelain Teapot', 'ceramics', 3000, 'An elegant high-fired porcelain teapot designed to bring balance and serenity to every pour. Its smooth glaze, rounded silhouette, and ergonomic handle create a perfect fusion of functionality and aesthetics. Ideal for tea lovers who appreciate both beauty and performance — whether serving green tea, oolong, or herbal infusions.\n\nThe precisely shaped spout ensures a clean, drip-free pour, while the wide opening allows for easy cleaning and tea leaf removal.', 45, '[\"187118c3a013bd18.png\"]', 'Diameter (body): 14 cm / 5.5 in  Height (with lid): 11.5 cm / 4.5 in', 'High-fired porcelain (1250°C firing temperature)', '520 g (18.3 oz)', '850 ml (28.7 fl oz) — serves approximately 4–5 cups of tea', 'Dishwasher safe (remove infuser before washing)\nMicrowave safe (except with metal parts)\nHand washing recommended for longer lifespan\nAvoid rapid temperature changes (do not pour boiling water into a cold pot)\nStore dry to maintain glaze sheen', 0, 0),
(12, '2025-10-23 10:52:40.881', '2025-10-23 12:10:00.511', NULL, 'Porcelain Teapot', 'ceramics', 3000, 'An elegant high-fired porcelain teapot designed to bring balance and serenity to every pour. Its smooth glaze, rounded silhouette, and ergonomic handle create a perfect fusion of functionality and aesthetics. Ideal for tea lovers who appreciate both beauty and performance — whether serving green tea, oolong, or herbal infusions.\n\nThe precisely shaped spout ensures a clean, drip-free pour, while the wide opening allows for easy cleaning and tea leaf removal.', 43, '[\"18711943a1e443f2.png\"]', 'Diameter (body): 14 cm / 5.5 in  Height (with lid): 11.5 cm / 4.5 in', 'High-fired porcelain (1250°C firing temperature)', '520 g (18.3 oz)', '850 ml (28.7 fl oz) — serves approximately 4–5 cups of tea', 'Dishwasher safe (remove infuser before washing)\nMicrowave safe (except with metal parts)\nHand washing recommended for longer lifespan\nAvoid rapid temperature changes (do not pour boiling water into a cold pot)\nStore dry to maintain glaze sheen', 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `shopping_cart_items`
--

CREATE TABLE `shopping_cart_items` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `product_id` int NOT NULL DEFAULT '0',
  `quantity` int NOT NULL DEFAULT '0',
  `select_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1:unselected 2:selected',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `shopping_cart_items`
--

INSERT INTO `shopping_cart_items` (`id`, `user_id`, `product_id`, `quantity`, `select_status`, `created_at`, `updated_at`) VALUES
(1, 6, 1, 6, 1, '2025-10-08 13:23:31', '2025-10-08 13:45:18'),
(2, 6, 5, 1, 1, '2025-10-08 13:38:11', '2025-10-08 13:45:18');

--
-- 转储表的索引
--

--
-- 表的索引 `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_products_deleted_at` (`deleted_at`);

--
-- 表的索引 `shopping_cart_items`
--
ALTER TABLE `shopping_cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_idx` (`user_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- 使用表AUTO_INCREMENT `shopping_cart_items`
--
ALTER TABLE `shopping_cart_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
