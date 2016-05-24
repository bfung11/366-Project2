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
   password TEXT NOT NULL
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
   PRIMARY KEY (room_num, start_date),
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
   PRIMARY KEY (service_name),
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
   PRIMARY KEY (reservation_id),
   reservation_id INTEGER,
   total          INTEGER,
   description    TEXT,
                  FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
                  CONSTRAINT positive_total CHECK (total >= 0)
);

--Initialize rooms table
INSERT INTO rooms 
VALUES
   (1, 101, 'Ocean View', 'Single King'),
   (1, 102, 'Ocean View', 'Double Queen'),
   (1, 103, 'Ocean View', 'Single King'),
   (1, 104, 'Ocean View', 'Double Queen'),
   (1, 105, 'Ocean View', 'Single King'),
   (1, 106, 'Ocean View', 'Double Queen'),
   (1, 107, 'Pool View', 'Single King'),
   (1, 108, 'Pool View', 'Double Queen'),
   (1, 109, 'Pool View', 'Single King'),
   (1, 110, 'Pool View', 'Double Queen'),
   (1, 111, 'Pool View', 'Single King'),
   (1, 112, 'Pool View', 'Double Queen'),

   (2, 201, 'Ocean View', 'Single King'),
   (2, 202, 'Ocean View', 'Double Queen'),
   (2, 203, 'Ocean View', 'Single King'),
   (2, 204, 'Ocean View', 'Double Queen'),
   (2, 205, 'Ocean View', 'Single King'),
   (2, 206, 'Ocean View', 'Double Queen'),
   (2, 207, 'Pool View', 'Single King'),
   (2, 208, 'Pool View', 'Double Queen'),
   (2, 209, 'Pool View', 'Single King'),
   (2, 210, 'Pool View', 'Double Queen'),
   (2, 211, 'Pool View', 'Single King'),
   (2, 212, 'Pool View', 'Double Queen'),

   (3, 301, 'Ocean View', 'Single King'),
   (3, 302, 'Ocean View', 'Double Queen'),
   (3, 303, 'Ocean View', 'Single King'),
   (3, 304, 'Ocean View', 'Double Queen'),
   (3, 305, 'Ocean View', 'Single King'),
   (3, 306, 'Ocean View', 'Double Queen'),
   (3, 307, 'Pool View', 'Single King'),
   (3, 308, 'Pool View', 'Double Queen'),
   (3, 309, 'Pool View', 'Single King'),
   (3, 310, 'Pool View', 'Double Queen'),
   (3, 311, 'Pool View', 'Single King'),
   (3, 312, 'Pool View', 'Double Queen'),

   (4, 401, 'Ocean View', 'Single King'),
   (4, 402, 'Ocean View', 'Double Queen'),
   (4, 403, 'Ocean View', 'Single King'),
   (4, 404, 'Ocean View', 'Double Queen'),
   (4, 405, 'Ocean View', 'Single King'),
   (4, 406, 'Ocean View', 'Double Queen'),
   (4, 407, 'Pool View', 'Single King'),
   (4, 408, 'Pool View', 'Double Queen'),
   (4, 409, 'Pool View', 'Single King'),
   (4, 410, 'Pool View', 'Double Queen'),
   (4, 411, 'Pool View', 'Single King'),
   (4, 412, 'Pool View', 'Double Queen'),

   (5, 501, 'Ocean View', 'Single King'),
   (5, 502, 'Ocean View', 'Double Queen'),
   (5, 503, 'Ocean View', 'Single King'),
   (5, 504, 'Ocean View', 'Double Queen'),
   (5, 505, 'Ocean View', 'Single King'),
   (5, 506, 'Ocean View', 'Double Queen'),
   (5, 507, 'Pool View', 'Single King'),
   (5, 508, 'Pool View', 'Double Queen'),
   (5, 509, 'Pool View', 'Single King'),
   (5, 510, 'Pool View', 'Double Queen'),
   (5, 511, 'Pool View', 'Single King'),
   (5, 512, 'Pool View', 'Double Queen');

--Default add admin
INSERT INTO authentications
VALUES
   ('admin', 'admin');

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




