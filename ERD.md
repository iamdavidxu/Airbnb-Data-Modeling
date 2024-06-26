## Entity-Relationship Diagram (ERD)

The following ERD was created based on the provided database:

### Entity Sets

1. **Host**
   - Attributes: hostID, first name, last name, date of birth, phoneNumber, email.

2. **Listing**
   - Attributes: listingID, hostID, propertyType, price, minimumNights, neighborhoodID, host details (first name, last name, date of birth, phone number, email), locationIn details.

3. **Guest**
   - Attributes: guestID, first name, last name, date of birth, phoneNumber, email.

4. **Review**
   - Attributes: reviewID, listingID, reviewDate, comments, rating.

5. **Booking**
   - Attributes: bookingID, listingID, guestID, checkin, checkout.

6. **Neighborhoods**
   - Attributes: neighborhoodID, name, city, state.

### Relationships

- A Listing is associated with one Host, and a Host can have multiple Listings. (1:N relationship between Listing and Host)
- A Guest can make multiple Reviews, and a Review is associated with one Guest. (1:N relationship between Guest and Review)
- A Guest can make multiple Bookings, and a Booking is associated with one Guest. (1:N relationship between Guest and Booking)
- A Listing can have multiple Bookings, and a Booking is associated with one Listing. (1:N relationship between Listing and Booking)
- A Listing is associated with one Neighborhood, and a Neighborhood can have multiple Listings.

![unnamed](https://github.com/iamdavidxu/Airbnb-Data-Modeling/assets/161985636/af38de6b-0b14-45a7-a070-9b94366e3db8)
