## 1. Overview

**ShareYourRide** is a ridesharing platform designed for intercity travel, connecting passengers and drivers across Central Asia. The system supports multilingual usage (Tajik, Russian, English), secure user management, and admin control.

The platform includes:
- A mobile client (Flutter)
- A backend server (FastAPI)
- A MongoDB database
- An admin web interface

## 2. Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: FastAPI (Python)
- **Database**: MongoDB (NoSQL)
- **CI/CD**: GitLab CI
- **Containerization**: Docker, Docker Compose
- **Localization**: i18n (Tajik, Russian, English)
- **Maps Integration**: Yandex.Maps API
- **Testing**: Pytest (unit and integration tests)
- **Authentication**: OAuth2, Token-based

## 3. Static View

- **Frontend App (Flutter)**: Screens, State Management, API communication
- **Admin Panel (Web)**: User and Trip Management
- **Backend API**:
  - `auth`: login, token handling
  - `users`: registration, profile management
  - `trips`: create/search rides
- **Database Models**:
  - `User`
  - `Trip`
  - `Admin`

Files structure is divided by domain and responsibility. Each domain (e.g., users, trips) contains its own endpoints, schemas, and logic.

---
![staticview](/docs/architecture/ComponentDiagram.png)

## 4. Dynamic View

### Example: User Registration

1. User opens registration screen in the mobile app.
2. Enters phone number and submits form.
3. Backend verifies/creates user, issues token.
4. Token is stored locally and used in future requests.
---

![dynamic](\shareyourride\docs\architecture\dynamic-view\SequenceDiagram.png)

## Deployment View

### Current Architecture

The system follows a **containerized microservice-like architecture**, where each main component is deployed inside a dedicated Docker container.

- **Flutter App**: Currently developed and tested locally. Not yet deployed to Google Play or App Store.
- **Admin Panel**: A lightweight web interface developed for administrative control. Currently hosted locally.
- **API Gateway**: Serves as the single entry point for all clients (mobile and admin), handling routing, OAuth2-based authentication, and language localization.
- **Backend**: Built with FastAPI. Implements core features such as user management, trip operations, and admin capabilities.
- **Database**: MongoDB stores all application-related data including users, trips, and admin records.

All services are containerized and orchestrated using `docker-compose`.

![deployment](\shareyourride\docs\architecture\deployment-view\Deploymentdiagram.png)