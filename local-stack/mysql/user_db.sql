-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- 主机： mysql:3306
-- 生成日期： 2025-10-27 12:03:31
-- 服务器版本： 8.0.43
-- PHP 版本： 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
CREATE DATABASE IF NOT EXISTS `user_db`;
USE `user_db`;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `user_db`
--

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` bigint NOT NULL,
  `email` varchar(128) NOT NULL,
  `zitadel_sub` varchar(128) DEFAULT '',
  `password` varchar(255) NOT NULL,
  `status` bigint NOT NULL,
  `activate_time` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `avatar_id` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `status`, `activate_time`, `created_at`, `updated_at`, `name`, `avatar_id`) VALUES
(1, 'testuser@u.nus.edu', '$2a$10$oxf0GNWEbYbNXKBb6P4VXOEBxhVLMyl.9jBu21zc6E/oJojXq6qna', -1, NULL, '2025-10-03 06:53:02.811', '2025-10-03 06:53:02.811', NULL, NULL),
(2, 'xianxx492@gmail.com', '$2a$10$kpelVE2pbgKNYotR3F.hq..CvFgCaIOXnCwyG6U2AYlEUso.qyeii', 1, '2025-10-07 13:48:16.108', '2025-10-03 06:56:48.514', '2025-10-07 13:48:16.108', NULL, NULL),
(3, 'xianxx492@outlook.com', '$2a$10$0wJIa6AdOLRZvW7/4rS6DetMGeUSh0TxwZiGYYozm4YEDoowTDzii', 1, '2025-10-03 07:16:26.263', '2025-10-03 07:15:40.367', '2025-10-06 08:40:01.476', 'xianxx492', '186bda3516482d76.jpeg'),
(4, 'merchant@example.com', '$2a$10$Ds1/TpunbqJxuaSHKcvp.umgZW8IG3zwVjLp3VnCTN3dggHwQG4yK', -1, NULL, '2025-10-03 14:30:22.838', '2025-10-03 14:30:22.838', NULL, NULL),
(5, 'e1553331@u.nus.edu', '$2a$10$lfy3zki.RGwpvg2c5azfbuhXKEdm425o5M41jEoQe5Aci9sjp6aJS', 1, '2025-10-17 05:06:57.344', '2025-10-04 12:14:44.501', '2025-10-17 05:06:57.344', 'hi', 'videoauth.png'),
(6, 'e1554415@u.nus.edu', '$2a$10$Xg9b5oFhrG1wjQEVfEM5NOk7KI2Z9zgY8A0rhG6uCuwK6YngUq62i', 1, '2025-10-07 13:52:38.119', '2025-10-07 13:52:08.046', '2025-10-07 13:53:16.699', 'xian', '186c39e1c3d36df8.jpeg'),
(7, '656501226@qq.com', '$2a$10$zz.lJ3qnudCyzkVsPnYok.aAy7KjmW2FHuIxw1w.tOEUIvUsie5b6', 1, '2025-10-08 11:40:05.210', '2025-10-08 11:39:11.223', '2025-10-08 14:21:32.231', 'testuser', '186c8a002f14a99a.jpeg'),
(8, '18513066505@163.com', '$2a$10$qrAbbKsr5VC7u1lyAUilEusgDzTfd97uacP4eDh1dl44v8hRq2cia', 1, '2025-10-16 08:32:57.018', '2025-10-16 08:31:34.756', '2025-10-16 09:11:14.100', '', '186eedb6d4e07a29.jpg'),
(9, 'xianxx492zxy@163.com', '$2a$10$mURXpXz9tSBpnL4SP0e9y.5s37UNjbD.mRNOxxdBF16rITbe3ZSju', 1, '2025-10-17 02:58:42.258', '2025-10-17 02:57:54.364', '2025-10-17 02:58:42.258', '', ''),
(10, 'Xianxx492_zxy@163.com', '$2a$10$Qe0IOMxl9WRonU1YrAl9SuoveFZ7D9/cSstoRPQDxt4NqOt2mtz6u', 1, '2025-10-21 10:30:08.296', '2025-10-21 10:29:47.968', '2025-10-21 10:34:47.600', 'hi', ''),
(11, 'xinyi.jiang.0511@gmail.com', '$2a$10$vHgRE8h82F3Svdua184uP.FsGLodhd0kLKKdnLykkIiOJH32zppGC', 1, '2025-10-23 07:06:39.607', '2025-10-23 07:06:23.335', '2025-10-23 07:06:39.609', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `user_activations`
--

CREATE TABLE `user_activations` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `code` varchar(8) NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `user_activations`
--

INSERT INTO `user_activations` (`id`, `user_id`, `code`, `created_at`, `expires_at`) VALUES
(1, 1, '801344', '2025-10-03 06:53:02.836', '2025-10-03 06:58:03'),
(4, 4, '053417', '2025-10-03 14:30:22.846', '2025-10-03 14:35:23');

-- --------------------------------------------------------

--
-- 表的结构 `user_addresses`
--

CREATE TABLE `user_addresses` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `zip_code` varchar(16) NOT NULL,
  `country` varchar(64) NOT NULL,
  `province` varchar(64) NOT NULL,
  `city` varchar(64) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `contact_phone` varchar(32) NOT NULL,
  `default_mark_time` bigint NOT NULL DEFAULT '0',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `user_addresses`
--

INSERT INTO `user_addresses` (`id`, `user_id`, `zip_code`, `country`, `province`, `city`, `detail`, `first_name`, `last_name`, `contact_phone`, `default_mark_time`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 5, '10001', 'China', 'Beijing', 'Beijing', 'A Street B Block C Door', 'Jin', 'Lian', '+8614254789172', 1759583983, '2025-10-04 13:18:45.121', '2025-10-04 13:20:24.900', '2025-10-04 13:20:24.900'),
(2, 5, '10000', 'China', 'Beijing', 'Changchun', 'A Street B Block C Door', 'Jin', 'Lian', '+8614254789172', 1759583954, '2025-10-04 13:19:14.225', '2025-10-04 13:19:14.225', NULL),
(3, 3, '100036', 'china', 'beijing', 'beijing', 'fuxing', 'yanyan', 'zhang', '+8618513066505', 1759656277, '2025-10-05 08:38:10.374', '2025-10-05 09:27:03.457', '2025-10-05 09:27:03.456'),
(4, 3, '100036', 'china', 'beijing', 'beijing', 'fuxing road', 'xinyan', 'zhang', '+8618513066505', 1759658526, '2025-10-05 09:35:15.635', '2025-10-05 10:02:20.329', NULL),
(5, 3, '133028', 'singapore', 'singapore', 'singapore', '#06-45', 'xx', 'z', '+6584106275', 0, '2025-10-05 09:35:44.442', '2025-10-05 09:35:44.442', NULL),
(6, 3, '100000', 'china', 'beijing', 'beijing', 'xxxxxxxxxx', 'zili', 'gong', '+8613811471007', 0, '2025-10-05 09:36:47.855', '2025-10-05 09:42:09.382', '2025-10-05 09:42:09.382'),
(7, 3, '100036', 'china', 'beijing', 'beijing', '1231413', 'xy', 'z', '+8613661111318', 0, '2025-10-06 08:38:50.509', '2025-10-06 08:38:50.509', NULL),
(8, 7, '123123', 'singapore', 'singapore', 'singapore', 'nus', 'test', 'test', '+6512345678', 1759938239, '2025-10-08 15:43:59.132', '2025-10-08 15:43:59.132', NULL),
(9, 7, '100036', 'china', 'beijing', 'beijing', 'fuxingroad', 'xinyan', 'zhang', '+8618513066505', 0, '2025-10-10 11:20:30.710', '2025-10-10 11:20:30.710', NULL);

--
-- 转储表的索引
--

--
-- 表的索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uni_users_email` (`email`);

--
-- 表的索引 `user_activations`
--
ALTER TABLE `user_activations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_user_activations_code` (`code`),
  ADD KEY `idx_user_activations_user_id` (`user_id`);

--
-- 表的索引 `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `user_activations`
--
ALTER TABLE `user_activations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- 使用表AUTO_INCREMENT `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
