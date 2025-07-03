# 🛣️ HamSafar — Ride-Sharing App for Central Asia

[![Pipeline Status](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/badges/main/pipeline.svg)](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/pipelines)
![Closed Issues](https://img.shields.io/gitlab/issues/closed-raw/d.chegaev/shareyourride?gitlab_url=https%3A%2F%2Fgitlab.pg.innopolis.university&style=flat)
[![Open Issues](https://img.shields.io/badge/Open%20Issues-Dynamic-orange?style=flat)](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/issues)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**HamSafar** is a mobile application designed to simplify intercity ride-sharing across Central Asia. Whether you're a driver with empty seats or a passenger looking for a cost-effective and reliable trip — HamSafar connects you.

[Features](#features) | [How to Run](#how-to-run) | [Authors](#authors) | [License](#license)

## Features

-  **User-friendly ride matching** — Quickly find available rides or passengers nearby.
-  **Multi-language support** — Available in Tajik and English to serve Central Asian users.
-  **Cost-efficient travel** — Share ride costs to save money.
-  **Real-time notifications** — Receive alerts about trip status and updates.
-  **Cross-platform mobile app** — Built with Flutter for smooth performance on Android and iOS.
-  **Fast and reliable backend** — Powered by FastAPI for quick responses and scalability.

## How to Run

1. [Install Flutter](https://docs.flutter.dev/get-started/install?_gl=1*jjmxmh*_ga*MTYwNjk4MTAxNi4xNzQ5MTM4NTk3*_ga_04YGWK0175*czE3NDk4MDA0NTYkbzYkZzEkdDE3NDk4MDA0ODEkajM1JGwwJGgw) for your development platform
2. Run `flutter doctor` in your terminal until requirements are satisfied
3. Clone the repository
4. Configure virtual python environment in `/backend` folder and install `requirements.txt`
5. Start api server from `/backend` with the command `fastapi dev(or run) api/application.py`
6. Execute `flutter --no-color pub get` from the `/frontend` directory
7. Run **/lib/main.dart** to start the application

## Authors
[Arsen Latipov](https://gitlab.pg.innopolis.university/a.latipov) | [Danil Chegaev](https://gitlab.pg.innopolis.university/d.chegaev) | [Karina Krotova](https://gitlab.pg.innopolis.university/k.krotova) | [Sofia Seliutina](https://gitlab.pg.innopolis.university/s.seliutina) | [Varvara Gubanova](https://gitlab.pg.innopolis.university/va.gubanova) | [Anna Morozova](https://gitlab.pg.innopolis.university/an.morozova)

## License
This project is licensed under the MIT License.
