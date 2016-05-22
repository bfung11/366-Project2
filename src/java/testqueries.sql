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
