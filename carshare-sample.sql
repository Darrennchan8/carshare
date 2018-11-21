INSERT INTO parking_lot(lot_id, address, city, state, zip_code, capacity) VALUES
    (1, '1109 West Marshall Street', 'Richmond', 'VA', 23220, 3),
    (2, '601 West Bacon Street', 'Richmond', 'VA', 23222, 2),
    (3, '200 West Cary Street', 'Richmond', 'VA', 23220, 4),
    (4, '607 North 10th Street', 'Richmond', 'VA', 23220, 3);

INSERT INTO account(email_address, password_hash, first_name, last_name, address, city, state, zip_code, phone_number, creation_date) VALUES
    ('rodriguezdl@vcu.edu', '$2a$12$0TBPmJfOif1q4m9DFCQPVOzw4xkQsqWNiiF9dIHGH3Wepz34a3R6C', 'Daniel', 'Rodriguez',
        '340 College Avenue', 'Commack', 'NY', 11725, 2025550149, 1538524728801),
    ('chand3@vcu.edu', '$2a$12$PSkGhrXH24plG5lUoWTKAOFLmOXU85TM8.SKqgW1LDZGZSCmTQBdi', 'Darren', 'Chan',
        '8135 Sutor Drive ', 'Northville', 'MI', 48167, 2127378040, 1538963776422),
    ('dhinganiv@vcu.edu', '$2a$12$XljWZ8UuEJ70k2D1NWbRRu1YKmKFoDU00dErWRJIEfJ.VEEO2ulTS', 'Vasu', 'Dhingani',
        '81 Pilgrim Ave.', 'Chester', 'PA', 19013, 4064287501, 1538864010510),
    ('martinkl@gmail.com', '$2a$12$Jk3mzqgNTR9S/D4giGs5wOZKaXcK3KD0X/mRsrxuHNKlxQPlTOKc6', 'King', 'Martin',
        '31 South Street', 'New Albany', 'IN', 471250, 5054610705, 1538998002062),
    ('s2dmduke@vcu.edu', '$2a$12$hflgY5ItHNV86skL1srfuOsnEHiNl496wkkKakCx1P2LDgCBDEYem', 'Debra', 'Duke',
        '506 East Armstrong Avenue', 'Plymouth', 'MA', 02360, 2059678509, 1538567650524),
    ('plooer@aol.net', '$2a$12$Vk7AD572qOvOl/sENgJBVegf6v8tFcwbKfYYRYjfaV/KFJ1HgZJHq', 'Darren', 'Chan',
        '8135 Sutor Drive ', 'Northville', 'MI', 48167, 2127378040, 1538963776422),
    ('chand3@mymail.vcu.edu', '$2a$12$PSkGhrXH24plG5lUoWTKAOFLmOXU85TM8.SKqgW1LDZGZSCmTQBdi', 'Ere', 'Ploo',
        '160 8th St.', 'Caldwell', 'NJ', 07006, 2028216794, 1539049922050),
    ('Patelviyat@gmail.com', '$2y$12$Z46FuqPRt.nm7S3NY.BzMO.NQh/sINCO.SQUHw7tXVg.zVE9QLMo.', 'Viyat', 'Patel',
        '4820 Spring Street ', 'Effingham', 'IL', 62401, 8898790930, 1539117108806),
    ('Jmh@gmail.com', '$2y$12$Z46FuqPRt.nm7S3NY.BzMO.NQh/sINCO.SQUHw7tXVg.zVE9QLMo.', 'Hakiziman', 'Jean-Marie',
        '2763 Payne Street', 'Davenport', 'VA', 24239, 2768591677, 1539096222812);

INSERT INTO vehicle(vin, lot_id, make, model, year, color, mileage, license_plate_number) VALUES
    ('1G1ZB5E18BF215943', 1, 'Ford', 'Focus', 2018, 'Black', 2000, 'JJZ-7865'),
    ('1FTCR11T1JUD23467', 2, 'Ford', 'Focus', 2018, 'White', 20000, 'HVZ-1234'),
    ('1FAFP52U83A163390', 1, 'Honda', 'Civic', 2017, 'Silver', 23756, 'VZA-1234'),
    ('1FDEE14N9MHA80517', 3, 'Honda', 'Fit', 2017, 'White', 12000, 'AZV-5432'),
    ('3VWPD69M51M113790', 3, 'Honda', 'CR-V', 2018, 'Grey', 2300, 'VHA-2030'),
    ('1GTEK14H8DJ565795', 4, 'Tesla', 'Model 3', 2018, 'Black', 2300, 'VHA-2030'),
    ('JW6AJC1H7RL081260', 4, 'Tesla', 'Model X', 2018, 'Silver', 1200, 'GHZ-2015'),
    ('5TBJN321XYS072757', 4, 'Subaru', 'Impreza', 2017, 'Silver', 14000, 'DCA-1222'),
    ('1GYS4EEJ0CR116546', 2, 'Volkswagen', 'Golf', 2018, 'Black', 0, 'FVA-6798'),
    ('1G1ZB5E18BF215944', 1, 'Volkswagen', 'Golf', 2018, 'White', 0, 'GHZ-1030');

INSERT INTO trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate, email_address, vin) VALUES
    (1, '1538532022549', '1534835683484', '1538530934232', '1534835546230', 16.28, 'rodriguezdl@vcu.edu', '1G1ZB5E18BF215943'),
    (2, '1538532022549', '1524423128022', '1538858554165', '1524422619917', 15.19, 'chand3@vcu.edu', '5TBJN321XYS072757'),
    (3, '1538859608574', '1512109265089', '1538701327302', '1512109167948', 12.44, 'dhinganiv@vcu.edu', '1G1ZB5E18BF215943'),
    (4, '1538819777779', '1513927712388', '1538818274507', '1513927869320', 15.85, 'martinkl@gmail.com', '3VWPD69M51M113790'),
    (5, '1538560793482', '1527040783398', '1538559512577', '1527040580469', 11.34, 's2dmduke@vcu.edu', '3VWPD69M51M113790'),
    (6, '1538717364106', '1526159566185', '1538717257397', '1526160041030', 16.13, 'plooer@aol.net', '3VWPD69M51M113790'),
    (7, '1531152531024', '1538676489567', '1531151750464', '1538676007905', 17.65, 'rodriguezdl@vcu.edu', '5TBJN321XYS072757'),
    (8, '1536190468140', '1516540419270', '1536189356476', '1535884123533', 5.32, 'dhinganiv@vcu.edu', '1G1ZB5E18BF215943'),
    (9, '1536190130399', '1535883560576', '1536189356476', '1535884123533', 5.04, 's2dmduke@vcu.edu', '5TBJN321XYS072757'),
    (10, '1523695600656', '1533049031928', '1523693859469', '1533049110829', 9.44, 's2dmduke@vcu.edu', '1GTEK14H8DJ565795'),
    (11, '1524037596188', '1521307310477', '1524036616624', '1521307776096', 16.66, 'chand3@vcu.edu', '1G1ZB5E18BF215943'),
    (12, '1538322920916', '1515020294464', '1538354371429', '1515021161986', 7.95, 'plooer@aol.net', '3VWPD69M51M113790');

INSERT INTO location_record(vin, utc, coordinates, reservation) VALUES
    ('1G1ZB5E18BF215943', 1538524728801, '37.5452222, -77.4529756', 3),
    ('1FTCR11T1JUD23467', 1538524728801, '35.6895, 139.6917', NULL),
    ('1FAFP52U83A163390', 1538864010510, '27.6648,81.5158', NULL),
    ('1FDEE14N9MHA80517', 1538567650524, '39.9042,116.4074', NULL),
    ('3VWPD69M51M113790', 1539049922050, '39.9042,116.4074', 6),
    ('1GTEK14H8DJ565795', 1539049922050, '23.5505,46.6333', 10),
    ('JW6AJC1H7RL081260', 1539065097120, '4.7110,74.0721', NULL),
    ('5TBJN321XYS072757', 1539065097120, '53.4808,2.2426', 7),
    ('1GYS4EEJ0CR116546', 1539065097120, '53.4808,2.2426', NULL),
    ('1D4SE5GT7BC646986', 1539065097120, '4.7110,74.0721', NULL);

-- Insert sample data into incident_record
INSERT INTO incident_record(record_number. type. details, surcharge, waived)
    VALUES(1, 'Fender Bender', 'Driver involved in fender bender', 1000, 800);

INSERT INTO incident_record(record_number. type. details, surcharge, waived)
    VALUES(2, 'Flat Tire', 'Driver received flat tire', 0, 0);

INSERT INTO incident_record(record_number. type. details, surcharge, waived)
    VALUES(3, 'Engine Stall', 'Enigne stall occured on fleet vehicle', 0, 0);

INSERT INTO incident_record(record_number. type. details, surcharge, waived)
    VALUES(4, 'Flat Tire', 'Member incurred flat tire', 0, 0);

 -- Insert sample data into role
INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(0, 'Chief Executive Officer', 1, 1);

INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(1, 'Customer Service Representative', 1, 1);

INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(2, 'Customer Service Representative', 2, 2);

INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(3, 'Accountant', 1, 1);

INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(4, 'Chief Operating Officer', 1, 2);

INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(5, 'Software Engineer', 2, 4);

INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(6, 'Software Engineer', 1, 4);

INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(7, 'Software Engineer', 1, 1);x

INSERT INTO role(role_id, name, pay_type, emp_type)
    VALUES(8, 'Customer Service Representative', 1, 3);

 -- Insert sample data into employee
 INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('dillard@carshare.com', 234567890, 7.29, 1234567890, 987654321);

INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('diazr@carshare.com', 123456789, 25, 2467101214, 354652598);

INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('adamsk@carshare.com', 246810111, 35, 1798709878, 746538987);

INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('dhinganiv@carshare.com', 369121518, 25, 4928028990, 214414254);

INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('chand@carshare.com', 481216789, 15, 8475618479, 539522323);

INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('rodriguezdl@carshare.com', 093112222, 50, 4127468279, 784792876);

INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('hopeb@carshare.com', 234980143, 35, 5638478793, 837492923);

INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('carsonb@carshare.com', 458980012, 30, 2739482980, 418401238);

INSERT INTO employee (email_address, ssn, wage, bank_account_number, routing_number)
    VALUES ('dickson@carshare.com', 473232012, 30, 4738293801, 442392011);

-- Insert sample data into feedback
INSERT INTO feedback (ticket_number, subject, message, viewed, email_address)
    VALUES (1, 'Great App', 'This is such a great app!', 1);

INSERT INTO feedback (ticket_number, subject, message, viewed, email_address)
    VALUES (2, 'Great Service', 'This service is very convenient!', 2);

INSERT INTO feedback (ticket_number, subject, message, viewed, email_address)
    VALUES (3, 'Service Improvements', 'App does not indicate whether someone is late with the car', 1);

-- Insert sample date into client
INSERT INTO client (email_address, drivers_licens_num, credit_card_num credits) 
    VALUES ('rodriguezdl@vcu.edu', 58289128, 60114204036205706, , 5);

INSERT INTO client (email_address, drivers_licens_num, credit_card_num, credits) 
    VALUES ('chand3@vcu.edu', 'S530-460-97-370', 4556456898789665, 0);

INSERT INTO client (email_address, drivers_licens_num, credit_card_num, credits) 
    VALUES ('dhinganiv@vcu.edu', 'Y8955507', 4556114810353812, 0);

INSERT INTO client (email_address, drivers_licens_num, credit_card_num, credits) 
    VALUES ('martinkl@gmail.com', 'Y8955507', 4716917753546508, 2);

INSERT INTO client (email_address, drivers_licens_num, credit_card_num, credits) 
    VALUES ('s2dmduke@vcu.edu', 'S-530-718-328-529', 526578639753861, 0);

INSERT INTO client (email_address, drivers_licens_num, credit_card_num, credits) 
    VALUES ('plooer@aol.net', '12169056', 371586777472001, 1.5);

-- Insert sample data into maintenance
INSERT INTO maintenance(vin, service_type, utc)
    VALUES('1G1ZB5E18BF215943', 'Oil Change', );

INSERT INTO maintenance(vin, service_type, utc)
    VALUES('3VWPD69M51M113790', 'Oil Change', );

INSERT INTO maintenance(vin, service_type, utc)
    VALUES('1G1ZB5E18BF215943', 'Tire Rotation', );

INSERT INTO maintenance(vin, service_type, utc)
    VALUES('3VWPD69M51M113790', 'Tire Rotation', );

INSERT INTO maintenance(vin, service_type, utc)
    VALUES('5TBJN321XYS072757', 'Tire Replacement', );

INSERT INTO maintenance(vin, service_type, utc)
    VALUES('5TBJN321XYS072757', 'Headlight Replacement', );    

INSERT INTO maintenance(vin, service_type, utc)
    VALUES('3VWPD69M51M113790', 'Engine Replacement', );

-- Insert sample data into incident
INSERT INTO incident(record_number, incident_type, details, surcharge, waived)
    VALUES(1, 1);

INSERT INTO incident(reservation, record_number)
    VALUES(2, 2);

INSERT INTO incident(reservation, record_number)
    VALUES(3, 3);

INSERT INTO incident(reserrvatiom, record_number)
    VALUES(4, 4);
