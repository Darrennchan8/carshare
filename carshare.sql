CREATE TABLE parking_lot (
    lot_id INT AUTO_INCREMENT PRIMARY KEY,
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
        ON DELETE CASCADE
        ON UPDATE CASCADE
    make VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    year INT(4) NOT NULL,
    color VARCHAR(255) NOT NULL,
    mileage DOUBLE UNSIGNED NOT NULL,
    license_plate_number VARCHAR(8) NOT NULL
);

create table TRIP_DETAILS (
    reservation INT AUTO_INCREMENT PRIMARY KEY,
    reservation_start decimal,
    reservation_end decimal,
    actual_start decimal,
    actual_end decimal,
    rate decimal);

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
