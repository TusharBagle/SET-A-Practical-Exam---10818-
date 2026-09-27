
        
        
    
-- 1. Total delay_days by service type
SELECT
	R.service_type ,
	SUM( 
		CASE
			WHEN actual_days > promised_days THEN actual_days - promised_days
			ELSE 0
		END 
	) AS Delay_Days
FROM Deliveries D
JOIN Routes R 
	ON D.route_id = R.route_id
GROUP BY R.service_type
ORDER BY Delay_Days DESC ;



-- 2. Routes with significant delay
SELECT
	R.route_id ,
	R.route ,
	SUM( 
		CASE
			WHEN actual_days > promised_days THEN actual_days - promised_days
			ELSE 0
		END 
	) AS Significant_Delay_Days
FROM Deliveries D
JOIN Routes R 
	ON D.route_id = R.route_id
GROUP BY R.route_id , R.route
HAVING Significant_Delay_Days > 8 
ORDER BY Significant_Delay_Days DESC ;



-- 3. Top two hubs by delay
SELECT
	D.hub ,
	SUM( 
		CASE
			WHEN actual_days > promised_days THEN actual_days - promised_days
			ELSE 0
		END 
	) AS Delay_Days
FROM Deliveries D
JOIN Routes R 
	ON D.route_id = R.route_id
GROUP BY D.hub
ORDER BY Delay_Days DESC
LIMIT 2 ;



-- 4. Diagnostic Query
SELECT D.route_id
FROM Deliveries D
LEFT JOIN Routes R
    ON D.route_id = R.route_id
WHERE R.route_id IS NULL ;