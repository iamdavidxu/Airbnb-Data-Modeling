-- Q1: How many properties are currently listed in Seattle from March 14th to 18th? (Traveler)
SELECT COUNT(DISTINCT l.listingID) AS Properties
FROM Listings l
JOIN Neighborhoods n ON l.neighborhoodID = n.neighborhoodID
JOIN Bookings b ON l.listingID = b.listingID
WHERE n.city = 'Seattle' 
AND ((b.checkin BETWEEN '2023-03-14' AND '2023-03-18') OR (b.checkout BETWEEN '2023-03-14' AND '2023-03-18'));

-- Q2: What is the average price of listings in Seattle? (Market Researcher)
SELECT ROUND(AVG(price), 2) AS average_price
FROM Listings l
JOIN Neighborhoods n ON l.neighborhoodID = n.neighborhoodID
WHERE n.city = 'Seattle';

-- Q3: What’s the most popular neighborhood in terms of listings? (Market Researcher)
SELECT n.name, COUNT(l.listingID) AS total_listings
FROM Listings l
JOIN Neighborhoods n ON l.neighborhoodID = n.neighborhoodID
GROUP BY n.name
ORDER BY total_listings DESC
LIMIT 1;

-- Q4: What neighborhood in Seattle has the highest average rating? (Traveler)
SELECT n.name, ROUND(AVG(r.rating), 2) AS average_rating
FROM Reviews r
JOIN Listings l ON r.listingID = l.listingID
JOIN Neighborhoods n ON l.neighborhoodID = n.neighborhoodID
WHERE n.city = 'Seattle'
GROUP BY n.name
ORDER BY average_rating DESC
LIMIT 1;

--Q5: What is the best monetarily performing listing a host has?
select  h.hostID, h.firstName, h.lastName, l.listingID, l.propertyType,
    max(l.price * b.total_bookings) as total_income
from Hosts h
join Listings l on h.hostID = l.hostID
join 
    (select listingID, count(bookingID) as total_bookings
     from Bookings
     group by listingID) b on l.listingID = b.listingID
group by h.hostID, l.listingID
order by h.hostID, total_income desc;

--Q6: What is the difference between the number of 5 star reviews and number of 1 star reviews for a specific property?
select listingID,  (select count (*) from Reviews where rating = 5 and listingID = r.listingID) as five_star_reviews, (select count (*) from Reviews where rating = 1 and listingID = r.listingID) as one_star_reviews,
    ((select count(*) from Reviews where rating = 5 and listingID = r.listingID) - 
    (select count(*) from Reviews where rating = 1 and listingID = r.listingID)) as difference
from Reviews r
where listingID = listingID 
group by listingID;

--Q7: What is the average price of listing for a 3 night stay in a specific city(Seattle)? (Traveler)
	SELECT AVG(price) AS average
	FROM Listings AS l, Neighborhoods AS n
	WHERE l.neighborhoodID = n.neighborhoodID
AND l.minimumNights = 3
	AND n.city = 'Seattle';
	
--Q8: What is the average age of guests who make a booking in a specific city(Seattle)? (Market Researcher)
	WITH Age AS(
		SELECT b.listingID, EXTRACT(YEAR FROM AGE(b.checkin, g.dateOfBirth)) AS age
		FROM Bookings b, Guests g
		WHERE b.guestID = g.guestID
)
SELECT AVG(age) AS averageAge
FROM Age a
JOIN Listings l ON a.listingID = l.listingID
JOIN Neighborhoods n ON l.neighborhoodID = n.neighborhoodID
WHERE n.city = 'Seattle';

--Q9: How many reviews does each listing have? (Traveler)
SELECT listingid, count(rating) as number_of_reviews
FROM reviews
GROUP BY listingid;

--Q10: Can I see a list of all properties hosted by a specific host? (Property Manager)
SELECT *
FROM listings
WHERE hostid = '1';

-- Insert resonable data into the database to answer some of the proposed questions
-- Insert statements:
INSERT INTO Neighborhoods (neighborhoodID, name, city, state) VALUES
(1, 'Ballard', 'Seattle', 'WA'),
(2, 'Fremont', 'Seattle', 'WA'),
(3, 'Capitol Hill', 'Seattle', 'WA'),
(4, 'Spokane', 'Spokane', 'WA'),
(5, 'Tacoma', 'Tacoma', 'WA');

INSERT INTO Hosts (hostID, firstName, lastName, dateOfBirth, phoneNumber, email) VALUES
(1, 'Alice', 'Smith', '1985-02-10', '555-0101', 'alice.smith@example.com'),
(2, 'Bob', 'Johnson', '1978-07-24', '555-0102', 'bob.johnson@example.com'),
(3, 'Carol', 'Davis', '1990-05-16', '555-0103', 'carol.davis@example.com');

INSERT INTO Listings (listingID, hostID, propertyType, price, minimumNights, neighborhoodID) VALUES
(1, 1, 'Apartment', 120.00, 2, 1),
(2, 1, 'House', 250.00, 3, 2),
(3, 2, 'Condo', 150.00, 1, 2),
(4, 2, 'Loft', 90.00, 2, 3),
(5, 3, 'Apartment', 110.00, 3, 4),
(6, 3, 'Townhouse', 135.00, 2, 5);

INSERT INTO Guests (guestID, firstName, lastName, dateOfBirth, phoneNumber, email) VALUES
(1, 'John', 'Doe', '1992-03-15', '555-0201', 'john.doe@example.com'),
(2, 'Jane', 'Roe', '1989-07-28', '555-0202', 'jane.roe@example.com'),
(3, 'Jim', 'Beam', '1990-11-05', '555-0203', 'jim.beam@example.com'),
(4, 'Jill', 'Hill', '1993-05-19', '555-0204', 'jill.hill@example.com'),
(5, 'Jack', 'Gill', '1985-01-22', '555-0205', 'jack.gill@example.com');

INSERT INTO Bookings (bookingID, listingID, guestID, checkin, checkout) VALUES
(1, 1, 1, '2023-03-01', '2023-03-05'),
(2, 5, 2, '2023-03-20', '2023-03-25'),
(3, 4, 3, '2023-03-10', '2023-03-12'),
(4, 2, 4, '2023-03-14', '2023-03-18'),
(5, 3, 5, '2023-03-14', '2023-03-18');

INSERT INTO Reviews (reviewID, listingID, reviewDate, comments, rating) VALUES
(1, 1, '2023-03-06', 'Great location, had everything we needed!', 5),
(2, 2, '2023-03-26', 'Spacious and clean, but a bit noisy at night.', 4),
(3, 3, '2023-03-13', 'Cozy and comfortable, with a fantastic view.', 5),
(4, 4, '2023-02-28', 'Modern design, but the wifi was slow.', 3),
(5, 5, '2023-04-11', 'Perfect for our family, very welcoming hosts.', 5);


-- Demo query: What is the average age of guests who make a booking in a specific city(Seattle)?
-- The average age of guests who book airbnb appears to be 32.25.
	WITH Age AS(
		SELECT b.listingID, EXTRACT(YEAR FROM AGE(b.checkin, g.dateOfBirth)) AS age
		FROM Bookings b, Guests g
		WHERE b.guestID = g.guestID
)
SELECT AVG(age) AS averageAge
FROM Age a
JOIN Listings l ON a.listingID = l.listingID
JOIN Neighborhoods n ON l.neighborhoodID = n.neighborhoodID
WHERE n.city = 'Seattle';
