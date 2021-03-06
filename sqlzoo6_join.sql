/* SQL Zoo 6 - JOIN */

/* Show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER' */

SELECT matchid, player
FROM goal
WHERE teamid = 'GER'

/* Show id, stadium, team1, team2 for just game 1012 */

SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012

/* Modify it to show the player, teamid, stadium and mdate for every German goal. */

SELECT player, teamid, stadium, mdate
FROM game
JOIN goal
ON id = matchid
WHERE teamid = 'GER'

/* Show the team1, team2 and player for every goal scored by a player called Mario */

SELECT team1, team2, player
FROM game
JOIN goal
ON id = matchid
WHERE player LIKE 'Mario%'

/* Show player, teamid, coach, gtime for all goals scored in the first 10 minutes */

SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam
ON teamid = id
WHERE gtime <= 10

/* List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */

SELECT mdate, teamname
FROM game
JOIN eteam t
ON team1 = t.id
WHERE coach = 'Fernando Santos'

/* List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */

SELECT player
FROM goal
JOIN game
ON matchid = id
WHERE stadium LIKE 'National Stadium%'

/* Show the name of all players who scored a goal against Germany. */

SELECT DISTINCT player
FROM game
JOIN goal
ON matchid = id
WHERE (team1 = 'GER' OR team2 ='GER')
AND teamid <> 'GER'

/* Show teamname and the total number of goals scored. */

SELECT teamname, COUNT(teamid)
FROM eteam
JOIN goal
ON id = teamid
GROUP BY teamname

/* Show the stadium and the number of goals scored in each stadium. */

SELECT stadium, COUNT(teamid)
FROM game
JOIN goal
ON id = matchid
GROUP BY stadium

/* List every match involving 'POL', show the matchid, date and the number of goals scored. */

SELECT matchid, mdate, COUNT(teamid)
FROM game
JOIN goal
ON id = matchid
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid

/* List every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER' */

SELECT matchid, mdate, COUNT(teamid)
FROM game
JOIN goal
ON id = matchid
WHERE (team1 = 'GER' OR team2 = 'GER')
AND teamid = 'GER'
GROUP BY matchid

/* List every match with the goals scored by each team */

SELECT mdate,
team1, SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) score1,
team2, SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) score2
FROM game
LEFT JOIN goal
ON matchid = id
GROUP BY mdate, matchid, team1, team2

/* Find the stadium where player 'Dimitris Salpingidis' scored */

SELECT stadium
FROM game
JOIN goal
ON id = matchid
WHERE player = 'Dimitris Salpingidis'

/* Show players, their team and the amount of goals they scored against Greece(GRE). */

SELECT player, teamid, COUNT(*)
FROM game JOIN goal ON matchid = id
WHERE (team1 = "GRE" OR team2 = "GRE")
AND teamid != 'GRE'
GROUP BY player, teamid

/* Show the teams that play a game on '9 June 2012' */

SELECT DISTINCT teamid, mdate
FROM goal
JOIN game
ON  matchid = id
WHERE mdate = '9 June 2012'

/* Show the player and their team List those who have scored against Poland(POL) in National Stadium, Warsaw. */

SELECT DISTINCT player, teamid
FROM game
JOIN goal
ON matchid = id
WHERE stadium = 'National Stadium, Warsaw'
AND (team1 = 'POL' OR team2 = 'POL')
AND teamid != 'POL'

/* Show the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA). */

SELECT DISTINCT player, teamid, gtime
FROM game
JOIN goal
ON matchid = id
WHERE stadium = 'Stadion Miejski (Wroclaw)'
AND (( teamid = team2 AND team1 != 'ITA')
OR ( teamid = team1 AND team2 != 'ITA'))

/* Show the teams that have scored less than 3 goals */

SELECT teamname, COUNT(*)
FROM eteam
JOIN goal
ON teamid = id
GROUP BY teamname
HAVING COUNT(*) < 3
