-- List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name
FROM world 
WHERE continent = 'Europe' 
AND 
 gdp/population > (SELECT gdp/population FROM world WHERE name='United Kingdom')

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name,continent
FROM world
WHERE continent IN (
  SELECT continent
  FROM world
  WHERE name IN ('Australia','Argentina'))
ORDER BY name

-- Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT name,population
FROM world
WHERE population >
(SELECT name FROM world WHERE population > 'Canada' 
AND population < 'Poland')

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name, CONCAT(ROUND(100*population/(SELECT population
                                          FROM world
                                          WHERE name='Germany')), 
                                          '%') AS population
FROM world
WHERE continent='Europe'

-- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name
FROM world
WHERE gdp > ALL
(SELECT gdp FROM world WHERE continent='Europe' AND gdp IS NOT NULL)

-- Find the largest country (by area) in each continent, show the continent, the name and the area:

SELECT continent, name, area 
FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

-- List each continent and the name of the country that comes first alphabetically.

SELECT continent,name FROM world x
  WHERE x.name <= ALL (
    SELECT name FROM world y
     WHERE x.continent=y.continent)

-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

SELECT name, continent, population
FROM world x
WHERE 25000000>= ALL
(SELECT population from world y WHERE x.continent=y.continent)

-- Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.

SELECT name, continent
FROM world x
WHERE x.population/3 > ALL (
  SELECT y.population
  FROM world y
  WHERE x.continent = y.continent
  AND x.name != y.name);



