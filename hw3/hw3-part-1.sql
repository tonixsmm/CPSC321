
/**********************************************************************
 * NAME: Tony Nguyen
 * CLASS: CPSC 321 01
 * DATE: 10/03/2023
 * HOMEWORK: 3
 * DESCRIPTION: This SQL code exercises the requirements of HW3.
 * OBSERVATION: I don't have any challenges with this assignment.
 **********************************************************************/


-- Drop table statements
DROP TABLE IF EXISTS Border;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS Country;


-- Create table statements
CREATE TABLE Country (
    country_code VARCHAR(2) NOT NULL,
    country_name TINYTEXT,
    gdp_per_capita INT UNSIGNED,
    inflation FLOAT,
    PRIMARY KEY (country_code)
);


CREATE TABLE Province (
    province_name VARCHAR(50),
    country_code VARCHAR(2),
    area FLOAT UNSIGNED,
    PRIMARY KEY (province_name, country_code),
    FOREIGN KEY (country_code) REFERENCES Country (country_code)
);


CREATE TABLE City (
    city_name VARCHAR(50),
    province_name VARCHAR(50),
    country VARCHAR(2),
    population INT UNSIGNED,
    PRIMARY KEY (city_name, province_name, country),
    FOREIGN KEY (province_name, country) REFERENCES Province (province_name, country_code)
);


CREATE TABLE Border (
    country_code1 VARCHAR(2),
    country_code2 VARCHAR(2),
    border_length FLOAT UNSIGNED,
    PRIMARY KEY (country_code1, country_code2),
    FOREIGN KEY (country_code1) REFERENCES Country (country_code),
    FOREIGN KEY (country_code2) REFERENCES Country (country_code)
);


-- Add insert statements
INSERT INTO Country VALUES
    ('US', 'United States of America', 72749, 350000000),
    ('CA', 'Canada', 48374, 38000000),
    ('MX', 'Mexico', 9000, 130000000),
    ('DE', 'Germany', 47603, 83000000),
    ('FR', 'France', 43551, 67000000),
    ('NL', 'Netherlands', 53000, 17000000),
    ('CN', 'China', 10200, 1400000000),
    ('KH', 'Cambodia', 1600, 16000000),
    ('VN', 'Vietnam', 2566, 97000000);



INSERT INTO Province VALUES
    ('Washington', 'US', 184827),
    ('California', 'US', 163696),
    ('Virginia', 'US', 110787),
    ('Texas', 'US', 695662),
    ('British Columbia', 'CA', 944735),
    ('Ontario', 'CA', 415598),
    ('Quebec', 'CA', 514255),
    ('Alberta', 'CA', 661848),
    ('Mexico City', 'MX', 1485),
    ('Jalisco', 'MX', 78599),
    ('Nuevo Leon', 'MX', 64219),
    ('Mexico', 'MX', 22350),
    ('Beijing', 'CN', 16808),
    ('Shanghai', 'CN', 6341),
    ('Guangdong', 'CN', 179800),
    ('Zhejiang', 'CN', 101800),
    ('Phnom Penh', 'KH', 67846),
    ('Kandal', 'KH', 3568),
    ('Siem Reap', 'KH', 10489),
    ('Banteay Meanchey', 'KH', 6672),
    ('Bavaria', 'DE', 70550),
    ('Hesse', 'DE', 21115),
    ('Baden-Wurttemberg', 'DE', 35751),
    ('Nordrhein-Westfalen', 'DE', 34085),
    ('Île-de-France', 'FR', 12011),
    ('Nouvelle-Aquitaine', 'FR', 84463),
    ('Auvergne-Rhône-Alpes', 'FR', 69898),
    ('Occitanie', 'FR', 72434),
    ('North Holland', 'NL', 41543),
    ('South Holland', 'NL', 31732),
    ('North Brabant', 'NL', 5079),
    ('Gelderland', 'NL', 5132),
    ('Khanh Hoa', 'VN', 5207),
    ('Ba Ria-Vung Tau', 'VN', 1989),
    ('Ho Chi Minh City', 'VN', 4715),
    ('Hanoi', 'VN', 2168);


INSERT INTO City VALUES
    ('Seattle', 'Washington', 'US', 744955),
    ('Spokane', 'Washington', 'US', 222081),
    ('Tacoma', 'Washington', 'US', 213418),
    ('Vancouver', 'Washington', 'US', 184463),
    ('Los Angeles', 'California', 'US', 3979576),
    ('San Francisco', 'California', 'US', 883305),
    ('San Diego', 'California', 'US', 1425976),
    ('San Jose', 'California', 'US', 1021795),
    ('Richmond', 'Virginia', 'US', 230436),
    ('Norfolk', 'Virginia', 'US', 242742),
    ('Alexandria', 'Virginia', 'US', 159428),
    ('Fairfax', 'Virginia', 'US', 24019),
    ('Houston', 'Texas', 'US', 2325502),
    ('Dallas', 'Texas', 'US', 1345047),
    ('Austin', 'Texas', 'US', 978908),
    ('San Antonio', 'Texas', 'US', 1532233),
    ('Vancouver', 'British Columbia', 'CA', 675218),
    ('Victoria', 'British Columbia', 'CA', 344615),
    ('Surrey', 'British Columbia', 'CA', 570000),
    ('Burnaby', 'British Columbia', 'CA', 249197),
    ('Toronto', 'Ontario', 'CA', 2930000),
    ('Ottawa', 'Ontario', 'CA', 934243),
    ('Mississauga', 'Ontario', 'CA', 721599),
    ('Hamilton', 'Ontario', 'CA', 536917),
    ('Montreal', 'Quebec', 'CA', 1704694),
    ('Quebec City', 'Quebec', 'CA', 531902),
    ('Laval', 'Quebec', 'CA', 422993),
    ('Gatineau', 'Quebec', 'CA', 276245),
    ('Calgary', 'Alberta', 'CA', 1237656),
    ('Edmonton', 'Alberta', 'CA', 981280),
    ('Red Deer', 'Alberta', 'CA', 100418),
    ('Lethbridge', 'Alberta', 'CA', 101482),
    ('Munich', 'Bavaria', 'DE', 1471508),
    ('Nuremburg', 'Bavaria', 'DE', 518365),
    ('Augsburg', 'Bavaria', 'DE', 295135),
    ('Regensburg', 'Bavaria', 'DE', 153094),
    ('Frankfurt', 'Hesse', 'DE', 753056),
    ('Wiesbaden', 'Hesse', 'DE', 278342),
    ('Kassel', 'Hesse', 'DE', 200507),
    ('Darmstadt', 'Hesse', 'DE', 159207),
    ('Stuttgart', 'Baden-Wurttemberg', 'DE', 634830),
    ('Mannheim', 'Baden-Wurttemberg', 'DE', 309370),
    ('Karlsruhe', 'Baden-Wurttemberg', 'DE', 313092),
    ('Freiburg', 'Baden-Wurttemberg', 'DE', 229144),
    ('Dusseldorf', 'Nordrhein-Westfalen', 'DE', 619294),
    ('Cologne', 'Nordrhein-Westfalen', 'DE', 1085664),
    ('Dortmund', 'Nordrhein-Westfalen', 'DE', 587010),
    ('Essen', 'Nordrhein-Westfalen', 'DE', 583109),
    ('Nha Trang', 'Khanh Hoa', 'VN', 392279),
    ('Cam Ranh', 'Khanh Hoa', 'VN', 120000),
    ('Ninh Hoa', 'Khanh Hoa', 'VN', 105000),
    ('Van Ninh', 'Khanh Hoa', 'VN', 100000),
    ('Vung Tau', 'Ba Ria-Vung Tau', 'VN', 327000),
    ('Ba Ria', 'Ba Ria-Vung Tau', 'VN', 122000),
    ('Long Dien', 'Ba Ria-Vung Tau', 'VN', 100000),
    ('Phuoc Hai', 'Ba Ria-Vung Tau', 'VN', 100000),
    ('Tan Binh', 'Ho Chi Minh City', 'VN', 459029),
    ('Thu Duc', 'Ho Chi Minh City', 'VN', 528413),
    ('Binh Chanh', 'Ho Chi Minh City', 'VN', 427000),
    ('Hoc Mon', 'Ho Chi Minh City', 'VN', 402000),
    ('Ba Dinh', 'Hanoi', 'VN', 247100),
    ('Nam Tu Liem', 'Hanoi', 'VN', 236800),
    ('Thanh Xuan', 'Hanoi', 'VN', 285000),
    ('Hoang Mai', 'Hanoi', 'VN', 411000),
    ('Amsterdam', 'North Holland', 'NL', 821752),
    ('Haarlem', 'North Holland', 'NL', 161265),
    ('Alkmaar', 'North Holland', 'NL', 108484),
    ('Hilversum', 'North Holland', 'NL', 90500),
    ('Rotterdam', 'South Holland', 'NL', 651446),
    ('Dordrecht', 'South Holland', 'NL', 118601),
    ('Leiden', 'South Holland', 'NL', 123000),
    ('Delft', 'South Holland', 'NL', 101000),
    ('Eindhoven', 'North Brabant', 'NL', 231642),
    ('Tilburg', 'North Brabant', 'NL', 217595),
    ('Breda', 'North Brabant', 'NL', 183873),
    ('s-Hertogenbosch', 'North Brabant', 'NL', 154205),
    ('Arnhem', 'Gelderland', 'NL', 156000),
    ('Nijmegen', 'Gelderland', 'NL', 175000),
    ('Apeldoorn', 'Gelderland', 'NL', 162000),
    ('Ede', 'Gelderland', 'NL', 118000),
    ('Paris', 'Île-de-France', 'FR', 2148000),
    ('Versailles', 'Île-de-France', 'FR', 85416),
    ('Boulogne-Billancourt', 'Île-de-France', 'FR', 117931),
    ('Saint-Denis', 'Île-de-France', 'FR', 110733),
    ('Bordeaux', 'Nouvelle-Aquitaine', 'FR', 257068),
    ('Limoges', 'Nouvelle-Aquitaine', 'FR', 133968),
    ('Pau', 'Nouvelle-Aquitaine', 'FR', 77281),
    ('Poitiers', 'Nouvelle-Aquitaine', 'FR', 87600),
    ('Lyon', 'Auvergne-Rhône-Alpes', 'FR', 513275),
    ('Grenoble', 'Auvergne-Rhône-Alpes', 'FR', 160215),
    ('Saint-Etienne', 'Auvergne-Rhône-Alpes', 'FR', 171260),
    ('Clermont-Ferrand', 'Auvergne-Rhône-Alpes', 'FR', 141569),
    ('Toulouse', 'Occitanie', 'FR', 479553),
    ('Montpellier', 'Occitanie', 'FR', 285121),
    ('Nimes', 'Occitanie', 'FR', 151001),
    ('Perpignan', 'Occitanie', 'FR', 121875),
    ('Tianjin', 'Beijing', 'CN', 1560000),
    ('Shijiazhuang', 'Beijing', 'CN', 1110000),
    ('Baoding', 'Beijing', 'CN', 1100000),
    ('Zhangjiakou', 'Beijing', 'CN', 1100000),
    ('Shanghai', 'Shanghai', 'CN', 2418000),
    ('Suzhou', 'Shanghai', 'CN', 1100000),
    ('Nantong', 'Shanghai', 'CN', 1100000),
    ('Wuxi', 'Shanghai', 'CN', 1100000),
    ('Guangzhou', 'Guangdong', 'CN', 1400000),
    ('Shenzhen', 'Guangdong', 'CN', 1100000),
    ('Dongguan', 'Guangdong', 'CN', 1100000),
    ('Foshan', 'Guangdong', 'CN', 1100000),
    ('Hangzhou', 'Zhejiang', 'CN', 1100000),
    ('Ningbo', 'Zhejiang', 'CN', 1100000),
    ('Wenzhou', 'Zhejiang', 'CN', 1100000),
    ('Jiaxing', 'Zhejiang', 'CN', 1100000),
    ('Tonle Bassac', 'Phnom Penh', 'KH', 160000),
    ('Dangkao', 'Phnom Penh', 'KH', 160000),
    ('Sen Sok', 'Phnom Penh', 'KH', 160000),
    ('Chamkar Mon', 'Phnom Penh', 'KH', 160000),
    ('Ta Khmau', 'Kandal', 'KH', 160000),
    ('Kien Svay', 'Kandal', 'KH', 160000),
    ('Angk Snuol', 'Kandal', 'KH', 160000),
    ('Kandal Stueng', 'Kandal', 'KH', 160000),
    ('Siem Reap', 'Siem Reap', 'KH', 140000),
    ('Angkor Chum', 'Siem Reap', 'KH', 140000),
    ('Sout Nikom', 'Siem Reap', 'KH', 140000),
    ('Kralanh', 'Siem Reap', 'KH', 140000),
    ('Poipet', 'Banteay Meanchey', 'KH', 140000),
    ('Serei Saophoan', 'Banteay Meanchey', 'KH', 140000),
    ('Thma Puok', 'Banteay Meanchey', 'KH', 140000),
    ('Mongkol Borei', 'Banteay Meanchey', 'KH', 140000);


INSERT INTO Border VALUES
    ('US', 'CA', 8893),
    ('US', 'MX', 3326),
    ('CA', 'US', 8893),
    ('CA', 'MX', 3155),
    ('MX', 'US', 3326),
    ('MX', 'CA', 3155),
    ('DE', 'FR', 451),
    ('DE', 'NL', 575),
    ('FR', 'DE', 451),
    ('FR', 'NL', 435),
    ('NL', 'DE', 575),
    ('NL', 'FR', 435),
    ('CN', 'KH', 144),
    ('CN', 'VN', 1281),
    ('KH', 'CN', 144),
    ('KH', 'VN', 1228),
    ('VN', 'CN', 1281),
    ('VN', 'KH', 1228);

