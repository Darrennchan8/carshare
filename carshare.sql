create table TRIP_DETAILS (reservation decimal PRIMARY KEY, reservationStart decimal, reservationEnd decimal, actualStart decimal, actualEnd decimal, rate decimal);

create table account(email varchar(50) PRIMARY KEY, passHash varchar(100), FirstName varchar (20), LastName varchar(50), address varchar(60), city char(40), state char(40), zipCode decimal, phoneNum decimal, creationDate bigint);
