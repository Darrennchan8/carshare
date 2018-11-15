--Insert sample data for parking_lot.
insert into parking_lot(lot_id, address, city, state, zip_code, capacity) 
    values (1, '1109 West Marshall Street', 'Richmond', 'VA', 23220, 3);

insert into parking_lot(lot_id, address, city, state, zip_code, capacity) 
    values (2, '601 West Bacon Street', 'Richmond', 'VA', 23222, 2);

insert into parking_lot(lot_id, address, city, state, zip_code, capacity) 
    values (3, '200 West Cary Street', 'Richmond', 'VA', 23220, 4);

insert into parking_lot(lot_id, address, city, state, zip_code, capacity) 
    values (2, '607 North 10th Street', 'Richmond', 'VA', 23220, 3);

-- Insert sample data for TRIP_DETAILS.
insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(1, 1538532022549, 1534835683484, 15385309342232, 1534835546230, 16.28);

insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(2, 1538532022549, 1534835683484, 1538530934232, 1534835546230, 15.19);

 insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(3, 1538859608574, 1512109265089, 1538701327302, 1512109167948, 12.44);

 insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(4, 1538819777779, 1513927712988, 1538818274507, 1513927869320, 15.85);

insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(5,1538560793482, 1527040783398, 1538559512577, 1527040580469, 11.34);

insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(6, 1538717364106, 1526159566185, 1538717257397, 1526160041030, 16.13);    
          
insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(7, 1531152531024, 1538676489567, 1531151750464, 1538676007905, 17.65);

insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(8, 1536190468140, 15165404019270, 1536189356476, 1516541287011, 5.32);

insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(9, 1536190130399, 1535883560576, 1536189356476, 1535884123533, 5.04);

insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(10, 1523695600656, 1533049031928, 1523693859469, 1533049110829, 9.44);

insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(11, 1524037596188, 1533049031928, 1523693859469, 1533049110829, 16.66);

insert into TRIP_DETAILS (reservation, reservationStart, reservationEnd, actualStart, actualEnd, rate)
    values(12, 158355920916, 1515020294464, 1538354371429, 1515021161986, 7.95);
            
-- Insert sample data into ACCOUNT.
insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('rodriguezdl@vcu.edu', '$2a$12$0TBPmJfOif1q4m9DFCQPVOzw4xkQsqWNiiF9dIHGH3Wepz34a3R6C', 'Daniel', 'Rodriguez',
    '340 College Avenue', 'Commack', 'New York', 11725, 2025550149, 1538524728801);  

insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('chand3@vcu.edu', '$2a$12$PSkGhrXH24plG5lUoWTKAOFLmOXU85TM8.SKqgW1LDZGZSCmTQBdi', 'Darren', 'Chan',
    '8135 Sutor Drive ', 'Northville', 'Michigan', 48167, 2127378040, 1538963776422); 

insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('dhinganiv@vcu.edu', '$2a$12$XljWZ8UuEJ70k2D1NWbRRu1YKmKFoDU00dErWRJIEfJ.VEEO2ulTS', 'Vasu', 'Dhingani',
    '81 Pilgrim Ave.', 'Chester', 'Pennsylvania', 19013, 4064287501, 1538864010510); 

insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('martinkl@gmail.com', '$2a$12$Jk3mzqgNTR9S/D4giGs5wOZKaXcK3KD0X/mRsrxuHNKlxQPlTOKc6', 'King', 'Martin',
    '31 South Street', 'New Albany', 'Indiana', 471250, 5054610705, 1538998002062); 

insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('s2dmduke@vcu.edu', '$2a$12$hflgY5ItHNV86skL1srfuOsnEHiNl496wkkKakCx1P2LDgCBDEYem', 'Debra', 'Duke',
    '506 East Armstrong Avenue', 'Plymouth', 'Massachusetts', 02360, 205-967-8509, 1538567650524); 

insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('plooer@aol.net', '$2a$12$Vk7AD572qOvOl/sENgJBVegf6v8tFcwbKfYYRYjfaV/KFJ1HgZJHq', 'Darren', 'Chan',
    '8135 Sutor Drive ', 'Northville', 'Michigan', 48167, 2127378040, 1538963776422); 

insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('chand3@vcu.edu', '$2a$12$PSkGhrXH24plG5lUoWTKAOFLmOXU85TM8.SKqgW1LDZGZSCmTQBdi', 'Ere', 'Ploo',
    '160 8th St.', 'Caldwell', 'New Jersey', 07006, 2028216794, 1539049922050); 

insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('Patelviyat@gmail.com', '$2y$12$Z46FuqPRt.nm7S3NY.BzMO.NQh/sINCO.SQUHw7tXVg.zVE9QLMo.', 'Viyat', 'Patel',
    '4820 Spring Street ', 'Effingham', 'Illinois', 62401, 8898790930, 1539117108806); 

insert into ACCOUNT(email, passHash, FirstName, LastName, address, city, state, zipCode, phoneNum, creationDate) 
    values ('Jmh@gmail.com', '$2y$12$Z46FuqPRt.nm7S3NY.BzMO.NQh/sINCO.SQUHw7tXVg.zVE9QLMo.', 'Hakiziman', 'Jean-Marie',
    '2763 Payne Street', 'Davenport', 'Virginia', 24239, 2768591677, 1539096222812); 

-- Insert sample data into incident_record
insert into incident_record(record_number. type. details, surcharge, waived)
    values(1, 'Fender Bender', 'Driver involved in fender bender', 1000, 800);

insert into incident_record(record_number. type. details, surcharge, waived)
    values(2, 'Flat Tire', 'Driver received flat tire', 0, 0);

insert into incident_record(record_number. type. details, surcharge, waived)
    values(3, 'Engine Stall', 'Enigne stall occured on fleet vehicle', 0, 0);

insert into incident_record(record_number. type. details, surcharge, waived)
    values(4, 'Flat Tire', 'Member incurred flat tire', 0, 0);

 -- Insert sample data into role
insert into role(role_id, name, pay_type, emp_type)
    values(0, 'Chief Executive Officer', 1, 1);

insert into role(role_id, name, pay_type, emp_type)
    values(1, 'Customer Service Representative', 1, 1);

insert into role(role_id, name, pay_type, emp_type)
    values(2, 'Customer Service Representative', 2, 2);

insert into role(role_id, name, pay_type, emp_type)
    values(3, 'Accountant', 1, 1);

insert into role(role_id, name, pay_type, emp_type)
    values(4, 'Chief Operating Officer', 1, 2);

insert into role(role_id, name, pay_type, emp_type)
    values(5, 'Software Engineer', 2, 4);

insert into role(role_id, name, pay_type, emp_type)
    values(6, 'Software Engineer', 1, 4);

insert into role(role_id, name, pay_type, emp_type)
    values(7, 'Software Engineer', 1, 1);

insert into role(role_id, name, pay_type, emp_type)
    values(8, 'Customer Service Representative', 1, 3);

 -- Insert sample data into employee
 insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('dillard@carshare.com', 234567890, 7.29, 1234567890, 987654321);

insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('diazr@carshare.com', 123456789, 25, 2467101214, 354652598);

insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('adamsk@carshare.com', 246810111, 35, 1798709878, 746538987);

insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('dhinganiv@carshare.com', 369121518, 25, 4928028990, 214414254);

insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('chand@carshare.com', 481216789, 15, 8475618479, 539522323);

insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('rodriguezdl@carshare.com', 093112222, 50, 4127468279, 784792876);

insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('hopeb@carshare.com', 234980143, 35, 5638478793, 837492923);

insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('carsonb@carshare.com', 458980012, 30, 2739482980, 418401238);

insert into employee (email_address, ssn, wage, bank_account_number, routing_number)
    values ('dickson@carshare.com', 473232012, 30, 4738293801, 442392011);

-- Insert sample data into feedback
insert into feedback (ticket_number, subject, message, viewed, email_address)
    values (1, 'Great App', 'This is such a great app!', 1);

insert into feedback (ticket_number, subject, message, viewed, email_address)
    values (2, 'Great Service', 'This service is very convenient!', 2);

insert into feedback (ticket_number, subject, message, viewed, email_address)
    values (3, 'Service Improvements', 'App does not indicate whether someone is late with the car', 1);

-- Insert sample date into client
insert into client (email_address, drivers_licens_num, credit_card_num credits) 
    values ('rodriguezdl@vcu.edu', 58289128, 60114204036205706, , 5);

insert into client (email_address, drivers_licens_num, credit_card_num, credits) 
    values ('chand3@vcu.edu', 'S530-460-97-370', 4556456898789665, 0);

insert into client (email_address, drivers_licens_num, credit_card_num, credits) 
    values ('dhinganiv@vcu.edu', 'Y8955507', 4556114810353812, 0);

insert into client (email_address, drivers_licens_num, credit_card_num, credits) 
    values ('martinkl@gmail.com', 'Y8955507', 4716917753546508, 2);

insert into client (email_address, drivers_licens_num, credit_card_num, credits) 
    values ('s2dmduke@vcu.edu', 'S-530-718-328-529', 526578639753861, 0);

insert into client (email_address, drivers_licens_num, credit_card_num, credits) 
    values ('plooer@aol.net', '12169056', 371586777472001, 1.5);

-- Insert sample data into maintenance
insert into maintenance(vin, service_type, utc)
    values('1G1ZB5E18BF215943', 'Oil Change', );

insert into maintenance(vin, service_type, utc)
    values('3VWPD69M51M113790', 'Oil Change', );

insert into maintenance(vin, service_type, utc)
    values('1G1ZB5E18BF215943', 'Tire Rotation', );

insert into maintenance(vin, service_type, utc)
    values('3VWPD69M51M113790', 'Tire Rotation', );

insert into maintenance(vin, service_type, utc)
    values('5TBJN321XYS072757', 'Tire Replacement', );

insert into maintenance(vin, service_type, utc)
    values('5TBJN321XYS072757', 'Headlight Replacement', );    

insert into maintenance(vin, service_type, utc)
    values('3VWPD69M51M113790', 'Engine Replacement', );

-- Insert sample data into trip_details
insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(1, 1538532022549,1534835683484, 1538530934232, 1534835546230, 16.28);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(2, 1538859608574,1534835683484, 1538530934232, 1534835546230, 15.19);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(3, 1538702498700,15121098655089, 1538701327302, 1512109167948, 12.44);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(4, 1538819777779, 1513927712388, 1538818274507, 1513987869320, 15.85);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(5, 1538560793482, 1527040783398, 1538559512577, 1527040580469, 11.34);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(6, 1538717364106, 1526159566185, 1538717257397, 1526160041030, 16.13);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(7, 1531152531024, 1538676489567, 1531151750464, 1538676007905, 17.65);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(8, 1536190467140, 1516540419270, 1536789356476, 1516541287011, 5.32);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(9, 1536190130399, 1535883560576, 1536189356476, 1535884123533, 5.04);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(10, 1523695600656, 1533049031928, 152693859469, 1533049110829, 9.44); 
    
insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(11, 1524037596188, 1521307310477, 1524036616624, 1521307776096, 16.66);

insert into trip_details(reservation, reservation_start, reservation_end, actual_start, actual_end, rate)
    values(12, 1538355920916, 1515020294464, 1538354971429, 1515021161986, 7.95);

-- Insert sample data into incident
insert into incident(reservation, record_number)
    values(1, 1);

insert into incident(reservation, record_number)
    values(2, 2);

insert into incident(reservation, record_number)
    values(3, 3);

insert into incident(reserrvatiom, record_number)
    values(4, 4);

--Insert sample data into vehicle
insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(1, '1G1ZB5E18BF215943', 'Ford', 'Focus', 2018, 'Black', 2000, 'JJZ-7865');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(2, '1FTCR11T1JUD23467', 'Ford', 'Focus', 2018, 'White', 20,000, 'HVZ-1234');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(1, '1FAFP52U83A163390', 'Honda', 'Civic', 2017, 'Silver', 23756, 'VZA-1234');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(3, '1FDEE14N9MHA80517', 'Honda', 'Fit', 2017, 'White', 12000, 'AZV-5432');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(3, '3VWPD69M51M113790', 'Honda', 'CR-V', 2018, 'Grey', 2300, 'VHA-2030');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(4, '1GTEK14H8DJ565795', 'Tesla', 'Model 3', 2018, 'Black', 2300, 'VHA-2030');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(4, 'JW6AJC1H7RL081260', 'Tesla', 'Model X', 2018, 'Silver', 1200, 'GHZ-2015');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(4, '5TBJN321XYS072757', 'Subaru', 'Impreza', 2017, 'Silver', 14000, 'DCA-1222');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(2, '1GYS4EEJ0CR116546', 'Volkswagen', 'Golf', 2018, 'Black', 0, 'FVA-6798');

insert into vehicle(vin, lot_d, make, model, year, color, mileage, license_plate_number)
    values(1, '1G1ZB5E18BF215943', 'Volkswagen', 'Golf', 2018, 'White', 0, 'GHZ-1030');




    















