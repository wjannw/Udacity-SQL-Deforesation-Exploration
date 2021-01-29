--To fill in the gaps in the template, this is the query I ran:

-- 1990 forest area
WITH t1 AS(
SELECT country_name, year, forest_area_sqkm AS area_1990
FROM forest_area
WHERE forest_area_sqkm IS NOT NULL
AND country_name <> 'World'
AND year = 1990
ORDER BY 3 DESC ),
-- 2016 forest area t2 AS(
SELECT country_name, year, forest_area_sqkm AS area_2016
FROM forest_Area
WHERE forest_area_sqkm IS NOT NULL
AND country_name <> 'World'
AND year = 2016 )
-- Difference between 1990 and 2016
SELECT t1.country_name, area_1990, area_2016, ROUND(area_2016 - area_1990,0) AS area_difference, ROUND(((area_2016-area_1990)/area_1990 *100),2) AS area_difference_percent
FROM t1
JOIN t2
ON t1.country_name = t2.country_name
ORDER BY 4 DESC
LIMIT 5;

 --a. Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? What was the difference in forest area for each?

-- 1990 forest area WITH t1 AS(
SELECT country_name, region, forest_area_sqkm AS area_1990
FROM forestation
WHERE forest_area_sqkm IS NOT NULL
AND country_name <> 'World'
AND year = 1990 ORDER BY 3 DESC ),
-- 2016 forest area t2 AS(
SELECT country_name, region, forest_area_sqkm AS area_2016
FROM forestation
WHERE forest_area_sqkm IS NOT NULL
AND country_name <> 'World'
AND year = 2016 ORDER BY 3 DESC )
-- Difference between two tables
SELECT t1.country_name, t1.region, area_1990, area_2016, ROUND(area_1990-area_2016,0) AS area_difference
FROM t1
JOIN t2
ON t1.country_name = t2.country_name
ORDER BY 5 DESC
LIMIT 5;


-- b. Which 5 countries saw the largest percent decrease in forest area from 1990 to 2016? What was the percent change to 2 decimal places for each?

-- 1990 forest area WITH t1 AS(
SELECT country_name, region, forest_area_sqkm AS area_1990
FROM forestation
WHERE forest_area_sqkm IS NOT NULL
AND country_name <> 'World'
AND year = 1990 ORDER BY 3 DESC ),
-- 2016 forest area t2 AS(
SELECT country_name, region, forest_area_sqkm AS area_2016
FROM forestation
WHERE forest_area_sqkm IS NOT NULL
AND country_name <> 'World'
AND year = 2016 ORDER BY 3 DESC )
-- Difference between the two
SELECT t1.country_name, t1.region, area_1990, area_2016, ROUND(area_1990-area_2016,0) AS area_difference, ROUND(((area_1990-area_2016)/area_1990*100),0) AS area_percent FROM t1
JOIN t2
ON t1.country_name = t2.country_name
ORDER BY 6 DESC
LIMIT 5;


-- c. If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016?

-- 2016 table WITH t1 AS(
SELECT country_name, forest_as_percent_of_land
FROM forestation
WHERE year = 2016
AND country_name <> 'World'
)
-- working out the quartiles
SELECT
COUNT(CASE WHEN t1.forest_as_percent_of_land <= 25 THEN 1 ELSE NULL END) AS quartile_1,
COUNT(CASE WHEN t1.forest_as_percent_of_land > 25 AND t1.forest_as_percent_of_land <= 50 THEN 1 ELSE NULL END) AS quartile_2,
COUNT(CASE WHEN t1.forest_as_percent_of_land > 50 AND t1.forest_as_percent_of_land <= 75 THEN 1 ELSE NULL END) AS quartile_3,
COUNT(CASE WHEN t1.forest_as_percent_of_land > 75 THEN 1 ELSE NULL END) AS quartile_4
FROM t1;

--d. List all of the countries that were in the 4th quartile (percent forest > 75%) in 2016.

SELECT country_name, region, forest_as_percent_of_land
FROM forestation
WHERE year = 2016
AND country_name <> 'World'
AND forest_as_percent_of_land > 75 ORDER BY 3 DESC;

--e. How many countries had a percent forestation higher than the United States in 2016?

SELECT count(*)
FROM forestation
WHERE year = 2016
AND country_name <> 'World'
AND forest_as_percent_of_land > (SELECT forest_as_percent_of_land
FROM forestation
WHERE year = 2016
AND country_name = 'United States');
