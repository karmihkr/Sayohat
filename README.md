[![Pipeline Status](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/badges/main/pipeline.svg)](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/pipelines)
![Closed Issues](https://img.shields.io/gitlab/issues/closed-raw/d.chegaev/shareyourride?gitlab_url=https%3A%2F%2Fgitlab.pg.innopolis.university&style=flat)
[![Open Issues](https://img.shields.io/badge/Open%20Issues-Dynamic-orange?style=flat)](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/issues)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<a id="readme-top"></a>

# HamSafar - Ride-Sharing App for Central Asia

<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="frontend/assets/images/splash-logo.png" alt="Logo" width="350" height="350">
  </a>

  <h3 align="center">HamSafar</h3>

  <p align="center">
    A mobile app that enables convenient and reliable intercity ride-sharing across Central Asia.
    <br />
    <br />
    <a href="https://drive.google.com/drive/folders/1pj8N1K3-Ya_SItcfxOT9mFsYIVfcbQDr?usp=sharing">View Demo</a>
    &middot;
    <a href="https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/releases">Up-to-Date Deployed Version </a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#features">Features</a></li>
        <li><a href="#goals-and-description">Goals and Description</a></li>
                <li><a href="#context-diagram">Context Diagram</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#how-to-run">How to Run</a></li>
    <li>
      <a href="#development">Development</a>
      <ul>
        <li><a href="#kanban-board">Kanban Board</a></li>
        <li><a href="#git-workflow">Git workflow</a></li>
        <li><a href="#secrets-management">Secrets management</a></li>
        <li><a href="#automated-tests">Automated tests</a></li>
        <li><a href="#continuous-integration">Continuous Integration</a></li>
      </ul>
    </li>
    <li><a href="#quality">Quality</a></li>
    <li><a href="#architecture">Architecture</a></li>
    <li><a href="#authors">Authors</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>


## About The Project

### Built With

* [![Python][Python.org]][Python-url]
* [![FastAPI][FastAPI.com]][FastAPI-url]
* [![Flutter][Flutter.dev]][Flutter-url]
* [![Dart][Dart.dev]][Dart-url]
* [![MongoDB][MongoDB.com]][MongoDB-url]
* [![Docker][Docker.com]][Docker-url]
* [![Ubuntu][Ubuntu.com]][Ubuntu-url]
* [![Telegram][Telegram.com]][Telegram-url]
* [![Yandex Maps][Yandex.com]][Yandex-url]

### Features
-  **User-friendly ride matching** - Quickly find available rides or passengers nearby.
-  **Multi-language support** - Available in Tajik, English and Russian to serve Central Asian users.
-  **Cost-efficient travel** - Share ride costs to save money.
-  **Real-time notifications** - Receive alerts about trip status and updates.
-  **Cross-platform mobile app** - Built with Flutter for smooth performance on Android and iOS.
-  **Fast and reliable backend** - Powered by FastAPI for quick responses and scalability.

### Goals and Description

The app makes intercity travel in Central Asia easier by connecting drivers with free seats to passengers looking for affordable and flexible rides. 

*One app — shared trips, lower costs, more freedom.*


### Context Diagram
![diagram](images/ContextDiagram.svg)

**Stakeholders:**
- Passengers — individuals looking for intercity rides
- Drivers — individuals offering empty seats
- Admin — monitors system performance and user reports

**External Systems:**
- Yandex Maps API — used for geolocation and map display
- Telegram Gateway — used to send notifications and verification messages
- MongoDB Atlas — database to store user data and trips
- Timeweb VM (Ubuntu) — hosts the backend and database

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Roadmap

### ✅ Completed Checkpoints

- Flutter project initialized and environment configured  
- UI/UX wireframes and mobile app design created  
- FastAPI backend set up with MongoDB  
- Core API endpoints implemented (trip creation, search, auth)  
- Database connected to backend logic  
- Admin panel features defined and connected  
- User and trip models implemented  
- Edit ride and edit profile screens developed  
- Phone number registration via Telegram implemented  
- Localization added: Tajik (default), Russian, English  
- Backend and frontend integrated  
- Data validation and request structure organized  
- Initial admin panel usage enabled  
- Project structure customized  
- Core debugging and testing completed  
- Yandex.Maps API integrated  

---

### 🚧 Upcoming Checkpoints
- Improve phone number registration security  
- Refactor codebase and improve documentation  
- Prepare production-ready deployment  
- Add analytics and basic admin metrics  
- Expand admin dashboard functionality  
- Implement push notifications  
- Add driver identity verification system  

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## How to Run

1. [Install Flutter](https://docs.flutter.dev/get-started/install?_gl=1*jjmxmh*_ga*MTYwNjk4MTAxNi4xNzQ5MTM4NTk3*_ga_04YGWK0175*czE3NDk4MDA0NTYkbzYkZzEkdDE3NDk4MDA0ODEkajM1JGwwJGgw) for your development platform
2. Run `flutter doctor` in your terminal until requirements are satisfied
3. Clone the repository
4. Configure virtual python environment in `/backend` folder and install `requirements.txt`
5. Start api server from `/backend` with the command `fastapi dev(or run) api/application.py`
6. Execute `flutter --no-color pub get` from the `/frontend` directory
7. Run **/lib/main.dart** to start the application

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Development 

### [CONTRIBUTING.md](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/blob/main/CONTRIBUTING.md?ref_type=heads)

### [Kanban board]((https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/boards))


- **Backlog** - tasks not yet taken into work.
- **To Do** - tasks ready to be worked on.
- **In Progress** - tasks currently being worked on.
- **Done** - completed and tested tasks.

### Git workflow

- `main` - production-ready branch, contains stable and reviewed code.
- `feature/parse-pers-inf` - used for implementing a personal info parser.
- `destructive_backend_injection` - task-specific branch, e.g., for backend experiments or testing.


Rules:

- **Creating Issues:** from predefined templates (see [.gitlab/issue_templates](./.gitlab/issue_templates)).
- **Labelling:** used to define type and priority (e.g., `feature`, `bug`, `P1`).
- **Assigning:** issues are assigned to responsible developers.
- **Branches:** created from `main` with clear, task-specific names (e.g., `destructive_backend_injection`, `feature/parse-pers-inf`).

- **Commit messages:** written in imperative mood, e.g., `Add ride search feature`.
- **Merge Requests:** always linked to an issue, follow our MR template.
- **Code Reviews:** require approval from at least 1 teammate.
- **Merging:** done via squash merge after CI passes and review is complete.
- **Closing Issues:** issues are manually marked as closed by team members in GitLab once the related work is done.

*Git workflow visualization* 
![GitGraph](images/GitGraph.png)

### Secrets management

- All secrets (API keys, etc.) are stored in `project_settings.yaml` file and not committed to the repository.

### Automated tests

- We have implemented **unit tests** and **integration tests**.
- **Backend tests** are located in `/backend/test/integration_tests/`.
- **Frontend unit tests** are located in `/frontend/test/unit_tests/`.
- Testing tools and frameworks are not yet finalized.

### Continuous Integration

- CI workflow file: [.gitlab-ci.yml](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/blob/main/.gitlab-ci.yml?ref_type=heads)
- In CI we use:
  - `pycodestyle` - for Python static code analysis.
  - `pytest` - to run backend tests.
  - `flutter test` - to run frontend tests.
- All CI runs can be viewed [here](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/pipelines).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Quality

#### [Quality characteristics and quality attribute scenarios](docs/quality-attributes/quality-attribute-scenarios.md)
#### Quality assurance
- [Automated tests](docs/quality-assurance/automated-tests.md)
- [User acceptance tests](docs/quality-assurance/user-acceptance-tests.md)
#### Build and deployment automation
- [Continuous Integration](docs/automation/continuous-integration.md)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Architecture

### [Tech Stack](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/blob/main/docs/architecture/architecture.md?ref_type=heads)

### [Static view](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/tree/main/docs/architecture/static-view?ref_type=heads)

Currently, the system has the following modules:
- **Flutter app** (Dart) running on mobile devices (Android/iOS)
- **Backend API**, implemented in our chosen server technology
- **MongoDB** database

[Link to the diagram](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/blob/main/docs/architecture/static-view/Component%20Diagram.png)

---

### [Dynamic view](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/tree/main/docs/architecture/dynamic-view?ref_type=heads)

Example flow: **user creates & confirms a ride**
1. Flutter app sends request to FastAPI backend.
2. Backend validates data and writes to MongoDB.
3. A confirmation message is sent via external service.
4. Upon confirmation, backend updates ride status in DB.
5. Optional notification sent to driver/passenger.

[Link to the diagram](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/blob/main/docs/architecture/dynamic-view/Sequence%20Diagram.png)

---

### [Deployment view](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/tree/main/docs/architecture/deployment-view?ref_type=heads)

Current state:
- All components are containerized from the beginning.
- Flutter app is developed locally and has not yet been published to Google Play / App Store.

[Link to the diagram](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/blob/main/docs/architecture/deployment-view/Deployment%20diagram.png)

Improvement areas:
- Separate concerns in backend (routes, logic, DB)
- Automate deployment (CI)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Authors
[Arsen Latipov](https://gitlab.pg.innopolis.university/a.latipov) | [Danil Chegaev](https://gitlab.pg.innopolis.university/d.chegaev) | [Karina Krotova](https://gitlab.pg.innopolis.university/k.krotova) | [Sofia Seliutina](https://gitlab.pg.innopolis.university/s.seliutina) | [Varvara Gubanova](https://gitlab.pg.innopolis.university/va.gubanova) | [Anna Morozova](https://gitlab.pg.innopolis.university/an.morozova)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License
This project is licensed under the [MIT License](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/blob/main/LICENSE?ref_type=heads).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->


[Python.org]: https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white
[Python-url]: https://www.python.org/

[FastAPI.com]: https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white
[FastAPI-url]: https://fastapi.tiangolo.com/

[Flutter.dev]: https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white
[Flutter-url]: https://flutter.dev/

[Dart.dev]: https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white
[Dart-url]: https://dart.dev/

[MongoDB.com]: https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white
[MongoDB-url]: https://www.mongodb.com/

[Docker.com]: https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white
[Docker-url]: https://www.docker.com/

[Ubuntu.com]: https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white
[Ubuntu-url]: https://ubuntu.com/

[Telegram.com]: https://img.shields.io/badge/Telegram-26A5E4?style=for-the-badge&logo=telegram&logoColor=white
[Telegram-url]: https://core.telegram.org/bots

[Yandex.com]: https://img.shields.io/badge/Yandex.Maps-FF0000?style=for-the-badge&logo=yandex&logoColor=white
[Yandex-url]: https://yandex.com/dev/maps/