--1. Retrive all successful bookings
SELECT * FROM OLA_Bookings
WHERE Booking_Status = 'Success';


--2. Find the average ride distance for each vehicle type
SELECT Vehicle_Type, AVG(Ride_distance) AS AVG_Ride_Dist FROM OLA_Bookings
GROUP BY Vehicle_Type;

--3. Get the total number of canceled rides by customers
SELECT COUNT(*)  FROM OLA_Bookings
WHERE Booking_Status = 'Canceled by Customer';

--4.List the top 5 customers who booked the highest number of rides
SELECT TOP 5 Customer_ID, COUNT(Booking_ID) AS Total_Rides
FROM OLA_Bookings
GROUP BY Customer_ID
ORDER BY  Total_Rides DESC;

--5.Get the number of rides canceled by drivers due to personal and car-related issues
SELECT COUNT(*) FROM OLA_Bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';

--6. Find the maximum and minimum driver ratings for prime Sedam bookings
SELECT  MAX(Driver_Ratings) AS Max_Rating,
MIN(Driver_Ratings) AS Min_Rating
FROM OLA_Bookings WHERE Vehicle_Type = 'prime Sedan';

--7. Retrive all rides where payment was made using UPI
SELECT * FROM OLA_Bookings 
WHERE Payment_Method = 'UPI';

--8. Find the average customer rating per vehicle type
SELECT Vehicle_Type, AVG(Customer_Rating) AS Avg_Customer_Rating
from OLA_Bookings
GROUP BY Vehicle_Type;

--9.Calculate the total booking value of rides completed successfully
SELECT SUM(Booking_value) AS Total_Successful_Value
FROM OLA_Bookings
WHERE Booking_Status = 'Success';

--10 List all incomplete rides along with the reason
SELECT Booking_ID, Incomplete_Rides_Reason 
FROM OLA_Bookings
WHERE Incomplete_Rides = 1;

select * from OLA_Bookings;

