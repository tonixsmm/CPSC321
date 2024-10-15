
/**********************************************************************
 * NAME: Tony Nguyen
 * CLASS: CPSC 321 01
 * DATE: 10/17/2023
 * HOMEWORK: 4
 * DESCRIPTION: This SQL file contains the code to create the World Factbook tables. 
 **********************************************************************/

-- Quesiton 1: 
SELECT *
FROM Country
WHERE inflation < 5 AND gdp_per_capita > 50000
ORDER BY inflation ASC;

-- Question 2:
SELECT Country.country_code, Country.country_name, inflation, province_name, area
FROM Country, Province
WHERE Country.country_code = Province.country_code
    AND inflation > 4
    AND area < 10000
ORDER BY inflation DESC, Country.country_code ASC, area ASC;

-- Question 3:
SELECT Country.country_code, Country.country_name, inflation, province_name, area
FROM Country JOIN Province USING (country_code)
WHERE inflation > 4 AND area < 10000
ORDER BY inflation DESC, Country.country_code ASC, area ASC;

-- Question 4:
SELECT DISTINCT Country.country_code, Country.country_name, Province.province_name, Province.area
FROM City c1, Country, Province
WHERE c1.province_name = Province.province_name
    AND c1.population > 1000000
    AND Country.country_code = c1.country;

-- Question 5:
SELECT DISTINCT Country.country_code, Country.country_name, Province.province_name, Province.area
FROM City JOIN Province USING (province_name)
    JOIN Country USING (country_code)
WHERE City.population > 1000000;

-- Question 6:
SELECT DISTINCT Country.country_code, Country.country_name, c2.province_name, p1.area
FROM City c1, City c2, Province p1, Country
WHERE c2.population > 1000000 AND c1.population > 1000000
    AND c1.province_name = c2.province_name
    AND c1.city_name < c2.city_name
    AND c1.province_name = p1.province_name
    AND p1.country_code = Country.country_code;

-- Question 7:
SELECT DISTINCT Country.country_code, Country.country_name, c2.province_name, Province.area
FROM City c1 JOIN City c2 ON (c1.province_name = c2.province_name AND c1.city_name < c2.city_name)
    JOIN Province ON (c1.province_name = Province.province_name)
    JOIN Country ON (c1.country = Country.country_code)
WHERE c1.population > 1000000 AND c2.population > 1000000;

-- Question 8:
SELECT c1.city_name, c1.province_name, c1.country, c2.city_name, c2.province_name, c2.country, c2.population
FROM (City c1 JOIN Country y1 ON (y1.country_code = c1.country)) 
    JOIN (City c2 JOIN Country y2 ON (y2.country_code = c2.country)) ON (c1.population = c2.population) 
WHERE c1.city_name < c2.city_name
    AND (c1.province_name < c2.province_name OR c1.country < c2.country);

-- Question 9:
SELECT DISTINCT c1.country_code, c1.country_name
FROM Country c1, Border, Country c2
WHERE (c1.gdp_per_capita > 50000 AND c1.inflation < 4)
    AND c1.country_code = Border.country_code1
    AND (c2.gdp_per_capita < 50000 AND c2.inflation > 4)
    AND Border.country_code2 = c2.country_code;
    
-- Question 10:
SELECT DISTINCT c1.country_code, c1.country_name
FROM Country c1 JOIN Border ON (c1.country_code = Border.country_code1)
    JOIN Country c2 ON (c2.country_code = Border.country_code2)
WHERE (c1.gdp_per_capita > 50000 AND c1.inflation < 4)
    AND (c2.gdp_per_capita < 50000 AND c2.inflation > 4);

-- Question 11:
-- Find pairs of neighboring countries that share a border and have a significant 
-- difference in GDP per capita. Specifically, retrieve pairs of countries with a border 
-- length greater than 300 kilometers and where the difference in GDP per capita between 
-- the countries is greater than $5,000.
SELECT c1.country_code, c1.country_name, c2.country_code, c2.country_name
FROM (Country c1 JOIN Border ON (c1.country_code = Border.country_code1))
    JOIN Country c2 ON (c2.country_code = Border.country_code2)
WHERE Border.border_length > 300 
    AND ((c1.gdp_per_capita - c2.gdp_per_capita) > 5000 OR (c1.gdp_per_capita - c2.gdp_per_capita) < -5000)
ORDER BY c1.country_code ASC, c2.country_code ASC;
