-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 21, 2026 at 11:55 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fleetflow`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking_log`
--

CREATE TABLE `booking_log` (
  `id` int(11) NOT NULL,
  `request_id` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking_log`
--

INSERT INTO `booking_log` (`id`, `request_id`, `user_id`, `created_at`) VALUES
(1, 'req_1771663482880_6x5ebp4jw', 13, '2026-02-21 08:44:43'),
(2, 'req_1771663605010_pzk7t19zo', 13, '2026-02-21 08:46:45'),
(3, 'req_1771665006046_c2jqh2s8l', 13, '2026-02-21 09:10:09'),
(4, 'req_1771665030079_c2vd6mrxu', 13, '2026-02-21 09:10:30'),
(5, 'req_1771665203457_n7w2kw47k', 13, '2026-02-21 09:13:24'),
(6, 'req_1771666115757_wxoj15d0k', 13, '2026-02-21 09:28:35'),
(7, 'req_1771666913099_2j6nana32', 13, '2026-02-21 09:41:53'),
(8, 'req_1771668288354_yjaroqvbl', 13, '2026-02-21 10:04:48'),
(9, 'req_1771669928438_zyry4fk0a', 15, '2026-02-21 10:32:13'),
(10, 'req_1771670331786_vwp8zf81x', 16, '2026-02-21 10:38:51');

-- --------------------------------------------------------

--
-- Table structure for table `driver_details`
--

CREATE TABLE `driver_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `license_number` varchar(50) DEFAULT NULL,
  `license_expiry` date DEFAULT NULL,
  `vehicle_type` enum('car','van','truck','bike') DEFAULT 'car',
  `experience_years` int(11) DEFAULT 0,
  `safety_score` decimal(3,2) DEFAULT 5.00,
  `total_trips` int(11) DEFAULT 0,
  `total_earnings` decimal(10,2) DEFAULT 0.00,
  `current_status` enum('available','on_trip','off_duty','suspended') DEFAULT 'off_duty',
  `assigned_vehicle_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver_details`
--

INSERT INTO `driver_details` (`id`, `user_id`, `license_number`, `license_expiry`, `vehicle_type`, `experience_years`, `safety_score`, `total_trips`, `total_earnings`, `current_status`, `assigned_vehicle_id`, `created_at`, `updated_at`) VALUES
(6, 14, '1234567898', '2026-02-11', 'van', 50, 5.00, 0, 0.00, 'on_trip', NULL, '2026-02-21 06:32:40', '2026-02-21 10:06:09'),
(7, 17, 'GJ06 XY 123', '2026-02-28', 'van', 10, 5.00, 0, 0.00, 'on_trip', NULL, '2026-02-21 10:40:04', '2026-02-21 10:40:27');

-- --------------------------------------------------------

--
-- Table structure for table `driver_ratings`
--

CREATE TABLE `driver_ratings` (
  `id` int(11) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `passenger_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fuel_logs`
--

CREATE TABLE `fuel_logs` (
  `id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `trip_id` int(11) DEFAULT NULL,
  `liters` decimal(10,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `price_per_liter` decimal(10,2) DEFAULT NULL,
  `odometer_reading` int(11) DEFAULT NULL,
  `fuel_date` date NOT NULL,
  `fuel_type` enum('petrol','diesel','electric') DEFAULT 'diesel',
  `station_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_logs`
--

CREATE TABLE `maintenance_logs` (
  `id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `service_type` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL,
  `service_date` date NOT NULL,
  `next_service_date` date DEFAULT NULL,
  `odometer_reading` int(11) DEFAULT NULL,
  `status` enum('scheduled','in_progress','completed') DEFAULT 'scheduled',
  `performed_by` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','success','warning','danger') DEFAULT 'info',
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `is_read`, `created_at`) VALUES
(7, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:11:20'),
(8, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:31'),
(9, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:31'),
(10, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:31'),
(11, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:36'),
(12, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:37'),
(13, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:37'),
(14, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:48'),
(15, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:48'),
(16, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:21:48'),
(17, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:22:02'),
(18, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:22:02'),
(19, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:22:02'),
(20, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:25:33'),
(21, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:25:33'),
(22, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:25:33'),
(23, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:39:39'),
(24, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:39:39'),
(25, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:39:39'),
(26, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:52:35'),
(27, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:52:35'),
(28, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 07:52:35'),
(29, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 08:44:43'),
(30, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 08:46:45'),
(31, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 09:10:10'),
(32, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 09:10:30'),
(33, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 09:13:24'),
(34, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 09:28:35'),
(35, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 09:41:53'),
(36, 1, 'New Ride Booked', 'A new ride has been booked by passenger #13', 'info', 0, '2026-02-21 10:04:48'),
(37, 1, 'New Ride Booked', 'A new ride has been booked by passenger #15', 'info', 0, '2026-02-21 10:32:17'),
(38, 1, 'New Ride Booked', 'A new ride has been booked by passenger #16', 'info', 0, '2026-02-21 10:38:54');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('cash','card','wallet') NOT NULL,
  `payment_status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `transaction_id` varchar(100) DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `description`, `updated_at`) VALUES
(1, 'site_name', 'FleetFlow', 'Website name', '2026-02-21 05:17:19'),
(2, 'site_email', 'support@fleetflow.com', 'Support email address', '2026-02-21 05:17:19'),
(3, 'site_phone', '+1-800-FLEETFLOW', 'Support phone number', '2026-02-21 05:17:19'),
(4, 'base_fare', '5.00', 'Base fare for rides', '2026-02-21 05:17:19'),
(5, 'per_km_rate_car', '2.50', 'Per kilometer rate for cars', '2026-02-21 05:17:19'),
(6, 'per_km_rate_van', '3.50', 'Per kilometer rate for vans', '2026-02-21 05:17:19'),
(7, 'per_km_rate_truck', '5.00', 'Per kilometer rate for trucks', '2026-02-21 05:17:19'),
(8, 'per_km_rate_bike', '1.50', 'Per kilometer rate for bikes', '2026-02-21 05:17:19'),
(9, 'currency_symbol', '$', 'Currency symbol', '2026-02-21 05:17:19'),
(10, 'tax_rate', '8.875', 'Tax rate percentage', '2026-02-21 05:17:19'),
(11, 'driver_commission', '80', 'Driver commission percentage', '2026-02-21 05:17:19'),
(12, 'min_ride_distance', '1', 'Minimum ride distance in km', '2026-02-21 05:17:19'),
(13, 'max_ride_distance', '500', 'Maximum ride distance in km', '2026-02-21 05:17:19'),
(14, 'support_hours', '24/7', 'Customer support hours', '2026-02-21 05:17:19'),
(15, 'company_address', '123 Fleet Street, New York, NY 10001', 'Company physical address', '2026-02-21 05:17:19'),
(16, 'google_maps_api_key', 'YOUR_API_KEY_HERE', 'Google Maps API key for mapping services', '2026-02-21 05:17:19');

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `id` int(11) NOT NULL,
  `request_id` varchar(100) DEFAULT NULL,
  `trip_number` varchar(20) NOT NULL,
  `passenger_id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `pickup_location` text NOT NULL,
  `dropoff_location` text NOT NULL,
  `pickup_lat` decimal(10,8) DEFAULT NULL,
  `pickup_lng` decimal(11,8) DEFAULT NULL,
  `dropoff_lat` decimal(10,8) DEFAULT NULL,
  `dropoff_lng` decimal(11,8) DEFAULT NULL,
  `cargo_weight_kg` decimal(10,2) DEFAULT NULL,
  `distance_km` decimal(10,2) DEFAULT NULL,
  `estimated_fare` decimal(10,2) DEFAULT NULL,
  `actual_fare` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','accepted','started','completed','cancelled') DEFAULT 'pending',
  `cancellation_reason` text DEFAULT NULL,
  `payment_method` enum('cash','card','wallet') DEFAULT 'cash',
  `payment_status` enum('pending','paid','failed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepted_at` timestamp NULL DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trips`
--

INSERT INTO `trips` (`id`, `request_id`, `trip_number`, `passenger_id`, `driver_id`, `vehicle_id`, `pickup_location`, `dropoff_location`, `pickup_lat`, `pickup_lng`, `dropoff_lat`, `dropoff_lng`, `cargo_weight_kg`, `distance_km`, `estimated_fare`, `actual_fare`, `status`, `cancellation_reason`, `payment_method`, `payment_status`, `created_at`, `accepted_at`, `started_at`, `completed_at`, `cancelled_at`) VALUES
(42, 'req_1771668288354_yjaroqvbl', 'TRIP00042', 13, 14, NULL, '40.71005225842899, -74.00339126586915', '40.66579582990908, -73.96562576293947', 40.71005226, -74.00339127, 40.66579583, -73.96562576, NULL, 6.90, 29.11, NULL, 'accepted', NULL, 'cash', 'pending', '2026-02-21 10:04:48', NULL, NULL, NULL, NULL),
(44, 'req_1771670331786_vwp8zf81x', 'TRIP00044', 16, 17, NULL, '924, Garden Street, Uptown, Hoboken, Hudson County, New Jersey, 07050, United States', '40.71213418976528, -73.99927139282228', 40.74855745, -74.02948380, 40.71213419, -73.99927139, NULL, 7.80, 32.15, NULL, 'accepted', NULL, 'cash', 'pending', '2026-02-21 10:38:52', NULL, NULL, NULL, NULL);

--
-- Triggers `trips`
--
DELIMITER $$
CREATE TRIGGER `after_trip_completed` AFTER UPDATE ON `trips` FOR EACH ROW BEGIN
    IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
        UPDATE driver_details 
        SET total_trips = total_trips + 1,
            total_earnings = total_earnings + NEW.actual_fare
        WHERE user_id = NEW.driver_id;
        
        UPDATE vehicles 
        SET current_odometer = current_odometer + (NEW.distance_km * 1000)
        WHERE id = NEW.vehicle_id;
        
        IF NOT EXISTS (SELECT 1 FROM payments WHERE trip_id = NEW.id) THEN
            INSERT INTO payments (trip_id, amount, payment_method, payment_status, payment_date)
            VALUES (NEW.id, NEW.actual_fare, NEW.payment_method, 'completed', NOW());
        END IF;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_trip_ended` AFTER UPDATE ON `trips` FOR EACH ROW BEGIN
    IF NEW.status IN ('completed', 'cancelled') AND OLD.status NOT IN ('completed', 'cancelled') THEN
        UPDATE driver_details 
        SET current_status = 'available'
        WHERE user_id = NEW.driver_id;
        
        UPDATE vehicles 
        SET status = 'available'
        WHERE id = NEW.vehicle_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_trip_started` AFTER UPDATE ON `trips` FOR EACH ROW BEGIN
    IF NEW.status = 'started' AND OLD.status != 'started' THEN
        UPDATE driver_details 
        SET current_status = 'on_trip'
        WHERE user_id = NEW.driver_id;
        
        UPDATE vehicles 
        SET status = 'on_trip'
        WHERE id = NEW.vehicle_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_trips` BEFORE INSERT ON `trips` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT AUTO_INCREMENT INTO next_id 
    FROM information_schema.tables 
    WHERE table_name = 'trips' AND table_schema = DATABASE();
    SET NEW.trip_number = CONCAT('TRIP', LPAD(next_id, 5, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trip_tracking`
--

CREATE TABLE `trip_tracking` (
  `id` int(11) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `driver_lat` decimal(10,8) NOT NULL,
  `driver_lng` decimal(11,8) NOT NULL,
  `speed` decimal(5,2) DEFAULT 0.00,
  `heading` int(11) DEFAULT 0,
  `accuracy` decimal(5,2) DEFAULT 0.00,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `role` enum('admin','driver','passenger') DEFAULT 'passenger',
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `phone`, `profile_image`, `role`, `status`, `created_at`, `updated_at`, `last_login`) VALUES
(1, 'admin', 'admin@fleetflow.com', '$2y$10$Y3NOhHqt4L2fOyxcOdDF3.qYRCv1rxg3eC/RCo5.ZbpjFiaKQhu2i', 'System Administrator', '+1234567890', NULL, 'admin', 'active', '2026-02-21 05:17:18', '2026-02-21 10:41:15', '2026-02-21 10:41:15'),
(13, 'zala', 'krushnraj@gmail.com', '$2y$10$Y3NOhHqt4L2fOyxcOdDF3.qYRCv1rxg3eC/RCo5.ZbpjFiaKQhu2i', 'Zala Krushnraj', '1597534568', NULL, 'passenger', 'active', '2026-02-21 06:20:53', '2026-02-21 10:07:24', '2026-02-21 10:07:24'),
(14, 'salman', 'raju@gmail.com', '$2y$10$Y3NOhHqt4L2fOyxcOdDF3.qYRCv1rxg3eC/RCo5.ZbpjFiaKQhu2i', 'raju', '1234567890', NULL, 'driver', 'active', '2026-02-21 06:32:40', '2026-02-21 10:05:34', '2026-02-21 10:05:34'),
(16, 'Mahesh', 'mahesh@gmail.com', '$2y$10$1TcC5lB4JaHl0kXMojjhCOz3YctLh9vSb8UX2vN655vleZFMwvKie', 'Mahesh Patel', '7895478963', NULL, 'passenger', 'active', '2026-02-21 10:38:09', '2026-02-21 10:40:54', '2026-02-21 10:40:54'),
(17, 'Krish', 'krish@gmail.com', '$2y$10$BtC6/AdphidVD4YYcDnCdeyfAdXZvKpaLc0a3gNpyw9C31sGCC3Ma', 'Krish Zala', '7041565859', NULL, 'driver', 'active', '2026-02-21 10:40:04', '2026-02-21 10:40:18', '2026-02-21 10:40:18');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `vehicle_name` varchar(100) NOT NULL,
  `license_plate` varchar(20) NOT NULL,
  `vehicle_type` enum('truck','van','car','bike') DEFAULT 'car',
  `max_capacity_kg` decimal(10,2) NOT NULL,
  `current_odometer` int(11) DEFAULT 0,
  `fuel_type` enum('petrol','diesel','electric','hybrid') DEFAULT 'petrol',
  `status` enum('available','on_trip','in_shop','retired') DEFAULT 'available',
  `last_maintenance` date DEFAULT NULL,
  `next_maintenance` date DEFAULT NULL,
  `insurance_expiry` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `vehicle_name`, `license_plate`, `vehicle_type`, `max_capacity_kg`, `current_odometer`, `fuel_type`, `status`, `last_maintenance`, `next_maintenance`, `insurance_expiry`, `created_at`, `updated_at`) VALUES
(9, 'van', 'gj-04-z-1456', 'van', 200.00, 1500, 'hybrid', 'on_trip', NULL, NULL, NULL, '2026-02-21 06:45:00', '2026-02-21 10:09:49'),
(12, 'van', 'gj-04-z-1457', 'truck', 1500.00, 150, 'petrol', 'in_shop', NULL, NULL, NULL, '2026-02-21 10:42:33', '2026-02-21 10:42:57');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_active_trips`
-- (See below for the actual view)
--
CREATE TABLE `vw_active_trips` (
`id` int(11)
,`trip_number` varchar(20)
,`pickup_location` text
,`dropoff_location` text
,`distance_km` decimal(10,2)
,`estimated_fare` decimal(10,2)
,`status` enum('pending','accepted','started','completed','cancelled')
,`created_at` timestamp
,`passenger_name` varchar(100)
,`passenger_phone` varchar(20)
,`driver_name` varchar(100)
,`driver_phone` varchar(20)
,`vehicle_name` varchar(100)
,`license_plate` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_driver_performance`
-- (See below for the actual view)
--
CREATE TABLE `vw_driver_performance` (
`driver_id` int(11)
,`driver_name` varchar(100)
,`vehicle_type` enum('car','van','truck','bike')
,`total_trips` int(11)
,`total_earnings` decimal(10,2)
,`safety_score` decimal(3,2)
,`total_ratings` bigint(21)
,`avg_rating` decimal(14,4)
,`completed_trips` decimal(22,0)
,`cancelled_trips` decimal(22,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_vehicle_maintenance`
-- (See below for the actual view)
--
CREATE TABLE `vw_vehicle_maintenance` (
`id` int(11)
,`vehicle_name` varchar(100)
,`license_plate` varchar(20)
,`current_odometer` int(11)
,`last_maintenance` date
,`next_maintenance` date
,`insurance_expiry` date
,`days_to_maintenance` int(7)
,`maintenance_status` varchar(8)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_active_trips`
--
DROP TABLE IF EXISTS `vw_active_trips`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_active_trips`  AS SELECT `t`.`id` AS `id`, `t`.`trip_number` AS `trip_number`, `t`.`pickup_location` AS `pickup_location`, `t`.`dropoff_location` AS `dropoff_location`, `t`.`distance_km` AS `distance_km`, `t`.`estimated_fare` AS `estimated_fare`, `t`.`status` AS `status`, `t`.`created_at` AS `created_at`, `p`.`full_name` AS `passenger_name`, `p`.`phone` AS `passenger_phone`, `d`.`full_name` AS `driver_name`, `d`.`phone` AS `driver_phone`, `v`.`vehicle_name` AS `vehicle_name`, `v`.`license_plate` AS `license_plate` FROM (((`trips` `t` join `users` `p` on(`t`.`passenger_id` = `p`.`id`)) left join `users` `d` on(`t`.`driver_id` = `d`.`id`)) left join `vehicles` `v` on(`t`.`vehicle_id` = `v`.`id`)) WHERE `t`.`status` in ('pending','accepted','started') ;

-- --------------------------------------------------------

--
-- Structure for view `vw_driver_performance`
--
DROP TABLE IF EXISTS `vw_driver_performance`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_driver_performance`  AS SELECT `u`.`id` AS `driver_id`, `u`.`full_name` AS `driver_name`, `d`.`vehicle_type` AS `vehicle_type`, `d`.`total_trips` AS `total_trips`, `d`.`total_earnings` AS `total_earnings`, `d`.`safety_score` AS `safety_score`, count(distinct `r`.`id`) AS `total_ratings`, avg(`r`.`rating`) AS `avg_rating`, sum(case when `t`.`status` = 'completed' then 1 else 0 end) AS `completed_trips`, sum(case when `t`.`status` = 'cancelled' then 1 else 0 end) AS `cancelled_trips` FROM (((`users` `u` join `driver_details` `d` on(`u`.`id` = `d`.`user_id`)) left join `trips` `t` on(`u`.`id` = `t`.`driver_id`)) left join `driver_ratings` `r` on(`u`.`id` = `r`.`driver_id`)) WHERE `u`.`role` = 'driver' GROUP BY `u`.`id` ;

-- --------------------------------------------------------

--
-- Structure for view `vw_vehicle_maintenance`
--
DROP TABLE IF EXISTS `vw_vehicle_maintenance`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_vehicle_maintenance`  AS SELECT `v`.`id` AS `id`, `v`.`vehicle_name` AS `vehicle_name`, `v`.`license_plate` AS `license_plate`, `v`.`current_odometer` AS `current_odometer`, `v`.`last_maintenance` AS `last_maintenance`, `v`.`next_maintenance` AS `next_maintenance`, `v`.`insurance_expiry` AS `insurance_expiry`, to_days(`v`.`next_maintenance`) - to_days(curdate()) AS `days_to_maintenance`, CASE WHEN to_days(`v`.`next_maintenance`) - to_days(curdate()) <= 7 THEN 'critical' WHEN to_days(`v`.`next_maintenance`) - to_days(curdate()) <= 30 THEN 'warning' ELSE 'good' END AS `maintenance_status` FROM `vehicles` AS `v` WHERE `v`.`status` <> 'retired' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking_log`
--
ALTER TABLE `booking_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_request_id` (`request_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `driver_details`
--
ALTER TABLE `driver_details`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `license_number` (`license_number`),
  ADD KEY `assigned_vehicle_id` (`assigned_vehicle_id`),
  ADD KEY `idx_license` (`license_number`),
  ADD KEY `idx_status` (`current_status`);

--
-- Indexes for table `driver_ratings`
--
ALTER TABLE `driver_ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_trip_rating` (`trip_id`),
  ADD KEY `passenger_id` (`passenger_id`),
  ADD KEY `idx_driver` (`driver_id`);

--
-- Indexes for table `fuel_logs`
--
ALTER TABLE `fuel_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trip_id` (`trip_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_fuel_date` (`fuel_date`);

--
-- Indexes for table `maintenance_logs`
--
ALTER TABLE `maintenance_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_service_date` (`service_date`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_read` (`is_read`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_trip` (`trip_id`),
  ADD KEY `idx_status` (`payment_status`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trip_number` (`trip_number`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_driver` (`driver_id`),
  ADD KEY `idx_passenger` (`passenger_id`),
  ADD KEY `idx_created` (`created_at`),
  ADD KEY `idx_trip_number` (`trip_number`),
  ADD KEY `idx_request_id` (`request_id`);

--
-- Indexes for table `trip_tracking`
--
ALTER TABLE `trip_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_trip` (`trip_id`),
  ADD KEY `idx_driver` (`driver_id`),
  ADD KEY `idx_updated` (`updated_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `license_plate` (`license_plate`),
  ADD KEY `idx_plate` (`license_plate`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_type` (`vehicle_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking_log`
--
ALTER TABLE `booking_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `driver_details`
--
ALTER TABLE `driver_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `driver_ratings`
--
ALTER TABLE `driver_ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `fuel_logs`
--
ALTER TABLE `fuel_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `maintenance_logs`
--
ALTER TABLE `maintenance_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `trips`
--
ALTER TABLE `trips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `trip_tracking`
--
ALTER TABLE `trip_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `driver_details`
--
ALTER TABLE `driver_details`
  ADD CONSTRAINT `driver_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `driver_details_ibfk_2` FOREIGN KEY (`assigned_vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `driver_ratings`
--
ALTER TABLE `driver_ratings`
  ADD CONSTRAINT `driver_ratings_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `driver_ratings_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `driver_ratings_ibfk_3` FOREIGN KEY (`passenger_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fuel_logs`
--
ALTER TABLE `fuel_logs`
  ADD CONSTRAINT `fuel_logs_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fuel_logs_ibfk_2` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `maintenance_logs`
--
ALTER TABLE `maintenance_logs`
  ADD CONSTRAINT `maintenance_logs_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `trips`
--
ALTER TABLE `trips`
  ADD CONSTRAINT `trips_ibfk_1` FOREIGN KEY (`passenger_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trips_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `trips_ibfk_3` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `trip_tracking`
--
ALTER TABLE `trip_tracking`
  ADD CONSTRAINT `trip_tracking_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trip_tracking_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `cleanup_booking_logs` ON SCHEDULE EVERY 1 DAY STARTS '2026-02-22 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DELETE FROM booking_log WHERE created_at < NOW() - INTERVAL 1 DAY;
    DELETE FROM trips WHERE request_id IS NOT NULL AND created_at < NOW() - INTERVAL 1 DAY AND status = 'pending';
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
