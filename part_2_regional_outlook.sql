-- a. What was the percent forest of the entire world in 2016?
-- Which region had the HIGHEST percent forest in 2016, and which had the LOWEST, to 2 decimal places?

SELECT country_name, forest_as_percent_of_land
FROM forestation
WHERE country_name = 'World'
AND year = 2016;

SELECT region, ROUND((SUM(forest_area_sqkm)/SUM(total_area_sqkm))*100, 2) AS region_percent
FROM forestation
WHERE year = 2016
GROUP BY 1 ORDER BY 2 DESC;

-- b. What was the percent forest of the entire world in 1990?
--Which region had the HIGHEST percent forest in 1990, and which had the LOWEST, to 2 decimal places?
SELECT country_name, forest_as_percent_of_land
FROM forestation
WHERE country_name = 'World'
AND year = 1990;

SELECT region, ROUND((SUM(forest_area_sqkm)/SUM(total_area_sqkm))*100, 2) AS region_percent
FROM forestation
WHERE year = 1990
GROUP BY 1 ORDER BY 2 DESC;
