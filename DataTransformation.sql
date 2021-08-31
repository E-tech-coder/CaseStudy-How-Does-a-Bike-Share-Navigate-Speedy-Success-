-- Use the following syntax to check out the table structure

sp_help "CyclingData..202107-tripdata"

SELECT TOP 10 * 
FROM CyclingData..[202107-tripdata]

-- Create a new table that contains the all the cycling information from August 2020 to July 2021.

sp_help "CyclingData..[202011-tripdata]"

ALTER TABLE CyclingData..[202008-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202008-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202009-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202009-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202010-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202010-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202011-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202011-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202012-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202012-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202101-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202101-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202102-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202102-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202103-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202103-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202104-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202104-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202105-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202105-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202106-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202106-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

ALTER TABLE CyclingData..[202107-tripdata]
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE CyclingData..[202107-tripdata]
ALTER COLUMN start_station_id nvarchar(255)

WITH TEMP AS (
SELECT *
FROM CyclingData..[202008-tripdata]
UNION
SELECT *
FROM CyclingData..[202009-tripdata]
UNION
SELECT *
FROM CyclingData..[202010-tripdata]
UNION
SELECT *
FROM CyclingData..[202011-tripdata]
UNION
SELECT *
FROM CyclingData..[202012-tripdata]
UNION
SELECT *
FROM CyclingData..[202101-tripdata]
UNION
SELECT *
FROM CyclingData..[202102-tripdata]
UNION
SELECT *
FROM CyclingData..[202103-tripdata]
UNION
SELECT *
FROM CyclingData..[202104-tripdata]
UNION
SELECT *
FROM CyclingData..[202105-tripdata]
UNION
SELECT *
FROM CyclingData..[202106-tripdata]
UNION
SELECT *
FROM CyclingData..[202107-tripdata]
)
SELECT COUNT(*)
FROM TEMP

SELECT COUNT(*)
FROM CyclingData..[Total-tripdata]

-- There are 4731081 observations in the Total-tripdata table.

-- Look for duplicated records 
WITH ROW_NUM_TEMP AS(
SELECT *, ROW_NUMBER() OVER (PARTITION BY ride_id,
rideable_type,
started_at, ended_at,
start_station_id, end_station_id,
member_casual ORDER BY ride_id
) AS rownum
FROM CyclingData..[Total-tripdata]
)
SELECT * 
FROM ROW_NUM_TEMP
WHERE rownum != 1

-- There is no duplicate records here.

SELECT TOP 100 * 
FROM CyclingData..[Total-tripdata]
ORDER BY started_at, ride_id



SELECT * 
FROM CyclingData..[Total-tripdata]
ORDER BY started_at, ride_id

SELECT DISTINCT(rideable_type)
FROM CyclingData..[Total-tripdata]


