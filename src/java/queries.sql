--This file contains queries to put in the Java code
--Java-specified parameters are contained in <>

--Create new employee account queries
INSERT INTO authentications 
VALUES
    (<username>, <password>);

INSERT INTO staff 
VALUES 
    (<username>, <first_name>, <last_name>);

--Create new customer account queries
INSERT INTO authentications 
VALUES
    (<username>, <password>);

INSERT INTO credit_cards
VALUES
    (<cc_num>, <crc_num>, <exp_date>);

INSERT INTO customers 
VALUES 
    (<username>, <first_name>, <last_name>);

INSERT INTO customers 
VALUES 
    (<username>, <first_name>, <last_name>, <email>, <address>, <cc_num>);

--Create new resevation
INSERT INTO reservations
VALUES
    (DEFAULT, <username>, <floor_num>, <room_num>, <start_date>, 
        <end_date>, <check_in_date>, <check_out_date>);

--Check-in customer given reservation id
UPDATE reservations
SET check_in_date = <date>
WHERE reservation_id = <id>;

--Check out customer given reservation id
UPDATE reservations
SET check_out_date = <date>
WHERE reservation_id = <id>;

--Change admin password 
UPDATE authentications
SET password = <new_password>
WHERE username = 'admin';

