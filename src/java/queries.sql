--This file contains queries to put in the Java code
--Java-specified parameters are contained in <>

-------------------------------------------------------------------------------|
--ADMIN QUERIES----------------------------------------------------------------|
-------------------------------------------------------------------------------|

--------------------------------------------------------------------------------
--Create new employee account queries-------------------------------------------
INSERT INTO authentications 
VALUES
   ('<username>', '<password>');

INSERT INTO staff 
VALUES 
   ('<username>', '<first_name>', '<last_name>');
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
/* Update all room prices queries
 * 
 * Need to query if the new dates are already within pricing
 * range. On Java side, call updates to change date ranges
 * as needed.
 */

--Get date ranges of room prices
SELECT floor_num, room_num, start_date, end_date
FROM room_prices
WHERE start_date <= '<startDate>'
AND end_date >= '<endDate>';

--Update pricing range start date
UPDATE room_prices
SET start_date = '<newStartDate>'
WHERE start_date = '<oldStartDate>';

--Update pricing range end date
UPDATE room_prices
SET end_date = '<newEndDate>'
WHERE end_date = '<oldEndDate>';

--Update all room prices
UPDATE room_prices
SET start_date = '<startDate>',
   end_date = '<endDate>',
   price = <price>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Update single room price
UPDATE room_prices
SET start_date = '<startDate>',
   end_date = '<endDate>',
   price = <price>
WHERE room_num = <room_num>;
--------------------------------------------------------------------------------

-------------------------------------------------------------------------------|
--CUSTOMER QUERIES-------------------------------------------------------------|
-------------------------------------------------------------------------------|

--------------------------------------------------------------------------------
--Create new customer account queries
INSERT INTO authentications 
VALUES
   ('<username>', '<password>');

INSERT INTO credit_cards
VALUES
   (<cc_num>, <crc_num>, '<exp_date>');

INSERT INTO customers 
VALUES 
   ('<username>', '<first_name>', '<last_name>', '<email>', '<address>', 
      <cc_num>);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Create new resevation
--Also create bill for reservation
INSERT INTO reservations
VALUES
   (DEFAULT, '<username>', <floor_num>, <room_num>, '<start_date>', 
      '<end_date>', '<check_in_date>', '<check_out_date>');

--Initialize bill using reservation id from previous insert 
--(use return generated keys)
INSERT INTO bills
VALUES
   (<reservation_id>, 0, 'List of Services Ordered');
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Select reservation in range
SELECT *
FROM reservations
WHERE start_date >= '<start_date>'
AND end_date <= '<end_date>';
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Select reservation by id
SELECT *
FROM reservations
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Delete reservation by id
--Have to delete bill associated with reservation first
DELETE FROM bills
WHERE reservation_id = <id>;

DELETE FROM reservations
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-------------------------------------------------------------------------------|
--STAFF QUERIES----------------------------------------------------------------|
-------------------------------------------------------------------------------|

--------------------------------------------------------------------------------
--Check-in customer given reservation id
UPDATE reservations
SET check_in_date = '<date>'
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Check out customer given reservation id
UPDATE reservations
SET check_out_date = '<date>'
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Gets date range and room number of a reservation
--Used to calculate price per day
SELECT start_date, end_date, room_num
FROM reservations
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Get maximum price of room on a day
--Want to add this to bill as you calculate it
SELECT max(price)
FROM room_prices
WHERE start_date <= '<date>'
AND   end_date >= '<date>'
AND   room_num = <room_num>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Get price of service from name
SELECT max(price)
FROM service_prices
WHERE service_name = '<name>'
AND   start_date <= '<date>'
AND   end_date >= '<date>';
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Add service price to bill
--Description string format example: 'Wifi - $15'
UPDATE bills
SET total = total + <amt_to_add>,
    description = description || E'\n<service_name - $price>'
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Add room charge to bill
UPDATE bills
SET total = total + <amt_to_add>
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Get total of bill
SELECT total
FROM bills
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Get description of bill (Get service list from this)
SELECT description
FROM bills
WHERE reservation_id = <id>;
--------------------------------------------------------------------------------
