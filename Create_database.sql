-- Host table
CREATE TABLE Hosts (
    hostID SERIAL PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    dateOfBirth DATE,
    phoneNumber VARCHAR(20),
    email VARCHAR(50) UNIQUE
);

-- Neighborhoods table
CREATE TABLE Neighborhoods (
    neighborhoodID SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(25),
    state VARCHAR(2)
);

-- Listings table
CREATE TABLE Listings (
    listingID SERIAL PRIMARY KEY,
    hostID INT,
    propertyType VARCHAR(25),
    price DECIMAL,
    minimumNights INT,
    neighborhoodID INT,
    FOREIGN KEY (hostID) REFERENCES Hosts(hostID),
    FOREIGN KEY (neighborhoodID) REFERENCES Neighborhoods(neighborhoodID)
);

-- Reviews table
CREATE TABLE Reviews (
    reviewID SERIAL PRIMARY KEY,
    listingID INT,
    reviewDate DATE,
    comments TEXT,
    rating INT,
    FOREIGN KEY (listingID) REFERENCES Listings(listingID)
);

--Guests table
CREATE TABLE Guests (
    guestID SERIAL PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    dateOfBirth DATE,
    phoneNumber VARCHAR(20),
    email VARCHAR(50) UNIQUE
);

--Bookings table
CREATE TABLE Bookings (
    bookingID SERIAL PRIMARY KEY,
    listingID INT,
    guestID INT,
    checkin DATE,
    checkout DATE,
    FOREIGN KEY (listingID) REFERENCES Listings(listingID),
    FOREIGN KEY (guestID) REFERENCES Guests(guestID)
);
