# 1. Compatibility 
## 1.1 Co-existence
### Meaning
Co-existence means that our Flutter app should coexist peacefully with other apps installed on the same 
device — without interfering with them, without overloading the system, and without conflicting with background services. 
Also especially important that our app is multi-platform and runs on Android, iOS, and Windows.

### Why it is important for our project
Users will use our app on different devices, and they will simultaneously use messengers, browsers, cameras, etc. 
If our app starts to freeze, slow down, or interfere with other programs, it will ruin the user experience. 
It can also lead to the deletion of the app or bad reviews.

### Quality Scenario
**Source:** User running the application on Android or Windows  
**Stimulus:** Simultaneous use of the Flutter application alongside other popular apps (e.g., Telegram, Chrome, Word)  
**Artifact:** Cross-platform app developed with Flutter  
**Environment:** Android 12 device or Windows 11 laptop  
**Response:** App operates normally without freezing or affecting performance of other apps  
**Response Measure:** CPU usage < 25%, memory usage < 500 MB; no crashes in 9 out of 10 test runs
**Testing:** Performance tests using Flutter driver, memory profiling tools

## 1.2  Interoperability
### Meaning
Interoperability means the ability of our application to interact and exchange data with third-party services,
such as Telegram for authentication, Yandex Maps for route visualization, and payment systems.

### Why it is important for our project  
Our ride-sharing app depends on external APIs: for location search, user verification, and secure transactions. 
Without smooth integration, key features like login or route planning won’t work, which would make the app unusable.

### Quality Scenario  
**Source:** Ride-sharing mobile app integrating third-party APIs  
**Stimulus:** A user registers using a phone number 
**Artifact:** Flutter frontend, Telegram API, Yandex.Maps SDK, backend APIs  
**Environment:** Stable internet connection during user registration and ride creation  
**Response:** System successfully communicates with Telegram and Yandex.Maps to authenticate and display routes  
**Response Measure:** 95% success rate for API responses < 2 seconds; fallback displayed on failure
**Testing:** Integration tests using mocks for Telegram API and Yandex.Maps SDK

---

# 2. Security

## 2.1 Authenticity
### Meaning  
Authenticity ensures that each user interacting with the system is who they claim to be. 
It prevents spoofing or impersonation using secure methods like phone verification.

### Why it is important for our project  
Our app uses authentication via Telegram and relies on unique phone numbers. To prevent 
fake accounts and ensure proper user identity, we verify users with secure confirmation codes.

### Quality Scenario  
**Source:** Ride-sharing app  
**Stimulus:** User attempts to log in  
**Artifact:** Backend API (Python), Telegram API 
**Environment:** Production  
**Response:** User identity is verified via Telegram confirmation code
**Response Measure:** Token issued within 60 seconds, 100% of valid requests receive code 200
**Testing:** Automated tests with mocked Telegram responses, unit tests for auth logic using `unittest`, and manual login flow validation in staging.


---

## 2.2 Accountability

### Meaning  
Accountability - degree to which the actions of an entity can be traced uniquely to the entity. 
Ensures all user actions are logged and traceable to specific accounts. 

### Why it is important for our project  
To resolve conflicts (e.g., no-shows, cancellations), we must store and track ride requests, 
bookings, and messages. Every action should be auditable.

### Quality Scenario  
**Source:** Application server logs  
**Stimulus:** A user books a ride or cancels it  
**Artifact:** Backend logging system (Python + MongoDB)  
**Environment:** Normal operation  
**Response:** Each user action is logged with user ID, timestamp, and action type  
**Response Measure:** 100% of critical actions are logged and can be retrieved in <2 seconds  
**Testing:** Integration tests verifying log creation after key actions (booking, canceling), MongoDB log checks, and log-retrieval latency testing with Python scripts.

---

## 2.3 Confidentiality

### Meaning  
Confidentiality ensures that sensitive user data is protected from unauthorized access.

### Why it is important for our project  
Our app stores personal information, so any data leak would result in serious consequences for users. We must ensure data is 
encrypted and securely transmitted.

### Quality Scenario  
**Source:** Backend system storing user info  
**Stimulus:** Data is transmitted between client and server  
**Artifact:** HTTPS protocol, database encryption, token-based access  
**Environment:** Production  
**Response:** Sensitive data remains encrypted in storage and during transit  
**Response Measure:** 100% of data encrypted; no unauthorized access in >99.9% of penetration test scenarios  
**Testing:** Manual and automated security tests

---

# 3. Reliability
## 3.1 Faultlessness
### Meaning
Faultlessness is the system's ability to process valid input without failures.  

### Why it is important for our project
* Ensures stable application performance for users
* Prevents unexpected interruptions of critical operations
* Reduces the number of critical system errors

### Quality Scenario
**Source:** User performs a ride search or registration  
**Stimulus:** Enters valid input data  
**Artifact:** Python backend API and Flutter frontend  
**Environment:** Normal production environment  
**Response:** The request is processed successfully with no exceptions  
**Response Measure:** 100% of valid requests are completed successfully; response time < 1 second  
**Testing:** Unit and integration tests covering all main use cases    

## 3.2 Availability
### Meaning
Availability - the system's ability to remain accessible to users even when errors occur. 
Exception handling through try-catch prevents complete system failure.

### Why it is important for our project
* Ensures uninterrupted application operation
* Improves user experience when errors occur
* Allows the system to operate in degraded mode during partial failures

### Quality Scenario
**Source:** User opens the app  
**Stimulus:** One of the services (e.g., database) is temporarily unavailable  
**Artifact:** Backend API, Redis cache, Flutter frontend  
**Environment:** Partial system outage (e.g., DB failure)  
**Response:** The app still functions, either using cached data or displaying an understandable error  
**Response Measure:** Uptime ≥ 99.9%; critical features remain accessible  
**Testing:** Failure simulation tests   

## 3.3 Fault Tolerance
### Meaning
Fault Tolerance - the system's ability to properly handle errors and continue operating 
during abnormal situations (invalid data, network failures).

### Why it is important for our project
* Protects against cascading failures
* Ensures system operation during partial outages
* Improves resilience of critical functions

### Quality Scenario
**Source:** User submits a form with invalid input or during poor network conditions  
**Stimulus:** The system receives incorrect or incomplete data  
**Artifact:** Backend and frontend  
**Environment:** Unstable internet connection  
**Response:** The system responds with a clear error message and does not crash  
**Response Measure:** 100% of invalid inputs are handled gracefully with user-friendly errors  
**Testing:** Tests using invalid data, network disconnection scenarios, and mocked APIs  

---