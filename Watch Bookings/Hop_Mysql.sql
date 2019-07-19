-- I create the tables that I will be filling with the given data
-- As long as the performance is not a concern, I prefer using left join
-- which is better practice to spot any abnormalities
DROP TABLE IF EXISTS hoppa; 
CREATE TABLE hoppa 
(
USER_ID VARCHAR(100) NOT NULL,
TRIP_ID VARCHAR(100) NOT NULL,
TRIP_TYPE VARCHAR(20) NOT NULL,
ORIGIN VARCHAR(20),
DESTINATION VARCHAR(20),
DEPARTURE_DATE DATE,
RETURN_DATE DATE,
STAY INT,
WEEKEND INT,
FILTER_NO_LCC INT,
FILTER_NON_STOP INT,
FILTER_SHORT_LAYOVER INT,
FILTER_NAME VARCHAR(60),
STATUS_UPDATES INT,
FIRST_SEARCH_DT DATETIME, 
WATCH_ADDED_DT DATETIME,
LATEST_STATUS_CHANGE_DT DATETIME,
STATUS_LATEST VARCHAR(20),
TOTAL_NOTIFS INT,
TOTAL_BUY_NOTIFS INT,
FIRST_REC VARCHAR(20),
FIRST_TOTAL INT,
LAST_REC VARCHAR(20),
LAST_TOTAL INT,
FIRST_BUY_DT DATETIME, 
FIRST_BUY_TOTAL INT,
LOWEST_TOTAL INT,
LAST_NOTIF_DT DATETIME,
FORECAST_FIRST_TARGET_PRICE INT,
FORECAST_FIRST_GOOD_PRICE INT,
FORECAST_LAST_TARGET_PRICE INT,
FORECAST_LAST_GOOD_PRICE INT,
FORECAST_LAST_WARNING_DATE DATE,
FORECAST_LAST_DANGER_DATE DATE,
FORECAST_MIN_TARGET_PRICE INT,
FORECAST_MAX_TARGET_PRICE INT,
FORECAST_MIN_GOOD_PRICE INT,
FORECAST_MAX_GOOD_PRICE INT,
WATCH_ADVANCE INT,
FIRST_ADVANCE INT,
CURRENT_ADVANCE INT
);
truncate table hoppa;
select * from hoppa;
LOAD DATA LOCAL INFILE 'C:/Users/gurkaali/Documents/Info/Ben/Hop/WatchesTable.csv'
IGNORE
INTO TABLE hoppa
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(user_id, trip_id, trip_type, origin, destination, @date1, @date2,
@nully1, weekend, filter_no_lcc, filter_non_stop, filter_short_layover, filter_name,
status_updates, @date3, @date4, @date5,
status_latest, @nully2, @nully3, @nully4, @nully5,
@nully6, @nully7 , @date6, @nully8 , @nully9 ,
@date7, @nully10 , @nully11 ,
@nully12 , @nully13 ,
@date8, @date9,
@nully14 , @nully15 ,
@nully16 , @nully17 ,
@nully18 , @nully19 , @nully20 )
SET departure_date = STR_TO_DATE(@date1, '%m/%d/%Y'),
	return_date = STR_TO_DATE(NULLIF(@date2, ''), '%m/%d/%Y'),
    stay = NULLIF(@nully1, ''),
    first_search_dt = STR_TO_DATE(@date3, '%m/%d/%Y %H:%i:%s'),
    watch_added_dt = STR_TO_DATE(NULLIF(@date4, ''), '%m/%d/%Y %H:%i:%s'),
    latest_status_change_dt = STR_TO_DATE(@date5, '%m/%d/%Y %H:%i:%s'),
    total_notifs = NULLIF(@nully2, ''),
    first_buy_dt = STR_TO_DATE(@date6, '%m/%d/%Y %H:%i:%s'),
    last_notif_dt = STR_TO_DATE(@date7, '%m/%d/%Y %H:%i:%s'),
    forecast_last_warning_date = STR_TO_DATE(@date8, '%m/%d/%Y'),
    forecast_last_danger_date = STR_TO_DATE(@date9, '%m/%d/%Y'),
    total_buy_notifs = NULLIF(@nully3, ''),
    first_rec = NULLIF(@nully4, ''),
    first_total = NULLIF(@nully5, ''),
    last_rec = NULLIF(@nully6, ''),
    last_total = NULLIF(@nully7, ''),
    first_buy_total = NULLIF(@nully8, ''),
    lowest_total = NULLIF(@nully9, ''),
    forecast_first_target_price = NULLIF(@nully10, ''),
    forecast_first_good_price = NULLIF(@nully11, ''),
    forecast_last_target_price = NULLIF(@nully12, ''),
    forecast_last_good_price = NULLIF(@nully13, ''),
    forecast_min_target_price = NULLIF(@nully14, ''),
    forecast_max_target_price = NULLIF(@nully15, ''),
    forecast_min_good_price = NULLIF(@nully16, ''),
    forecast_max_good_price = NULLIF(@nully17, ''),
    watch_advance = NULLIF(@nully18, ''),
    first_advance = NULLIF(@nully19, ''),
    current_advance = NULLIF(@nully20, '')
    ;

# setting the primary key does not work

CREATE TABLE hoppa2 AS
SELECT DISTINCT 
USER_ID,
TRIP_ID,
TRIP_TYPE,
ORIGIN,
DESTINATION,
DEPARTURE_DATE,
RETURN_DATE,
STAY,
WEEKEND,
FILTER_NO_LCC,
FILTER_NON_STOP,
FILTER_SHORT_LAYOVER,
FILTER_NAME,
STATUS_UPDATES,
FIRST_SEARCH_DT, 
WATCH_ADDED_DT,
LATEST_STATUS_CHANGE_DT,
STATUS_LATEST,
TOTAL_NOTIFS,
TOTAL_BUY_NOTIFS,
FIRST_REC,
FIRST_TOTAL,
LAST_REC,
LAST_TOTAL,
FIRST_BUY_DT, 
FIRST_BUY_TOTAL,
LOWEST_TOTAL,
LAST_NOTIF_DT,
FORECAST_FIRST_TARGET_PRICE,
FORECAST_FIRST_GOOD_PRICE,
FORECAST_LAST_TARGET_PRICE,
FORECAST_LAST_GOOD_PRICE,
FORECAST_LAST_WARNING_DATE,
FORECAST_LAST_DANGER_DATE,
FORECAST_MIN_TARGET_PRICE,
FORECAST_MAX_TARGET_PRICE,
FORECAST_MIN_GOOD_PRICE,
FORECAST_MAX_GOOD_PRICE,
WATCH_ADVANCE,
FIRST_ADVANCE,
CURRENT_ADVANCE
FROM hoppa;

ALTER TABLE hoppa2
ADD PRIMARY KEY(USER_ID, TRIP_ID, trip_type, origin,	destination,	departure_date, return_date);

select count(*)
from hoppa2 where return_date is null; 

UPDATE hoppa2
SET return_date = '9999-9-9'
WHERE RETURN_DATE IS NULL;

SELECT USER_ID, TRIP_ID, trip_type, origin,	destination, departure_date, return_date, COUNT(*)
FROM hoppa2
GROUP BY USER_ID, TRIP_ID, trip_type, origin,	destination,	departure_date, return_date
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) FROM hoppa; #1 007 692
SELECT COUNT(*) FROM hoppa2; #793355

SELECT SUM(first_total), SUM(last_total), SUM(first_buy_total), SUM(lowest_total), 
	SUM(forecast_first_target_price),	SUM(forecast_first_good_price),	SUM(forecast_last_target_price),
	SUM(forecast_last_good_price), SUM(forecast_min_target_price),
	SUM(forecast_max_target_price),	SUM(forecast_min_good_price),
	SUM(forecast_max_good_price), SUM(watch_advance), SUM(first_advance), SUM(current_advance)
FROM hoppa;

SELECT *
FROM hoppa LIMIT 10;

CREATE TABLE bugs 
(
BUG_ID NUMBER NOT NULL,
PRIORITY VARCHAR2(30) NOT NULL,
SEVERITY VARCHAR2(30),
PLATFORM_FOUND VARCHAR2(30) NOT NULL,
GAME_AREA VARCHAR2(20) NOT NULL,
TEST_TYPE VARCHAR2(30) NOT NULL,
PROGRESS_STATUS VARCHAR2(30) NOT NULL,
CREATED_TIME VARCHAR2(30) NOT NULL,
CLOSED_TIME_LOCAL VARCHAR2(30) NOT NULL
);

COMMIT;

-- Add keys for both data integrity and performance
ALTER TABLE bugs
ADD CONSTRAINT buggy PRIMARY KEY(BUG_ID);

ALTER TABLE bughistory
ADD CONSTRAINT bugged PRIMARY KEY(BUG_ID, FULL_DATE);
