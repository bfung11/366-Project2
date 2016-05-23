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
INSERT INTO reservations
VALUES
    (DEFAULT, 'c1', 1, 101, '2016-01-01', '2016-01-05', NULL, NULL);

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

--Initialize room prices
INSERT INTO room_prices
VALUES
    (1, 101, '2016-01-01', '2016-12-31', 100),
    (1, 102, '2016-01-01', '2016-12-31', 100),
    (1, 103, '2016-01-01', '2016-12-31', 100),
    (1, 104, '2016-01-01', '2016-12-31', 100),
    (1, 105, '2016-01-01', '2016-12-31', 100),
    (1, 106, '2016-01-01', '2016-12-31', 100),
    (1, 107, '2016-01-01', '2016-12-31', 100),
    (1, 108, '2016-01-01', '2016-12-31', 100),
    (1, 109, '2016-01-01', '2016-12-31', 100),
    (1, 110, '2016-01-01', '2016-12-31', 100),
    (1, 111, '2016-01-01', '2016-12-31', 100),
    (1, 112, '2016-01-01', '2016-12-31', 100),

    (2, 201, '2016-01-01', '2016-12-31', 100),
    (2, 202, '2016-01-01', '2016-12-31', 100),
    (2, 203, '2016-01-01', '2016-12-31', 100),
    (2, 204, '2016-01-01', '2016-12-31', 100),
    (2, 205, '2016-01-01', '2016-12-31', 100),
    (2, 206, '2016-01-01', '2016-12-31', 100),
    (2, 207, '2016-01-01', '2016-12-31', 100),
    (2, 208, '2016-01-01', '2016-12-31', 100),
    (2, 209, '2016-01-01', '2016-12-31', 100),
    (2, 210, '2016-01-01', '2016-12-31', 100),
    (2, 211, '2016-01-01', '2016-12-31', 100),
    (2, 212, '2016-01-01', '2016-12-31', 100),

    (3, 301, '2016-01-01', '2016-12-31', 100),
    (3, 302, '2016-01-01', '2016-12-31', 100),
    (3, 303, '2016-01-01', '2016-12-31', 100),
    (3, 304, '2016-01-01', '2016-12-31', 100),
    (3, 305, '2016-01-01', '2016-12-31', 100),
    (3, 306, '2016-01-01', '2016-12-31', 100),
    (3, 307, '2016-01-01', '2016-12-31', 100),
    (3, 308, '2016-01-01', '2016-12-31', 100),
    (3, 309, '2016-01-01', '2016-12-31', 100),
    (3, 310, '2016-01-01', '2016-12-31', 100),
    (3, 311, '2016-01-01', '2016-12-31', 100),
    (3, 312, '2016-01-01', '2016-12-31', 100),

    (4, 401, '2016-01-01', '2016-12-31', 100),
    (4, 402, '2016-01-01', '2016-12-31', 100),
    (4, 403, '2016-01-01', '2016-12-31', 100),
    (4, 404, '2016-01-01', '2016-12-31', 100),
    (4, 405, '2016-01-01', '2016-12-31', 100),
    (4, 406, '2016-01-01', '2016-12-31', 100),
    (4, 407, '2016-01-01', '2016-12-31', 100),
    (4, 408, '2016-01-01', '2016-12-31', 100),
    (4, 409, '2016-01-01', '2016-12-31', 100),
    (4, 410, '2016-01-01', '2016-12-31', 100),
    (4, 411, '2016-01-01', '2016-12-31', 100),
    (4, 412, '2016-01-01', '2016-12-31', 100),

    (5, 501, '2016-01-01', '2016-12-31', 100),
    (5, 502, '2016-01-01', '2016-12-31', 100),
    (5, 503, '2016-01-01', '2016-12-31', 100),
    (5, 504, '2016-01-01', '2016-12-31', 100),
    (5, 505, '2016-01-01', '2016-12-31', 100),
    (5, 506, '2016-01-01', '2016-12-31', 100),
    (5, 507, '2016-01-01', '2016-12-31', 100),
    (5, 508, '2016-01-01', '2016-12-31', 100),
    (5, 509, '2016-01-01', '2016-12-31', 100),
    (5, 510, '2016-01-01', '2016-12-31', 100),
    (5, 511, '2016-01-01', '2016-12-31', 100),
    (5, 512, '2016-01-01', '2016-12-31', 100);

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