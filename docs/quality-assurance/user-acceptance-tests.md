# User Acceptance Tests

## 1. Registration and Login
**Given** a new user opens the app,  
**When** they fill out the registration by a number and submit it,  
**Then** they should receive a confirmation code in Telegram and be logged in after entering it.

## 2. Ride Search
**Given** a logged-in user,  
**When** they enter a departure and destination,  
**Then** the app should show available rides matching the criteria using the map and list view.

## 3. Ride Booking
**Given** a passenger finds a suitable ride,  
**When** they press "Book",  
**Then** a booking request should be sent and appear in the driver's app.

## 4. Ride Posting
**Given** a driver wants to post a ride,  
**When** they fill in the ride details,  
**Then** it should be visible to passengers searching in that region.

## 5. Error Handling
**Given** the backend is temporarily unavailable,  
**When** the user tries to search for rides,  
**Then** a friendly error message should be displayed suggesting to try again later.
