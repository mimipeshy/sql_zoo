
-- The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

-- Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
  FROM game
WHERE id= '1012'

-- The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
-- Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player,teamid,stadium,mdate
  FROM game JOIN goal ON (game.id= goal.matchid)
WHERE teamid= 'GER'

-- Use the same JOIN as in the previous question.
-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

select team1, team2,player
from game
JOIN goal ON (game.id= goal.matchid)
 WHERE player LIKE 'Mario%'

--  the table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach,gtime
  FROM goal
JOIN eteam on teamid=id 
 WHERE gtime<=10

--  List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
  FROM game
JOIN eteam on (team1=eteam.id) 
 WHERE coach ='Fernando Santos'

--  List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM game JOIN goal ON (game.id= goal.matchid)
where stadium = 'National Stadium, Warsaw'

-- Select goals scored only by non-German players in matches where GER was the id of either team1 or team2.

SELECT DISTINCT player
  FROM game JOIN goal ON (goal.matchid = game.id )
    WHERE (team1 ='GER' OR team2 ='GER')
AND teamid !='GER'

-- Show teamname and the total number of goals scored.

SELECT teamname, COUNT(player) goals_scored
FROM eteam JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname

-- Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(player) goals_scored
FROM game JOIN goal ON game.id = goal.matchid
GROUP BY stadium

-- For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON game.id = goal.matchid
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY goal.matchid

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON game.id = goal.matchid
 WHERE (teamid = 'GER')
GROUP BY goal.matchid

-- List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.

SELECT mdate, 
      team1, 
      SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
      team2,
      SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY game.id 
ORDER BY mdate,matchid,team1,team2



