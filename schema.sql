-- DATABASE: smart_tourism_db

DROP DATABASE IF EXISTS smart_tourism_db;

CREATE DATABASE smart_tourism_db;

USE smart_tourism_db;

-- ============================================================
-- TABLE 1 : DESTINATIONS
-- ============================================================

CREATE TABLE destinations
(
    destination_id INT AUTO_INCREMENT PRIMARY KEY,

    destination_name VARCHAR(100) NOT NULL,

    city VARCHAR(50) NOT NULL,

    state VARCHAR(50) NOT NULL,

    description TEXT
);

-- ============================================================
-- TABLE 2 : HOTELS
-- ============================================================
CREATE TABLE hotels
(
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,

    destination_id INT NOT NULL,

    hotel_name VARCHAR(100) NOT NULL,

    hotel_type ENUM
    (
        'Budget',
        'Standard',
        'Business',
        'Luxury',
        'Resort',
        'Dharamshala'
    ) NOT NULL,

    rating DECIMAL(2,1)
        CHECK (rating BETWEEN 1 AND 5),

    base_room_price DECIMAL(10,2) NOT NULL
        CHECK (base_room_price > 0),

    FOREIGN KEY(destination_id)
        REFERENCES destinations(destination_id)
);

-- ============================================================
-- TABLE 3 : ROOM TYPES
-- ============================================================

CREATE TABLE room_types
(
    room_type_id INT AUTO_INCREMENT PRIMARY KEY,

    hotel_id INT NOT NULL,

    room_type_name ENUM
    (
        'Standard',
        'Deluxe',
        'Executive',
        'Suite',
        'Family'
    ) NOT NULL,

    price_per_night DECIMAL(10,2) NOT NULL
        CHECK(price_per_night > 0),

    total_rooms INT NOT NULL
        CHECK(total_rooms > 0),

    FOREIGN KEY(hotel_id)
        REFERENCES hotels(hotel_id)
);

-- ============================================================
-- TABLE 4 : TOURISTS
-- ============================================================

CREATE TABLE tourists
(
    tourist_id INT AUTO_INCREMENT PRIMARY KEY,

    full_name VARCHAR(100) NOT NULL,

    gender ENUM
    (
        'Male',
        'Female',
        'Other'
    ) NOT NULL,

    phone VARCHAR(15) UNIQUE NOT NULL,

    email VARCHAR(100) UNIQUE NOT NULL,

    city VARCHAR(50),

    registration_date DATE NOT NULL
);

-- ============================================================
-- TABLE 5 : BOOKINGS
-- ============================================================
--(tourist_id,room_type_id,booking_date,check_in_date,check_out_date,total_guests,booking_status)

CREATE TABLE bookings
(
    booking_id INT AUTO_INCREMENT PRIMARY KEY,

    tourist_id INT NOT NULL,

    room_type_id INT NOT NULL,

    booking_date DATE NOT NULL,

    check_in_date DATE NOT NULL,

    check_out_date DATE NOT NULL,

    total_guests INT NOT NULL
        CHECK(total_guests > 0),

    booking_status ENUM
    (
        'Pending',
        'Confirmed',
        'Cancelled',
        'Completed'
    ) DEFAULT 'Pending',


    CHECK(check_out_date > check_in_date),

    FOREIGN KEY(tourist_id)
        REFERENCES tourists(tourist_id),

    FOREIGN KEY(room_type_id)
        REFERENCES room_types(room_type_id)
);
