/* SQL Zoo 4 - SELECT SELECT */

/* List each country name where the population is larger than that of 'Russia'. */

SELECT name FROM world
WHERE population >
(SELECT population
 FROM world
 WHERE name='Russia');

/* Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. */

SELECT name
FROM world
WHERE continent = 'Europe'
AND gdp / population > (SELECT gdp / population
                        FROM world
                        WHERE name = 'United Kingdom');

/* List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country. */

SELECT name, continent
FROM world
WHERE continent IN (SELECT continent
                    FROM world
                    WHERE name IN ('Argentina', 'Australia')) ORDER BY name;

/* Which country has a population that is more than Canada but less than Poland? Show the name and the population. */

SELECT name, population
FROM world
WHERE population > (SELECT population
                    FROM world
                    WHERE name = 'Canada')
AND population < (SELECT population
                  FROM world
                  WHERE name = 'Poland');

/* Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany. */

SELECT name, CONCAT(ROUND(population * 100 / (SELECT population
                                              FROM world
                                              WHERE name = 'Germany')), '%')
                                              AS percentage
FROM world
WHERE continent = 'Europe';

/* Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values) */

SELECT name
FROM world
WHERE gdp > (SELECT MAX(gdp)
             FROM world
             WHERE continent = 'Europe');

/* Find the largest country (by area) in each continent, show the continent, the name and the area: */

SELECT continent, name, area
FROM world x
WHERE area >= ALL (SELECT area FROM world y
                   WHERE y.continent = x.continent
                   AND area > 0);

/* List each continent and the name of the country that comes first alphabetically. */

SELECT continent, name
FROM world x
WHERE x.name <= ALL (SELECT name
                     FROM world y
                     WHERE x.continent = y.continent);

/* Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. */

SELECT name, continent, population
FROM world x
WHERE 25000000 >= ALL (SELECT population
                       FROM world y
                       WHERE x.continent = y.continent
                       AND y.population >  0);

/* Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. */

SELECT name, continent
FROM world x
WHERE population > ALL (SELECT population * 3
                      FROM world y
                      WHERE y.continent = x.continent
                      AND y.name != x.name);

/* QUIZ */

/* Show the name, region and population of the smallest country in each region */

SELECT region, name, population
FROM bbc x
WHERE population <= ALL (SELECT population
                         FROM bbc y
                         WHERE y.region = x.region
                         AND population > 0)

/* Show the countries belonging to regions with all populations over 50000 */

 SELECT name,region,population
 FROM bbc x
 WHERE 50000 < ALL (SELECT population
                    FROM bbc y
                    WHERE x.region = y.region
                    AND y.population > 0);

/* Show the countries with a less than a third of the population of the countries around it */

SELECT name, region
FROM bbc x
WHERE population < ALL (SELECT population / 3
                        FROM bbc y
                        WHERE y.region = x.region
                        AND y.name != x.name);

/* Show the contries with more poputacion than United Kingdom */

SELECT name
FROM bbc
WHERE population > (SELECT population
                    FROM bbc
                    WHERE name = 'United Kingdom')
                    AND region IN (SELECT region
                                   FROM bbc
                                   WHERE name = 'United Kingdom');

/* Show the countries with a greater GDP than any country in Africa (some countries may have NULL gdp values). */

SELECT name
FROM bbc
WHERE gdp > (SELECT MAX(gdp)
             FROM bbc
             WHERE region = 'Africa');

/* Show the countries with population smaller than Russia but bigger than Denmark */

SELECT name
FROM bbc
WHERE population < (SELECT population
                    FROM bbc
                    WHERE name='Russia')
AND population > (SELECT population
                  FROM bbc
                  WHERE name='Denmark');

/* Show the contries with more population than Europe and South Asia */

SELECT name
FROM bbc
WHERE population > ALL (SELECT MAX(population)
                        FROM bbc
                        WHERE region = 'Europe')
AND region = 'South Asia';
