CREATE TABLE parking_lot (
    lot_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code INT(5) UNSIGNED ZEROFILL NOT NULL,
    capacity INT UNSIGNED NOT NULL
) ENGINE=InnoDB;

CREATE TABLE vehicle (
    vin CHAR(17) PRIMARY KEY,
    lot_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (lot_id) REFERENCES parking_lot(lot_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    make VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    year INT(4) UNSIGNED ZEROFILL NOT NULL,
    color VARCHAR(255) NOT NULL,
    mileage DOUBLE UNSIGNED NOT NULL,
    license_plate_number VARCHAR(8) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE location_record (
    vin CHAR(17) NOT NULL,
    coordinates VARCHAR(255) NOT NULL,
    utc BIGINT UNSIGNED NOT NULL,
    CONSTRAINT FOREIGN KEY (vin) REFERENCES vehicle(vin)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY(vin, utc)
) ENGINE=InnoDB;

CREATE TABLE incident_at (
    coordinates VARCHAR(255) PRIMARY KEY,
    utc BIGINT UNSIGNED PRIMARY KEY,
    record_number INT UNSIGNED AUTO_INCREMENT PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE maintenance (
    FOREIGN KEY vin
        REFERENCES vehicle(vin)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    service_type TEXT PRIMARY KEY,
    utc BIGINT UNSIGNED PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE trip_details (
    reservation INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reservation_start BIGINT UNSIGNED NOT NULL,
    reservation_end BIGINT UNSIGNED NOT NULL,
    actual_start BIGINT UNSIGNED NOT NULL,
    actual_end BIGINT UNSIGNED NOT NULL,
    rate DOUBLE(5, 2) UNSIGNED NOT NULL
) ENGINE=InnoDB;

CREATE TABLE vehicle_trips (
    PRIMARY KEY vin,
    PRIMARY KEY reservation,
    FOREIGN KEY vin
        REFERENCES vehicle(vin)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    FOREIGN KEY reservation
        REFERENCES trip_details(reservation)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE account (
    email_address VARCHAR(255) PRIMARY KEY,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code INT(5) UNSIGNED ZEROFILL NOT NULL,
    phone_number INT(10) UNSIGNED ZEROFILL NOT NULL,
    creation_date BIGINT UNSIGNED NOT NULL
) ENGINE=InnoDB;

CREATE TABLE trips (
    PRIMARY KEY reservation,
    PRIMARY KEY email_address,
    FOREIGN KEY reservation
        REFERENCES trip_details(reservation)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    FOREIGN KEY email_address
        REFERENCES account(email_address)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE incident_record (
    record_number INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    details TEXT NOT NULL,
    surcharge DOUBLE(7, 2) UNSIGNED DEFAULT 0.00,
    waived DOUBLE(7, 2) UNSIGNED DEFAULT 0.00
) ENGINE=InnoDB;

CREATE TABLE incident (
    PRIMARY KEY reservation,
    PRIMARY KEY record_number,
    FOREIGN KEY reservation
        REFERENCES trip_details(reservation)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    FOREIGN KEY record_number
        REFERENCES incident_record(record_number)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
