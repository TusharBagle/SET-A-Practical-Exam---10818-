CREATE DATABASE Practical_Eaxm_10818 ;

USE Practical_Eaxm_10818 ;


CREATE TABLE Deliveries (
	record_id  INTEGER  PRIMARY KEY ,
    month  VARCHAR(50) ,
    route_id  VARCHAR(50) ,
    hub  VARCHAR(50) ,
	promised_days  INTEGER ,
    actual_days  INTEGER 
) ;



CREATE TABLE Routes (
	route_id  VARCHAR(50)  PRIMARY KEY ,
    route  VARCHAR(50) ,
    service_type  VARCHAR(50)
) ;




INSERT INTO Routes 
	VALUES 
		("R1" , "Metro Link" , "Express") ,
		("R2" , "City Dash" , "Express") ,
		("R3" , "Highway Freight" , "Standard") ,
		("R4" , "Rural Feeder" , "Standard") ;
        
        
        
        
INSERT INTO Deliveries
	VALUES 
		(1 , "Jan" , "R1" , "Mumbai" , 2 , 2) ,
		(2 , "Jan" , "R2" , "Chennai" , 3 , 4) ,
		(3 , "Jan" , "R3" , "Delhi" , 5 , 8) ,
		(4 , "Jan" , "R4" , "Mumbai" , 6 , 10) ,
		(5 , "Feb" , "R1" , "Chennai" , 2 , 5) ,
		(6 , "Feb" , "R2" , "Delhi" , 3 , 3) ,
		(7 , "Feb" , "R3" , "Delhi" , 5 , 10) ,
		(8 , "Feb" , "R4" , "Chennai" , 6 , 7) ,
		(9 , "Mar" , "R1" , "Delhi" , 2 , 8) ,
		(10 , "Mar" , "R2" , "Mumbai" , 3 , 5) ,
		(11 , "Mar" , "R3" , "Chennai" , 5 , 5) ,
		(12 , "Mar" , "R4" , "Mumbai" , 6 , 15) ;