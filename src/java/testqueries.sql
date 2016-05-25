--This file contains queries to test the query 
--Create new employee account queries
INSERT INTO authentications 
VALUES
   ('s1', 's1');

INSERT INTO staff 
VALUES 
   ('s1', 'Darth', 'Vader');

--Create new customer account queries
INSERT INTO authentications 
VALUES
   ('c1', 'c1');

INSERT INTO credit_cards
VALUES
   (123, 4, '2020-01-01');

INSERT INTO customers 
VALUES 
   ('c1', 'Luke', 'Skywalker', 'jedi@gmail.com', '1 Tatooine Way', 123);

--Create new resevation, checkin/out dates are null
--Also create bill for reservation
INSERT INTO reservations
VALUES
   (DEFAULT, 'c1', 1, 101, '2016-01-01', '2016-01-05', NULL, NULL);

--Initialize bill using reservation id from previous insert 
--(use return generated keys)
INSERT INTO bills
VALUES
   (1, 0, 'List of Services Ordered');

--Check-in customer given reservation id
UPDATE reservations
SET check_in_date = '2016-01-01'
WHERE reservation_id = 1;

--Check out customer given reservation id
UPDATE reservations
SET check_out_date = '2016-01-03'
WHERE reservation_id = 1;

--Change admin password (done twice to change it back to admin)
UPDATE authentications
SET password = 'secret'
WHERE username = 'admin';

UPDATE authentications
SET password = 'admin'
WHERE username = 'admin';

/* Update all room prices
 * 
 * Need to query if the new dates are already within pricing
 * range. On Java side, call updates to change date ranges
 * as needed.
 */

--Get date ranges of room prices
SELECT floor_num, room_num, start_date, end_date
FROM room_prices
WHERE start_date <= '2016-07-01'
AND end_date >= '2016-07-07';

--Update pricing range start date
UPDATE room_prices
SET start_date = '2016-02-01'
WHERE start_date = '2016-01-01';

--Update pricing range end date
UPDATE room_prices
SET end_date = '2016-12-30'
WHERE end_date = '2016-12-31';

--Update all room prices
UPDATE room_prices
SET start_date = '2016-07-01',
   end_date = '2016-07-07',
   price = 333;

--Update single room price
UPDATE room_prices
SET start_date = '2016-11-11',
   end_date = '2016-11-21',
   price = 999
WHERE room_num = 101;

--Select reservation in range
SELECT *
FROM reservations
WHERE start_date >= '2016-01-01'
AND end_date <= '2016-12-31';

--Select reservation by id
SELECT *
FROM reservations
WHERE reservation_id = 1;

--Set bill total
UPDATE bills
SET total = total + 10,
    description = description || E'\nTest charge - $10'
WHERE reservation_id = 1;

--Get total of bill
SELECT total
FROM bills
WHERE reservation_id = 1;

--Get description of bill (Get service list from this)
SELECT description
FROM bills
WHERE reservation_id = 1;

--Insert new price range
INSERT INTO room_prices
VALUES
   (DEFAULT, 1, 101, '2016-12-25', '2016-12-31', 300),
   (DEFAULT, 1, 101, '2016-12-27', '2016-12-31', 200),
   (DEFAULT, 1, 101, '2016-2-25', '2016-12-26', 100),
   (DEFAULT, 1, 101, '2016-12-25', '2016-12-25', 9999),
   (DEFAULT, 1, 101, '2016-12-24', '2016-12-25', 1000);

--Get maximum price of room on a day
SELECT max(price)
FROM room_prices
WHERE start_date <= '2016-12-24'
AND   end_date >= '2016-12-24'
AND   room_num = 101;
