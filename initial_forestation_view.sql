
--The first step is to create a view called 'forestation' by joining all three tables.
-- Keep in mind that the column forest_area_sqkm in the forest_area table and the land_area_sqmi in the land_area table are in different units. 

CREATE VIEW forestation AS SELECT fa.country_code,
  fa.country_name,
  fa.year,
  fa.forest_area_sqkm,
  la.total_area_sq_mi,
  la.total_area_sq_mi * 2.59 AS total_area_sqkm, ROUND((fa.forest_area_sqkm/(la.total_area_sq_mi * 2.59))*100, 2)AS
  forest_as_percent_of_land, r.region,
  r.income_group FROM forest_area fa
JOIN land_area la
ON fa.country_code = la.country_code AND fa.year = la.year JOIN regions r
ON la.country_code = r.country_code;
