## Populate country to year matrix showing how many races happened in each country over the years?

SELECT 
    Country,
    SUM(CASE WHEN Year = 2005 THEN 1 ELSE 0 END) AS Races_2005,
    SUM(CASE WHEN Year = 2006 THEN 1 ELSE 0 END) AS Races_2006,
    SUM(CASE WHEN Year = 2007 THEN 1 ELSE 0 END) AS Races_2007,
    SUM(CASE WHEN Year = 2008 THEN 1 ELSE 0 END) AS Races_2008,
    SUM(CASE WHEN Year = 2009 THEN 1 ELSE 0 END) AS Races_2009,
    SUM(CASE WHEN Year = 2010 THEN 1 ELSE 0 END) AS Races_2010,
    SUM(CASE WHEN Year = 2011 THEN 1 ELSE 0 END) AS Races_2011,
    SUM(CASE WHEN Year = 2012 THEN 1 ELSE 0 END) AS Races_2012,
    SUM(CASE WHEN Year = 2013 THEN 1 ELSE 0 END) AS Races_2013,
    SUM(CASE WHEN Year = 2014 THEN 1 ELSE 0 END) AS Races_2014,
    SUM(CASE WHEN Year = 2015 THEN 1 ELSE 0 END) AS Races_2015,
    SUM(CASE WHEN Year = 2016 THEN 1 ELSE 0 END) AS Races_2016,
    SUM(CASE WHEN Year = 2017 THEN 1 ELSE 0 END) AS Races_2017,
    SUM(CASE WHEN Year = 2018 THEN 1 ELSE 0 END) AS Races_2018,
    SUM(CASE WHEN Year = 2019 THEN 1 ELSE 0 END) AS Races_2019,
    SUM(CASE WHEN Year = 2020 THEN 1 ELSE 0 END) AS Races_2020,
    SUM(CASE WHEN Year = 2021 THEN 1 ELSE 0 END) AS Races_2021,
    SUM(CASE WHEN Year = 2022 THEN 1 ELSE 0 END) AS Races_2022,
    SUM(CASE WHEN Year = 2023 THEN 1 ELSE 0 END) AS Races_2023,
    SUM(CASE WHEN Year = 2024 THEN 1 ELSE 0 END) AS Races_2024

FROM `finalproject.f1_race`
GROUP BY Country
ORDER BY Country;


### Another way to look at the races happened in each country over the years (in a tabular format).
SELECT Country, Year, COUNT(*) AS Race_count
FROM `finalproject.f1_race`
GROUP BY country, year
ORDER BY country


