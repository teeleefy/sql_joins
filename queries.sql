-- write your queries here
--Join the two tables so that every column and record appears, regardless of if there is not an owner_id . 
SELECT * FROM owners o LEFT JOIN vehicles v ON v.owner_id = o.id;
--Count the number of cars for each owner. Display the owners first_name , last_name and count of vehicles. The first_name should be ordered in ascending order. 
SELECT o.first_name, o.last_name, COUNT(*) FROM owners o JOIN vehicles v ON v.owner_id = o.id GROUP BY o.id ORDER BY o.first_name;
--Count the number of cars for each owner and display the average price for each of the cars as integers. Display the owners first_name , last_name, average price and count of vehicles. The first_name should be ordered in descending order. Only display results with more than one vehicle and an average price greater than 10000. 
SELECT o.first_name, o.last_name, ROUND(AVG(v.price)) average_price, COUNT(*) vehicle_count FROM owners o JOIN vehicles v ON v.owner_id = o.id GROUP BY o.id HAVING AVG(v.price) > 10000 AND COUNT(*) > 1 ORDER BY o.first_name DESC;

--Tutorials steps 6 and 7 in https://sqlzoo.net
--SIX:
-- 1.
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';
-- 2.
SELECT id,stadium,team1,team2
  FROM game WHERE id = 1012;
-- 3.
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER';
-- 4.
SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid) WHERE player LIKE 'Mario%';
-- 5.
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam on teamid=id
 WHERE gtime<=10;
-- 6.
SELECT mdate, teamname
  FROM game JOIN eteam on team1=eteam.id
 WHERE coach = 'Fernando Santos';
-- 7.
SELECT player
  FROM goal JOIN game ON id=matchid
 WHERE stadium= 'National Stadium, Warsaw';
-- 8. 
SELECT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND (NOT teamid = 'GER') GROUP BY player;
-- 9.
SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON id=teamid GROUP BY teamname
 ORDER BY teamname;
-- 10.
SELECT stadium, COUNT(*)
  FROM game JOIN goal ON id=matchid GROUP BY stadium;
-- 11.
SELECT matchid, mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid;
-- 12.
SELECT matchid, mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id 
 WHERE teamid = 'GER' GROUP BY mdate ORDER BY matchid;
-- 13.
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2 
  FROM game JOIN goal ON matchid = id GROUP BY matchid ORDER BY mdate, matchid, team1, team2;


--SEVEN
-- 1.
SELECT id, title
 FROM movie
 WHERE yr=1962;
-- 2.
SELECT yr
 FROM movie
 WHERE title ='Citizen Kane';
-- 3.
SELECT id, title, yr
 FROM movie
 WHERE title LIKE 'Star Trek%' ORDER BY yr;
-- 4.
SELECT id
 FROM actor
 WHERE name = 'Glenn Close';
-- 5.
SELECT id
 FROM movie
 WHERE title = 'Casablanca';
-- 6.
SELECT name
 FROM casting JOIN actor ON actorid = actor.id
 WHERE movieid=11768;
-- 7.
SELECT name
 FROM casting JOIN actor ON actorid = actor.id JOIN movie ON movieid= movie.id
 WHERE title= 'Alien';
-- 8.
SELECT title
 FROM casting JOIN actor ON actorid = actor.id JOIN movie ON movieid= movie.id
 WHERE name= 'Harrison Ford';
--9.
 SELECT title
 FROM casting JOIN actor ON actorid = actor.id JOIN movie ON movieid= movie.id
 WHERE name= 'Harrison Ford' and NOT casting.ord = 1;
-- 10.
SELECT title, name
 FROM casting JOIN actor ON actorid = actor.id JOIN movie ON movieid= movie.id
 WHERE yr=1962 and casting.ord = 1;
-- 11.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;
-- 12.
SELECT title, name FROM movie JOIN casting ON (movieid=movie.id AND ord=1) JOIN actor ON actorid = actor.id WHERE movie.id IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id FROM actor WHERE name ='Julie Andrews'));
-- 13.
SELECT name FROM actor JOIN casting ON (actorid=actor.id AND ord = 1) GROUP BY name HAVING COUNT(*) > 15 ORDER BY name;
-- 14.
SELECT title, COUNT(actorid) FROM movie JOIN casting ON movieid = movie.id WHERE yr = 1978 GROUP BY title ORDER BY COUNT(actorid) desc, title;
-- 15.
SELECT name FROM movie JOIN casting ON (movieid=movie.id) JOIN actor ON actorid = actor.id WHERE movie.id IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id FROM actor WHERE name ='Art Garfunkel')) AND NOT name = 'Art Garfunkel' GROUP BY name;