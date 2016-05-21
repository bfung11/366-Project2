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
   PRIMARY KEY (floor_num, room_num),
   floor_num INTEGER NOT NULL,
   room_num INTEGER NOT NULL,
   view_type TEXT NOT NULL,
   room_type TEXT NOT NULL
);

CREATE TABLE room_prices (
   PRIMARY KEY (floor_num, room_num, start_date),
   floor_num  INTEGER,
   room_num   INTEGER,
   start_date DATE,
   end_date   DATE NOT NULL,
   price      INTEGER NOT NULL,
              FOREIGN KEY (floor_num, room_num) REFERENCES rooms(floor_num, room_num),
              CONSTRAINT positive_price CHECK (price > 0)
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
                CONSTRAINT positive_price CHECK (price > 0)
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
                  FOREIGN KEY (floor_num, room_num) REFERENCES rooms(floor_num, room_num)
);

CREATE TABLE bills (
   PRIMARY KEY (reservation_id),
   reservation_id INTEGER,
   total          INTEGER,
   description    TEXT,
                  FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
                  CONSTRAINT positive_total CHECK (total > 0)
);






