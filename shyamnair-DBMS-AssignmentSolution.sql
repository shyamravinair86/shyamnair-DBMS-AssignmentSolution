/* create schema `TravelOnTheGo` and use it */
CREATE SCHEMA TravelOnTheGo;
USE TravelOnTheGo;

/* 1) Creat two tables PASSENGER and PRICE with the following attributes and properties */
CREATE TABLE PASSENGER(
	Passenger_Name varchar(50),
    Category varchar(20),
    Gender varchar(1),
    Boarding_City varchar(20),
    Destination_City varchar(20),
    Distance int,
    Bus_Type varchar(20)
);

CREATE TABLE PRICE(
	Bus_Type varchar(20),
    Distance int,
    Price int
);

/* 2) Insert data into both the tables */
INSERT INTO PASSENGER VALUES
('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting'),
('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper'),
('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper'),
('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting'),
('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper'),
('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),
('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

INSERT INTO PRICE VALUES
('Sleeper', 350, 770),
('Sleeper', 500, 1100),
('Sleeper', 600, 1320),
('Sleeper', 700, 1540),
('Sleeper', 1000, 2200),
('Sleeper', 1200, 2640),
('Sleeper', 350, 434),
('Sitting', 500, 620),
('Sitting', 500, 620),
('Sitting', 600, 744),
('Sitting', 700, 868),
('Sitting', 1000, 1240),
('Sitting', 1200, 1488),
('Sitting', 1500, 1860);

/* 3) How many females and how many male passengers travelled for a minimum distance of 600 KMs? */
SELECT Gender, COUNT(GENDER) AS NumberOfTravellers 
FROM PASSENGER 
WHERE Distance >= 600 
GROUP BY GENDER;

/* 4) Find the minimum ticket price for Sleeper Bus. */
SELECT MIN(Price) 
FROM PRICE 
WHERE Bus_Type = 'Sleeper';

/* 5) Select passenger names whose names start with character 'S' */
SELECT Passenger_Name 
FROM PASSENGER 
WHERE Passenger_Name LIKE 'S%';

/* 6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output */ 
SELECT ps.Passenger_Name, ps.Boarding_City, ps.Destination_City, ps.Bus_Type, pr.Price 
FROM PASSENGER ps LEFT JOIN PRICE pr ON ps.Bus_Type = pr.Bus_Type 
WHERE ps.Distance = pr.Distance;

/* 7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KMs */
SELECT Passenger_Name, Price 
FROM PASSENGER ps JOIN PRICE pr ON ps.Distance = pr.Distance AND ps.Bus_Type = pr.Bus_Type
WHERE ps.Bus_Type = 'Sitting'
AND ps.DISTANCE >= 1000;

/* 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji? */
SELECT ps.Passenger_Name, pr.Bus_Type, pr.Price
FROM PASSENGER ps INNER JOIN PRICE pr ON ps.Distance = pr.Distance AND ps.Bus_Type = pr.Bus_Type
WHERE ps.Passenger_Name = 'Pallavi' AND ps.Bus_Type IN ('Sleeper', 'Sitting');

/* 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. */
SELECT Distance 
FROM PASSENGER 
GROUP BY Distance 
HAVING COUNT(Distance) = 1 
ORDER BY Distance DESC;

/* 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables */
SELECT Passenger_Name, FLOOR(( Distance / TotalDistance ) * 100) AS PercentageOfDistance
FROM PASSENGER 
INNER JOIN (SELECT SUM(Distance) AS TotalDistance FROM PASSENGER) AS TOTAL;

/* 11) Display the distance, price in three categories in table Price */
/* a) Expensive if the cost is more than 1000 */
/* b) Average Cost if the cost is less than 1000 and greater than 500 */
/* c) Cheap otherwise */
SELECT Distance, Price,
CASE
WHEN Price >= 1000 THEN 'Expensive'
WHEN Price BETWEEN 500 AND 1000 THEN 'Average Cost'
ELSE 'Cheap' END AS Category
FROM PRICE;
