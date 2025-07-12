# Automated Tests

## Tools Overview

| Tool         | Area                    | Why We Chose It                                                                 |
|--------------|-------------------------|----------------------------------------------------------------------------------|
| `flutter_test` | Frontend unit testing   | Officially supported and widely adopted in the Flutter ecosystem; helps test UI components and business logic easily. |
| `unittest`     | Backend integration testing | Part of Python's standard library; simple, stable, and effective for writing maintainable tests that cover backend scenarios. |

---

## QA Testing Summary

To ensure the quality of our product, we implemented both frontend and backend tests using officially supported and widely used tools.

### Frontend Testing

#### Unit Tests

We implemented **10 unit tests** using `flutter_test` to validate UI components and logic in isolation.

**Test files:**
- `add_ride_screen_unit_test.dart`  
- `app_colors_have_value_test.dart`  
- `app_colors_not_null_test.dart`  
- `check_token_actuality_test.dart`  
- `check_vericode_request_id_test.dart`  
- `check_vericode_test.dart`  
- `data_search_model_empty_unit_test.dart`  
- `data_search_model_non_empty_unit_test.dart`  
- `find_ride_screen_unit_test.dart`  
- `ride_model_unit_test.dart`  

These tests focus on:
- Form rendering and input behavior  
- Validation of token logic and verification codes  
- Model data consistency  
- Theme and color correctness  

---

#### Integration Tests

We also added **5 integration tests** to verify widget interaction and component composition.

**Test files:**
- `app_logo_widget_test.dart`  
- `app_name_widget_test.dart`  
- `name_surname_screen_test.dart`  
- `password_forms_test.dart`  
- `welcome_screen_test.dart`  

These tests validate:
- Widget hierarchy  
- User flows (e.g., registration, onboarding)  
- Visual consistency of the application logo and name  

All frontend tests are executed automatically in our **CI pipeline** on every commit or merge request.

Link to the tests: (https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/tree/main/frontend/test?ref_type=heads)

---

### Backend Testing

We created **5 integration tests** using Python’s built-in `unittest` framework. Each test targets real interactions with the system’s core database and configuration logic.

#### Test Files and Coverage:

- `db_matching_user_integration.py`  
   Tests querying users by name, surname, and birthdate via the `users_repository.get_matching_user()` method.

- `db_user_insertion_integration.py`  
   Verifies that user data can be successfully inserted and persisted in the database.

- `settings_manager_database_port_integration.py`  
   Checks how the application reads and applies database port settings from the environment/config.

- `settings_manager_docker_host_integration.py`  
   Ensures correct resolution of Docker host settings in containerized environments.

- `settings_manager_host_integration.py`  
   Validates host configuration selection logic across environments (dev, staging, production).

All backend integration tests simulate **realistic interactions** between modules and rely on actual service logic (e.g., environment variables, repository calls). They're also integrated into our **CI/CD process** to ensure continuous validation.

Link to the tests: (https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/tree/main/backend/test/integration_tests?ref_type=heads)

---

