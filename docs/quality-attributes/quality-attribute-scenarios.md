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

## 1.2  Interoperability
### Meaning
Interoperability means the ability of our application to interact and exchange data with third-party services, such as Telegram for authentication, Yandex Maps for route visualization, and payment systems.

### Why it is important for our project  
Our ride-sharing app depends on external APIs: for location search, user verification, and secure transactions. Without smooth integration, key features like login or route planning won’t work, which would make the app unusable.

### Quality Scenario  
**Source:** Ride-sharing mobile app integrating third-party APIs  
**Stimulus:** A user registers using a phone number and location services  
**Artifact:** Flutter frontend, Telegram API, Yandex.Maps SDK, backend APIs  
**Environment:** Stable internet connection during user registration and ride creation  
**Response:** System successfully communicates with Telegram and Yandex.Maps to authenticate and display routes  
**Response Measure:** 95% success rate for API responses < 2 seconds; fallback displayed on failure

---

# 2. Security

## 2.1 Authenticity
### Meaning  
Authenticity ensures that each user interacting with the system is who they claim to be. It prevents spoofing or impersonation using secure methods like phone verification or JWT tokens.

### Why it is important for our project  
Our app uses authentication via Telegram and relies on unique phone numbers. To prevent fake accounts and ensure proper user identity, we verify users with secure confirmation codes.

### Quality Scenario  
**Source:** Ride-sharing app  
**Stimulus:** User attempts to log in  
**Artifact:** Backend API (Python), Telegram API, JWT tokens  
**Environment:** Production  
**Response:** User identity is verified via Telegram confirmation code, JWT issued  
**Response Measure:** Token issued within 60 seconds, 100% of valid requests receive code 200  

---

## 2.2 Accountability

### Meaning  
Accountability ensures all user actions are logged and traceable to specific accounts. This helps in tracking misuse, disputes, and fraudulent activities.

### Why it is important for our project  
To resolve conflicts (e.g., no-shows, cancellations), we must store and track ride requests, bookings, and messages. Every action should be auditable.

### Quality Scenario  
**Source:** Application server logs  
**Stimulus:** A user books a ride or cancels it  
**Artifact:** Backend logging system (Python + MongoDB)  
**Environment:** Normal operation  
**Response:** Each user action is logged with user ID, timestamp, and action type  
**Response Measure:** 100% of critical actions are logged and can be retrieved in <2 seconds  

---

## 2.3 Confidentiality

### Meaning  
Confidentiality ensures that sensitive user data (phone number, messages, ride history) is protected from unauthorized access.

### Why it is important for our project  
Our app stores personal information, so any data leak would result in serious consequences for users. We must ensure data is encrypted and securely transmitted.

### Quality Scenario  
**Source:** Backend system storing user info  
**Stimulus:** Data is transmitted between client and server  
**Artifact:** HTTPS protocol, database encryption, token-based access  
**Environment:** Production  
**Response:** Sensitive data remains encrypted in storage and during transit  
**Response Measure:** 100% of data encrypted; no unauthorized access in >99.9% of penetration test scenarios  

---

# 3. Reliability
## 3.1 Faultlessness
### Meaning
Faultlessness - the system's ability to operate without failures when processing valid input data. 
In our project, this means that functions wrapped in try-catch blocks shouldn't generate unhandled 
exceptions under normal operating conditions.

### Why it is important for our project
* Ensures stable application performance for users
* Prevents unexpected interruptions of critical operations
* Reduces the number of critical system errors

### Quality Scenario
**Source:** User submits valid data through form  
**Stimulus:** Valid input from user  
**Artifact:** Python backend API and frontend  
**Environment:** Production at peak hours  
**Response:** Request is processed without exceptions  
**Response Measure:** 100% of requests processed successfully, response time < 1 sec  
**Testing:** Unit tests, load tests (Locust), error monitoring (Sentry)  

## 3.2 Availability
### Meaning
Availability - the system's ability to remain accessible to users even when errors occur. 
Exception handling through try-catch prevents complete system failure.

### Why it is important for our project
* Ensures uninterrupted application operation
* Improves user experience when errors occur
* Allows the system to operate in degraded mode during partial failures

### Quality Scenario
**Source:** User requests data during server issue  
**Stimulus:** Partial backend failure  
**Artifact:** REST API (Spring Boot), Redis cache  
**Environment:** Backend instability  
**Response:** API returns cached data or default error response  
**Response Measure:** 99.9% uptime, critical functions accessible  
**Testing:** Chaos engineering (Simian Army), fallback A/B tests, Grafana monitoring  

## 3.3 Fault Tolerance
### Meaning
Fault Tolerance - the system's ability to properly handle errors and continue operating 
during abnormal situations (invalid data, network failures).

### Why it is important for our project
* Protects against cascading failures
* Ensures system operation during partial outages
* Improves resilience of critical functions

### Quality Scenario
**Source:** Sensor sends corrupted data  
**Stimulus:** Faulty input  
**Artifact:** Gateway API and middleware  
**Environment:** Unstable network  
**Response:** System discards bad packets, remains stable  
**Response Measure:** 100% of corrupted data handled, <50ms delay  
**Testing:** Fuzz testing, network failure simulations  

---