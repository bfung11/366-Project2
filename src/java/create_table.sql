DROP TABLE IF EXISTS authentications CASCADE;
DROP TABLE IF EXISTS credit_cards CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
DROP TABLE IF EXISTS rooms CASCADE;
DROP TABLE IF EXISTS room_prices CASCADE;
DROP TABLE IF EXISTS services CASCADE;
DROP TABLE IF EXISTS service_prices CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS bills CASCADE;

CREATE TABLE authentications (
   PRIMARY KEY (username),
   username TEXT,
   password TEXT NOT NULL,
   user_type TEXT NOT NULL
);

CREATE TABLE credit_cards (
   PRIMARY KEY (credit_card_num),
   credit_card_num INTEGER,
   CRC_code        INTEGER NOT NULL,
   expiration_date DATE NOT NULL
);

CREATE TABLE customers (
   PRIMARY KEY (username),
   username    TEXT,
   first_name  TEXT NOT NULL,
   last_name   TEXT NOT NULL,
   email       TEXT NOT NULL,
   address     TEXT NOT NULL,
   credit_card INTEGER NOT NULL,
               FOREIGN KEY (username) REFERENCES authentications(username),
               FOREIGN KEY (credit_card) REFERENCES credit_cards(credit_card_num)
);

CREATE TABLE staff (
   PRIMARY KEY (username),
   username   TEXT,
   first_name TEXT NOT NULL,
   last_name  TEXT NOT NULL,
              FOREIGN KEY (username) REFERENCES authentications(username)
);

CREATE TABLE rooms (
   PRIMARY KEY (room_num),
   floor_num INTEGER NOT NULL,
   room_num INTEGER NOT NULL,
   view_type TEXT NOT NULL,
   room_type TEXT NOT NULL
);

CREATE TABLE room_prices (
   PRIMARY KEY (id),
   id         SERIAL,
   floor_num  INTEGER,
   room_num   INTEGER,
   start_date DATE,
   end_date   DATE NOT NULL,
   price      INTEGER NOT NULL,
              FOREIGN KEY (room_num) REFERENCES rooms(room_num),
              CONSTRAINT positive_price CHECK (price >= 0)
);

CREATE TABLE services (
   PRIMARY KEY (service_name),
   service_name  TEXT
);

CREATE TABLE service_prices (
   PRIMARY KEY (id),
   id           SERIAL,
   service_name TEXT,
   start_date   DATE NOT NULL,
   end_date     DATE NOT NULL,
   price        INTEGER NOT NULL,
                FOREIGN KEY (service_name) REFERENCES services(service_name),
                CONSTRAINT positive_price CHECK (price >= 0)
);

CREATE TABLE reservations (
   PRIMARY KEY (reservation_id),
   reservation_id SERIAL,
   username       TEXT NOT NULL,
   floor_num      INTEGER NOT NULL,  
   room_num       INTEGER NOT NULL, 
   start_date     DATE NOT NULL,
   end_date       DATE NOT NULL,
   check_in_date  DATE,
   check_out_date DATE,
                  FOREIGN KEY (username) REFERENCES authentications(username),
                  FOREIGN KEY (room_num) REFERENCES rooms(room_num)
);

CREATE TABLE bills (
   PRIMARY KEY (id),
   id             SERIAL,
   reservation_id INTEGER,
   bill_date      DATE,
   price          INTEGER,
   description    TEXT,
                  FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
                  CONSTRAINT positive_total CHECK (price >= 0)
);

--Initialize rooms table
INSERT INTO rooms 
VALUES
   (1, 101, 'ocean', 'single king'),
   (1, 102, 'ocean', 'double queen'),
   (1, 103, 'ocean', 'single king'),
   (1, 104, 'ocean', 'double queen'),
   (1, 105, 'ocean', 'single king'),
   (1, 106, 'ocean', 'double queen'),
   (1, 107, 'pool', 'single king'),
   (1, 108, 'pool', 'double queen'),
   (1, 109, 'pool', 'single king'),
   (1, 110, 'pool', 'double queen'),
   (1, 111, 'pool', 'single king'),
   (1, 112, 'pool', 'double queen'),

   (2, 201, 'ocean', 'single king'),
   (2, 202, 'ocean', 'double queen'),
   (2, 203, 'ocean', 'single king'),
   (2, 204, 'ocean', 'double queen'),
   (2, 205, 'ocean', 'single king'),
   (2, 206, 'ocean', 'double queen'),
   (2, 207, 'pool', 'single king'),
   (2, 208, 'pool', 'double queen'),
   (2, 209, 'pool', 'single king'),
   (2, 210, 'pool', 'double queen'),
   (2, 211, 'pool', 'single king'),
   (2, 212, 'pool', 'double queen'),

   (3, 301, 'ocean', 'single king'),
   (3, 302, 'ocean', 'double queen'),
   (3, 303, 'ocean', 'single king'),
   (3, 304, 'ocean', 'double queen'),
   (3, 305, 'ocean', 'single king'),
   (3, 306, 'ocean', 'double queen'),
   (3, 307, 'pool', 'single king'),
   (3, 308, 'pool', 'double queen'),
   (3, 309, 'pool', 'single king'),
   (3, 310, 'pool', 'double queen'),
   (3, 311, 'pool', 'single king'),
   (3, 312, 'pool', 'double queen'),

   (4, 401, 'ocean', 'single king'),
   (4, 402, 'ocean', 'double queen'),
   (4, 403, 'ocean', 'single king'),
   (4, 404, 'ocean', 'double queen'),
   (4, 405, 'ocean', 'single king'),
   (4, 406, 'ocean', 'double queen'),
   (4, 407, 'pool', 'single king'),
   (4, 408, 'pool', 'double queen'),
   (4, 409, 'pool', 'single king'),
   (4, 410, 'pool', 'double queen'),
   (4, 411, 'pool', 'single king'),
   (4, 412, 'pool', 'double queen'),

   (5, 501, 'ocean', 'single king'),
   (5, 502, 'ocean', 'double queen'),
   (5, 503, 'ocean', 'single king'),
   (5, 504, 'ocean', 'double queen'),
   (5, 505, 'ocean', 'single king'),
   (5, 506, 'ocean', 'double queen'),
   (5, 507, 'pool', 'single king'),
   (5, 508, 'pool', 'double queen'),
   (5, 509, 'pool', 'single king'),
   (5, 510, 'pool', 'double queen'),
   (5, 511, 'pool', 'single king'),
   (5, 512, 'pool', 'double queen');

--Default add admin
INSERT INTO authentications
VALUES ('admin', 'admin', 'admin'),
       ('customer', 'customer', 'customer'),
       ('staff', 'staff', 'staff');

--Initialize room prices
INSERT INTO room_prices (floor_num, 
                         room_num, 
                         start_date,
                         end_date,
                         price)
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

--Initialize some services and their prices
INSERT INTO services
VALUES
   ('Wifi'), ('Room Service'), ('Food Service'), ('Cleaning Service');

INSERT INTO service_prices
VALUES
   (DEFAULT, 'Wifi', '2016-01-01', '2016-12-31', 15), 
   (DEFAULT, 'Room Service', '2016-01-01', '2016-12-31', 20), 
   (DEFAULT, 'Food Service', '2016-01-01', '2016-12-31', 30), 
   (DEFAULT, 'Cleaning Service', '2016-01-01', '2016-12-31', 10);

INSERT INTO reservations
VALUES (DEFAULT, 'customer', 1, 101, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 102, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 103, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 104, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 105, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 106, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 107, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 108, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 109, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 110, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 111, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 1, 112, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 202, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 202, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 203, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 204, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 205, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 206, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 207, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 208, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 209, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 210, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 211, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 2, 212, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 302, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 302, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 303, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 304, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 305, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 306, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 307, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 308, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 309, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 310, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 311, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 3, 312, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 402, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 402, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 403, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 404, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 405, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 406, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 407, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 408, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 409, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 410, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 411, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 4, 412, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 502, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 502, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 503, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 504, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 505, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 506, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 507, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 508, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 509, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 510, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 511, '2016-12-01', '2016-12-31', NULL, NULL),
       (DEFAULT, 'customer', 5, 512, '2016-12-01', '2016-12-31', NULL, NULL);

INSERT INTO bills
VALUES 
   (DEFAULT, 1, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 2, '2016-12-06', 15, 'Wifi'),
   (DEFAULT, 2, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 3, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 4, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 5, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 6, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 7, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 8, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 9, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 10, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 11, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 12, '2016-12-05', 15, 'Wifi'),

   (DEFAULT, 13, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 14, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 15, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 16, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 17, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 18, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 19, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 20, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 21, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 22, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 23, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 24, '2016-12-05', 15, 'Wifi'),

   (DEFAULT, 25, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 26, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 27, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 28, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 29, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 30, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 31, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 32, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 33, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 34, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 35, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 36, '2016-12-05', 15, 'Wifi'),

   (DEFAULT, 37, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 38, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 39, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 40, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 41, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 42, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 43, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 44, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 45, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 46, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 47, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 48, '2016-12-05', 15, 'Wifi'),

   (DEFAULT, 49, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 50, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 51, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 52, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 53, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 54, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 55, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 56, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 57, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 58, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 59, '2016-12-05', 15, 'Wifi'),
   (DEFAULT, 60, '2016-12-05', 15, 'Wifi');
 








