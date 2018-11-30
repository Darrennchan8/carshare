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

CREATE TABLE account (
    email_address VARCHAR(255) PRIMARY KEY,
    password_hash VARCHAR(255) NOT NULL,
    salt CHAR(29) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code INT(5) UNSIGNED ZEROFILL NOT NULL,
    phone_number BIGINT(10) UNSIGNED ZEROFILL NOT NULL,
    creation_date BIGINT UNSIGNED NOT NULL 
) ENGINE=InnoDB;

CREATE TABLE client (
    email_address VARCHAR(255) PRIMARY KEY,
    drivers_license_number VARCHAR(255) NOT NULL,
    credit_card_number BIGINT(16) UNSIGNED NOT NULL,
    credits INT DEFAULT 0,
    FOREIGN KEY (email_address) REFERENCES account(email_address)
        ON DELETE CASCADE
        ON UPDATE CASCADE
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
    FOREIGN KEY (email_address) REFERENCES client(email_address)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (vin) REFERENCES vehicle(vin)
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
    incident_type VARCHAR(255) NOT NULL,
    details TEXT NULL,
    surcharge DOUBLE(7, 2) UNSIGNED DEFAULT 0.00,
    waived DOUBLE(7, 2) UNSIGNED DEFAULT 0.00,
    FOREIGN KEY (reservation) REFERENCES trip_details(reservation)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE role (
    role_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    pay_type ENUM('Salaried', 'Hourly') NOT NULL,
    employee_type ENUM('Full Time', 'Part Time', 'Intern', 'Contractor') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE employee (
    email_address VARCHAR(255) PRIMARY KEY,
    manager_email_address VARCHAR(255) NULL,
    ssn INT(9) UNSIGNED ZEROFILL NOT NULL,
    wage DOUBLE(9,2) UNSIGNED NOT NULL,
    bank_account_number BIGINT UNSIGNED NOT NULL,
    routing_number BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (manager_email_address) REFERENCES employee(email_address)
        ON DELETE CASCADE
        ON UPDATE CASCADE 
) ENGINE=InnoDB;

CREATE TABLE job_type (
    email_address VARCHAR(255) NOT NULL,
    role_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (email_address) REFERENCES employee(email_address)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(role_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE feedback(
    email_address VARCHAR(255) NOT NULL,
    ticket_number INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    viewed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (email_address) REFERENCES account(email_address)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
