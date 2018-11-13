CREATE TABLE parking_lot (
    lot_id UNSIGNED INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code INT(5) NOT NULL,
    capacity INT UNSIGNED
);

CREATE TABLE vehicle (
    vin CHAR(17) PRIMARY KEY,
    FOREIGN KEY lot_id(lot_id)
        REFERENCES parking_lot(lot_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    make VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    year INT(4) NOT NULL,
    color VARCHAR(255) NOT NULL,
    mileage DOUBLE UNSIGNED NOT NULL,
    license_plate_number VARCHAR(8) NOT NULL
);

CREATE TABLE location_recored (
    FOREIGN KEY vin(vin)
        REFERENCES vehicle(vin)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    coordinates VARCHAR(255) PRIMARY KEY,
    utc BIGINT UNSIGNED PRIMARY KEY
);

CREATE TABLE location (
    coordinates VARCHAR(255) PRIMARY KEY,
    utc BIGINT UNSIGNED PRIMARY KEY
);

CREATE TABLE incident_at (
    coordinates VARCHAR(255) PRIMARY KEY,
    utc BIGINT UNSIGNED PRIMARY KEY,
    record_number UNSIGNED INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE maintenance (
    FOREIGN KEY vin(vin)
        REFERENCES vehicle(vin)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    service_type VARCHAR(1023) PRIMARY KEY,
    maintenance_date CHAR(10) PRIMARY KEY -- YYYY/MM/DD
);

CREATE TABLE trip_details (
    reservation UNSIGNED INT AUTO_INCREMENT PRIMARY KEY,
    reservation_start BIGINT UNSIGNED NOT NULL,
    reservation_end BIGINT UNSIGNED NOT NULL,
    actual_start BIGINT UNSIGNED NOT NULL,
    actual_end BIGINT UNSIGNED NOT NULL,
    rate DOUBLE(5, 2) UNSIGNED NOT NULL
);

create table ACCOUNT (
    email varchar(50) PRIMARY KEY,
    passHash varchar(100),
    FirstName varchar(20),
    LastName varchar(50),
    address varchar(60),
    city char(40),
    state char(40),
    zipCode decimal,
    phoneNum decimal,
    creationDate bigint);
