--a. What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record denoted as “World" in the region table.

SELECT country_name, forest_area_sqkm
FROM forest_area
WHERE country_name = 'World'
AND year = 1990;

-- b. What was the total forest area (in sq km) of the world in 2016? Please keep in mind that you can use the country record in the table is denoted as “World.”

SELECT country_name, forest_area_sqkm
FROM forest_area
WHERE country_name = 'World'
AND year = 2016;

--c. What was the change (in sq km) in the forest area of the world from 1990 to 2016?
--d. What was the percent change in forest area of the world between 1990 and 2016?
--The below answers queries 1c and 1d:

--1990 forest area
WITH t1 AS(
SELECT country_name, forest_area_sqkm AS area_1990
FROM forest_area
WHERE country_name = 'World'
AND year = 1990
),
-- 2016 forest area
t2 AS(
SELECT country_name, forest_area_sqkm AS area_2016
FROM forest_area
WHERE country_name = 'World'
AND year = 2016
)
-- Working out the difference and percent change
SELECT area_2016, area_1990, area_2016-area_1990 AS area_change, ROUND((area_2016-area_1990)/area_1990 *100, 2) AS area_percent_change FROM t1, t2;


--e. If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?
SELECT country_name, year, ROUND((total_area_sq_mi*2.59),0) AS total_area_sqkm
FROM land_area
WHERE year = 2016
AND (total_area_sq_mi*2.59) <
((SELECT forest_area_sqkm FROM forest_area
WHERE country_name = 'World' AND year = 1990) -
(SELECT forest_area_sqkm FROM forest_area
WHERE country_name = 'World' AND year = 2016))
ORDER BY total_area_sq_mi DESC LIMIT 1;
