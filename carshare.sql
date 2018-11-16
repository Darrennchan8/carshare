CREATE TABLE parking_lot (
    lot_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code INT(5) UNSIGNED ZEROFILL NOT NULL,
    capacity INT UNSIGNED NOT NULL
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

CREATE TABLE trip_details (
    reservation INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reservation_start BIGINT UNSIGNED NOT NULL,
    reservation_end BIGINT UNSIGNED NOT NULL,
    actual_start BIGINT UNSIGNED NOT NULL,
    actual_end BIGINT UNSIGNED NOT NULL,
    rate DOUBLE(5, 2) UNSIGNED NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    vin CHAR(17) NOT NULL,
    FOREIGN KEY (email_address) REFERENCES account(email_address)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (reservation) REFERENCES trip_details(reservation)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
) ENGINE=InnoDB;

CREATE TABLE vehicle (
    vin CHAR(17) PRIMARY KEY,
    lot_id INT UNSIGNED NOT NULL,
    make VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    year INT(4) UNSIGNED ZEROFILL NOT NULL,
    color VARCHAR(255) NOT NULL,
    mileage DOUBLE UNSIGNED NOT NULL,
    license_plate_number VARCHAR(8) NOT NULL,
    FOREIGN KEY (lot_id) REFERENCES parking_lot(lot_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE location_record (
    vin CHAR(17) NOT NULL,
    utc BIGINT UNSIGNED NOT NULL,
    coordinates VARCHAR(255) NOT NULL,
    reservation INT UNSIGNED NULL,
    FOREIGN KEY (vin) REFERENCES vehicle(vin)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (reservation) REFERENCES trip_details(reservation)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY(vin, utc)
) ENGINE=InnoDB;

CREATE TABLE maintenance (
    vin CHAR(17) NOT NULL,
    service_type TEXT NOT NULL,
    utc BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (vin) REFERENCES vehicle(vin)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY(vin, utc)
) ENGINE=InnoDB;

CREATE TABLE incident (
    record_number INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reservation INT UNSIGNED NULL,
    type VARCHAR(255) NOT NULL,
    details TEXT NULL,
    surcharge DOUBLE(7, 2) UNSIGNED DEFAULT 0.00,
    waived DOUBLE(7, 2) UNSIGNED DEFAULT 0.00,
    FOREIGN KEY (reservation) REFERENCES trip_details(reservation)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE client (
    email_address VARCHAR(255) PRIMARY KEY,
    drivers_license_number VARCHAR(255),
    credit_card_number INT(16) UNSIGNED,
    credits INT,
    FOREIGN KEY (email_address) REFERENCES account(email_address)
        ON DELETE CASCADE,
        ON UPDATE CASCADE, 
    
) ENGINE=InnoDB;

CREATE TABLE role (
    role_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    pay_type enum('Salaried', 'Hourly'),
    employee_type enum('Full Time', 'Part Time', 'Intern', 'Contractor'),
);

CREATE TABLE job_type (
    email_address VARCHAR(255),
    FOREIGN KEY (email_address) REFERENCES employee(email_address),
    FOREIGN KEY (role_id) REFERENCES role(role_id),
) ENGINE=InnoDB;

CREATE TABLE employee (
    email_address VARCHAR(255) PRIMARY KEY,
    ssn INT(9) UNSIGNED ZEROFILL,
    wage DOUBLE(9,2) UNSIGNED NOT NULL,
    bank_account_number BIGINT UNSIGNED NOT NULL,
    routing_number BIGINT UNISGNED,
    FOREIGN KEY (manager_email_address) REFERENCES employee(email_address), 
) ENGINE=InnoDB;

