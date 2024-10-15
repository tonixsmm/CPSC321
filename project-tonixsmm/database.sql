DROP TABLE IF EXISTS UserFlight;
DROP TABLE IF EXISTS Arrival;
DROP TABLE IF EXISTS Departure;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Airline;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS User;


CREATE TABLE User (
    user_id VARCHAR(20) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE Country (
    country_code VARCHAR(2) NOT NULL,
    country_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (country_code)
);

CREATE TABLE Province (
    province_name VARCHAR(20) NOT NULL,
    country_code VARCHAR(2) NOT NULL,
    PRIMARY KEY (country_code, province_name),
    FOREIGN KEY (country_code) REFERENCES Country(country_code)
);

CREATE TABLE City (
    city_name VARCHAR(20) NOT NULL,
    province_name VARCHAR(20) NOT NULL,
    country_code VARCHAR(2) NOT NULL,
    PRIMARY KEY (country_code, province_name, city_name),
    FOREIGN KEY (country_code, province_name) REFERENCES Province(country_code, province_name)
);

CREATE TABLE Airport (
    airport_code VARCHAR(3) NOT NULL,
    airport_name VARCHAR(50) NOT NULL,
    elevation FLOAT NOT NULL,
    city_name VARCHAR(20) NOT NULL,
    province_name VARCHAR(20) NOT NULL,
    country_code VARCHAR(2) NOT NULL,
    PRIMARY KEY (airport_code),
    FOREIGN KEY (country_code, province_name, city_name) REFERENCES City(country_code, province_name, city_name)
);

CREATE TABLE Aircraft (
    registration VARCHAR(10) NOT NULL,
    aircraft_manufacturer VARCHAR(10) NOT NULL,
    aircraft_type VARCHAR(20) NOT NULL,
    air_range FLOAT NOT NULL,
    year_of_manufacture YEAR NOT NULL,
    PRIMARY KEY (registration)
);

CREATE TABLE Airline (
    airline_code VARCHAR(2) NOT NULL,
    airline_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (airline_code)
);

CREATE TABLE Flight (
    airline_code VARCHAR(2) NOT NULL,
    flight_number VARCHAR(5) NOT NULL,
    departure_airport_code VARCHAR(3) NOT NULL,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_airport_code VARCHAR(3) NOT NULL,
    arrival_date DATE NOT NULL,
    arrival_time TIME NOT NULL,
    miles FLOAT NOT NULL,
    aircraft_registration VARCHAR(10) NOT NULL,
    PRIMARY KEY (airline_code, flight_number, departure_date),
    FOREIGN KEY (airline_code) REFERENCES Airline(airline_code),
    FOREIGN KEY (departure_airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (arrival_airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (aircraft_registration) REFERENCES Aircraft(registration)
);

CREATE TABLE UserFlight (
    user_id VARCHAR(20) NOT NULL,
    airline_code VARCHAR(2) NOT NULL,
    flight_number VARCHAR(5) NOT NULL,
    departure_date DATE NOT NULL,
    seat_class VARCHAR(10) NOT NULL,
    seat_number VARCHAR(3) NOT NULL,
    PRIMARY KEY (user_id, airline_code, flight_number, departure_date),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (airline_code, flight_number, departure_date) REFERENCES Flight(airline_code, flight_number, departure_date)
);

INSERT INTO User VALUES 
    ('U001', 'John', 'Doe', 'johndoe@example.com'),
    ('U002', 'Jane', 'Smith', 'janesmith@example.com'),
    ('U003', 'Alice', 'Brown', 'alicebrown@example.com'),
    ('U004', 'Bob', 'Davis', 'bobdavis@example.com'),
    ('U005', 'Carol', 'Evans', 'carolevans@example.com');

INSERT INTO Country VALUES
    ('US', 'United States'),
    ('CA', 'Canada'),
    ('UK', 'United Kingdom'),
    ('AU', 'Australia'),
    ('FR', 'France'),
    ('DE', 'Germany'),
    ('AE', 'United Arab Emirates'),
    ('JP', 'Japan'),
    ('SG', 'Singapore'),
    ('HK', 'Hong Kong'),
    ('CN', 'China');

INSERT INTO Province VALUES 
    ('California', 'US'),
    ('Ontario', 'CA'),
    ('New South Wales', 'AU'),
    ('Queensland', 'AU'),
    ('Ile-de-France', 'FR'),
    ('Greater London', 'UK'),
    ('Hesse', 'DE'),
    ('Dubai', 'AE'),
    ('Illinois', 'US'),
    ('Florida', 'US'),
    ('Tokyo', 'JP'),
    ('Texas', 'US'),
    ('Georgia', 'US'),
    ('New York', 'US'),
    ('British Columbia', 'CA'),
    ('Bavaria', 'DE'),
    ('Singapore', 'SG'),
    ('Hong Kong', 'HK'),
    ('Beijing', 'CN');

INSERT INTO City VALUES 
    ('Los Angeles', 'California', 'US'),
    ('Toronto', 'Ontario', 'CA'),
    ('Sydney', 'New South Wales', 'AU'),
    ('Brisbane', 'Queensland', 'AU'),
    ('Paris', 'Ile-de-France', 'FR'),
    ('London', 'Greater London', 'UK'),
    ('Frankfurt', 'Hesse', 'DE'),
    ('Dubai', 'Dubai', 'AE'),
    ('Chicago', 'Illinois', 'US'),
    ('Miami', 'Florida', 'US'),
    ('Tokyo', 'Tokyo', 'JP'),
    ('Dallas', 'Texas', 'US'),
    ('Atlanta', 'Georgia', 'US'),
    ('New York', 'New York', 'US'),
    ('Vancouver', 'British Columbia', 'CA'),
    ('Munich', 'Bavaria', 'DE'),
    ('Singapore', 'Singapore', 'SG'),
    ('Hong Kong', 'Hong Kong', 'HK'),
    ('Beijing', 'Beijing', 'CN'),
    ('San Francisco', 'California', 'US');

INSERT INTO Airport VALUES 
    ('LAX', 'Los Angeles International', 125.0, 'Los Angeles', 'California', 'US'),
    ('YYZ', 'Toronto Pearson International', 173.0, 'Toronto', 'Ontario', 'CA'),
    ('SYD', 'Sydney Airport', 21.0, 'Sydney', 'New South Wales', 'AU'),
    ('BNE', 'Brisbane Airport', 4.0, 'Brisbane', 'Queensland', 'AU'),
    ('CDG', 'Charles de Gaulle Airport', 119.0, 'Paris', 'Ile-de-France', 'FR'),
    ('LHR', 'Heathrow Airport', 25.0, 'London', 'Greater London', 'UK'),
    ('FRA', 'Frankfurt Airport', 364.0, 'Frankfurt', 'Hesse', 'DE'),
    ('DXB', 'Dubai International Airport', 62.0, 'Dubai', 'Dubai', 'AE'),
    ('ORD', 'OHare International Airport', 672.0, 'Chicago', 'Illinois', 'US'),
    ('MIA', 'Miami International Airport', 8.0, 'Miami', 'Florida', 'US'),
    ('NRT', 'Narita International Airport', 41.0, 'Tokyo', 'Tokyo', 'JP'),
    ('DFW', 'Dallas/Fort Worth International Airport', 607.0, 'Dallas', 'Texas', 'US'),
    ('ATL', 'Hartsfield-Jackson Atlanta International Airport', 1026.0, 'Atlanta', 'Georgia', 'US'),
    ('JFK', 'John F. Kennedy International Airport', 13.0, 'New York', 'New York', 'US'),
    ('YVR', 'Vancouver International Airport', 14.0, 'Vancouver', 'British Columbia', 'CA'),
    ('MUC', 'Munich Airport', 1487.0, 'Munich', 'Bavaria', 'DE'),
    ('SIN', 'Singapore Changi Airport', 22.0, 'Singapore', 'Singapore', 'SG'),
    ('HKG', 'Hong Kong International Airport', 28.0, 'Hong Kong', 'Hong Kong', 'HK'),
    ('PEK', 'Beijing Capital International Airport', 115.0, 'Beijing', 'Beijing', 'CN'),
    ('LGA', 'LaGuardia Airport', 21.0, 'New York', 'New York', 'US'),
    ('SFO', 'San Francisco International Airport', 13.0, 'San Francisco', 'California', 'US');

INSERT INTO Airline VALUES 
    ('AA', 'American Airlines'),
    ('AC', 'Air Canada'),
    ('QF', 'Qantas'),
    ('AF', 'Air France'),
    ('BA', 'British Airways'),
    ('LH', 'Lufthansa'),
    ('EK', 'Emirates'),
    ('UA', 'United Airlines'),
    ('SQ', 'Singapore Airlines'),
    ('DL', 'Delta Airlines');

INSERT INTO Aircraft VALUES 
    ('G123XY', 'Boeing', '737', 3000.0, 2010),
    ('VH789Z', 'Airbus', 'A320', 6100.0, 2012),
    ('D567GH', 'Boeing', '787', 7400.0, 2015),
    ('F123KL', 'Airbus', 'A380', 8000.0, 2017),
    ('A654DF', 'Boeing', '777', 7400.0, 2014),
    ('N321JK', 'Boeing', '737', 3000.0, 2010),
    ('S456RT', 'Airbus', 'A320', 6100.0, 2012),
    ('N789XY', 'Boeing', '787', 7400.0, 2015),
    ('N456BC', 'Airbus', 'A380', 8000.0, 2017),
    ('C789DE', 'Boeing', '777', 7400.0, 2014);

INSERT INTO Flight VALUES 
    ('BA', '1123', 'LHR', '2023-01-15', '10:30:00', 'JFK', '2023-01-15', '13:45:00', 3456.0, 'G123XY'),
    ('QF', '4567', 'SYD', '2023-02-20', '21:00:00', 'LAX', '2023-02-21', '06:30:00', 7491.0, 'VH789Z'),
    ('LH', '8890', 'FRA', '2023-03-10', '08:15:00', 'DXB', '2023-03-10', '16:45:00', 3020.0, 'D567GH'),
    ('AF', '2378', 'CDG', '2023-04-18', '07:00:00', 'SFO', '2023-04-18', '10:00:00', 5570.0, 'F123KL'),
    ('EK', '5432', 'DXB', '2023-05-25', '14:45:00', 'LHR', '2023-05-25', '18:30:00', 3400.0, 'A654DF'),
    ('UA', '6789', 'ORD', '2023-06-30', '09:30:00', 'MIA', '2023-06-30', '13:00:00', 1197.0, 'N321JK'),
    ('SQ', '3210', 'SIN', '2023-07-12', '23:00:00', 'NRT', '2023-07-13', '05:30:00', 3330.0, 'S456RT'),
    ('AA', '1470', 'DFW', '2023-08-08', '17:15:00', 'LAX', '2023-08-08', '18:45:00', 1235.0, 'N789XY'),
    ('DL', '2901', 'ATL', '2023-09-17', '11:00:00', 'JFK', '2023-09-17', '13:30:00', 760.0, 'N456BC'),
    ('AC', '8804', 'YYZ', '2023-10-26', '06:45:00', 'YVR', '2023-10-26', '08:35:00', 2087.0, 'C789DE');

INSERT INTO UserFlight VALUES 
    ('U001', 'BA', '1123', '2023-01-15', 'Economy', '41A'),
    ('U001', 'QF', '4567', '2023-02-20', 'Business', '2B'),
    ('U001', 'LH', '8890', '2023-03-10', 'Economy', '3C'),
    ('U001', 'AF', '2378', '2023-04-18', 'First', '4D'),
    ('U001', 'EK', '5432', '2023-05-25', 'Economy', '5E'),
    ('U001', 'UA', '6789', '2023-06-30', 'First', '1A'),
    ('U001', 'SQ', '3210', '2023-07-12', 'Economy', '2B'),
    ('U001', 'AA', '1470', '2023-08-08', 'Business', '3C'),
    ('U001', 'DL', '2901', '2023-09-17', 'Economy', '4D'),
    ('U001', 'AC', '8804', '2023-10-26', 'Economy', '5E');
