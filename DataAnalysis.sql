SELECT TOP 1000 *
FROM CyclingData..[Total-tripdata]

-- The number of each type of riders at different hour in a day 

WITH NUM_DATE_TABLE AS
(
SELECT CONVERT(DATE, started_at) AS DATE, COUNT(CONVERT(DATE, started_at)) AS NUM_DATE
FROM CyclingData..[Total-tripdata]
GROUP BY CONVERT(DATE, started_at)
ORDER BY CONVERT(DATE, started_at)
)
SELECT DATEPART(HOUR, started_at) AS Hour,member_casual, 
	COUNT(member_casual)/(SELECT NUM_DATE FROM NUM_DATE_TABLE WHERE DATE == (SELECT CONVERT(DATE, started_at) FROM CyclingData..[Total-tripdata])) AS NumberPerDay
FROM CyclingData..[Total-tripdata]
GROUP BY DATEPART(HOUR, started_at), member_casual
ORDER BY DATEPART(HOUR, started_at), Number


SELECT DATEPART(HOUR, started_at) AS Hour,member_casual, COUNT(member_casual)/COUNT(DATEPART(HOUR, started_at)) AS Number
FROM CyclingData..[Total-tripdata]
GROUP BY DATEPART(HOUR, started_at), member_casual
ORDER BY DATEPART(HOUR, started_at), Number


SELECT CONVERT(DATE, started_at), COUNT(CONVERT(DATE, started_at))
FROM CyclingData..[Total-tripdata]
GROUP BY CONVERT(DATE, started_at)


¡¡

-- TABLE 1 
SELECT CONVERT(DATE, started_at) AS START_DATE, DATEPART(HOUR, started_at) AS START_HOUR, member_casual
INTO START_NUM
FROM CyclingData..[Total-tripdata]

SELECT TOP 100 *
FROM START_NUM
ORDER BY START_DATE, START_HOUR

-- TABLE 2
SELECT START_DATE, START_HOUR, member_casual, COUNT(member_casual) AS NUMDAYHOUR
INTO START_NUM_02
FROM START_NUM
GROUP BY START_DATE, START_HOUR, member_casual
ORDER BY START_DATE, START_HOUR

-- TABLE 03

SELECT TOP 100 *
FROM START_NUM_03
ORDER BY START_HOUR

SELECT START_HOUR,member_casual, COUNT(START_DATE) AS NUMOFDATE, SUM(NUMDAYHOUR) AS TOTALPERHOUR
INTO START_NUM_03
FROM START_NUM_02
GROUP BY START_HOUR, member_casual
ORDER BY START_HOUR

-- Calculate the number of rides each hour in a day for each type of membership

SELECT START_HOUR,member_casual,(TOTALPERHOUR/NUMOFDATE) AS AVG_DAY
INTO RidePerHour
FROM START_NUM_03
ORDER BY START_HOUR

SELECT * 
FROM RidePerHour


