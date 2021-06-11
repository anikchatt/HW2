-- Homework Chapter 3 SQL Assignment - Part 2
-- 06/14/2021 
-- Anik Chattopadhyay 
-- Professor Markulic

-- Still needs to be done 5, 7, 10, 11, 12, 17

-- Question 1 
SELECT ppl.playerid, 
       ppl.birthCity, 
	   ppl.birthState, 
	   s.yearid, 
	   FORMAT(s.salary, 'C') AS Salary, 
	   CONVERT(decimal(5,4),(B.H*1.0/B.AB)) as Batting_Average
FROM Spring_2021_BaseBall.dbo.People ppl, Spring_2021_BaseBall.dbo.Salaries s, Spring_2021_BaseBall.dbo.Batting B 
WHERE ppl.playerid = s.playerid and ppl.playerId = b.playerid and b.yearid = s.yearid and s.teamid = b.teamID and
B.AB > 0 and 
ppl.birthState = 'NJ'
ORDER BY ppl.nameLast ASC, s.yearId


--Question 2 
SELECT ppl.playerid, 
       ppl.birthCity, 
	   ppl.birthState, 
	   s.yearid, 
	   FORMAT(s.salary, 'C') AS Salary, 
	   CONVERT(decimal(5,4),(B.H*1.0/B.AB)) as Batting_Average
FROM Spring_2021_BaseBall.dbo.People ppl
JOIN Spring_2021_BaseBall.dbo.Salaries s ON ppl.playerid = s.playerid 
JOIN Spring_2021_BaseBall.dbo.Batting B ON b.yearid = s.yearid and ppl.playerId = b.playerid and s.teamid = b.teamid
WHERE  B.AB > 0 and 
ppl.birthState = 'NJ'
ORDER BY ppl.nameLast ASC, s.yearId


--Question 3    
SELECT ppl.playerid, 
       ppl.birthCity, 
	   ppl.birthState, 
	   ppl.birthYear,
	   b.yearid, 
	   FORMAT(s.salary, 'C') AS Salary, 
	   CONVERT(decimal(5,4),(B.H*1.0/B.AB)) as Batting_Average
FROM Spring_2021_BaseBall.dbo.Batting b 
LEFT JOIN Spring_2021_BaseBall.dbo.People ppl on b.playerid = ppl.playerid 
LEFT JOIN Spring_2021_BaseBall.dbo.Salaries s on b.playerid = s.playerid and b.yearid = s.yearid and b.teamid = s.teamid 
WHERE b.AB > 0 and ppl.birthState = 'NJ' 
ORDER BY ppl.nameLast ASC, s.yearId 


-- Question 4 
SELECT ppl.playerId, 
       CONCAT(ppl.nameGiven, ' (', ppl.nameFirst, ')', ' ', ppl.nameLast) AS Full_Name,
	   batting.yearid,
	   batting.H AS Hits,
	   batting.AB AS [At Bats], 
	   CONVERT(decimal(5,4),(batting.H*1.0/batting.AB)) as Batting_Average
FROM Spring_2021_BaseBall.dbo.People ppl
JOIN Spring_2021_BaseBall.dbo.Batting batting  ON ppl.playerId = batting.playerId  
WHERE CONVERT(decimal(5,4),(batting.H*1.0/batting.AB)) BETWEEN .30 and .3249 and
batting.AB > 0
ORDER BY CONVERT(decimal(5,4),(batting.H*1.0/batting.AB)) DESC


--Question 5 
SELECT DISTINCT (batting.playerId), 
       s.schoolId, 
	   batting.yearId, 
	   CONVERT(decimal(5,4),(batting.H*1.0/batting.AB)) as Batting_Average
FROM Spring_2021_BaseBall.dbo.Batting batting,Spring_2021_BaseBall.dbo.Schools s 
WHERE s.schoolId in ('brown', 'columbia','cornell', 'dartmouth', 'harvard', 'princeton', 'pennsylvania', 'yale')
and CONVERT(decimal(5,4),(batting.H*1.0/batting.AB)) < .4
and batting.AB >0 


--Question 6 
(SELECT playerid, teamid from Spring_2021_BaseBall.dbo.Appearances a where a.playerid = a.playerid and a.teamid = a.teamid and yearid = 2019)
intersect 
(SELECT playerid, teamid from Spring_2021_BaseBall.dbo.Appearances b where b.playerid = b.playerid and b.teamid = b.teamid and yearid = 2020)


--Question 7
(SELECT playerid, teamid from Spring_2021_BaseBall.dbo.Appearances  where playerid = playerid and teamid = teamid and yearid = 2019)
except 
(SELECT playerid, teamid from Spring_2021_BaseBall.dbo.Appearances  where playerid = playerid and yearid = 2020)
union
(SELECT playerid, teamid from Spring_2021_BaseBall.dbo.Appearances where playerid = playerid and yearid = 2019)


--Question 8
SELECT playerId, 
	   FORMAT(AVG(salary), 'C') AS [Average_Salary], 
	   FORMAT(SUM(salary), 'C') AS [Total_Salary] 
FROM Spring_2021_BaseBall.dbo.Salaries 
GROUP BY playerID
ORDER BY SUM(salary) DESC 


--Question 9 
SELECT b.playerId, 
	   CONCAT(ppl.nameGiven, ' (', ppl.nameFirst, ')', ' ', ppl.nameLast) AS Full_Name,
	   SUM(b.HR) AS Total_Home_Runs,
	   COUNT(b.yearId) AS Years_Played 
FROM  Spring_2021_BaseBall.dbo.Batting b, Spring_2021_BaseBall.dbo.People ppl 
WHERE b.playerId = ppl.playerId 
GROUP BY b.playerId, ppl.nameGiven, ppl.nameFirst, ppl.nameLast
HAVING SUM(b.HR) > 500
ORDER BY SUM(b.HR) DESC


--Question 10 
SELECT a.playerId, 
       

--Question 11 


--Question 12 


--Question 13 
SELECT name as [Full Name], avgs as [Average Salary], tot_team as [Total Teams]
FROM (SELECT playerid, 
			 FORMAT(AVG(salary),'C') AS avgs, 
			 COUNT(teamId) AS tot_team
      FROM Spring_2021_BaseBall.dbo.Salaries 
	  GROUP BY playerID) A,
	 (SELECT playerid,
	         CONCAT(nameGiven, ' (', nameFirst, ')', ' ', nameLast) as name 
	  FROM Spring_2021_BaseBall.dbo.People ) B
WHERE a.playerid = B.playerid 
	  

--Question 14 
UPDATE Spring_2021_BaseBall.dbo.Salaries
SET [401K Contributions] = [salary] * .06


--Question 15
UPDATE Spring_2021_BaseBall.dbo.Salaries
SET [401K Team Contributions] =  
	CASE WHEN [salary] > 1000000 THEN .025 * [salary] ELSE
	CASE WHEN [salary] < 1000000 THEN .05 * [salary]     
END  
END 

--Question 16
SELECT *
FROM Spring_2021_BaseBall.dbo.Salaries
WHERE salary IS NOT NULL

--Question 17
	


--Question 18 
SELECT playerid, 
	   SUM(HR) AS [Total_HR], 
	   MAX(CONVERT(decimal(5,4),(H*1.0)/NULLIF(AB, 0))) AS [High_BA]
FROM Spring_2021_BaseBall.dbo.Batting
GROUP BY playerid


--Question 19
UPDATE Spring_2021_BaseBall.dbo.People 
SET [Total_401K] = t.Total_401K 
FROM 
(
	SELECT playerid, SUM([401K Contributions] + [401K Team Contributions]) AS Total_401K
	FROM Spring_2021_BaseBall.dbo.Salaries
	GROUP BY playerid
) t
WHERE People.playerid = t.playerID


--Question 20
SELECT playerid, 
	   CONCAT(nameGiven, ' (', nameFirst, ')', ' ', nameLast) AS [Full Name],
	   format(Total_401K, 'c') AS [401K Total]
FROM Spring_2021_BaseBall.dbo.People
WHERE Total_401K IS NOT NULL
ORDER BY playerID


SELECT *
FROM Spring_2021_BaseBall.dbo.People