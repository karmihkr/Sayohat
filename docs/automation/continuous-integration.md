# Continuous Integration (CI)

This project uses **GitLab CI/CD** to automate code quality checks and testing for both the backend (FastAPI) and the frontend (Flutter). CI runs on every commit and merge request to ensure code consistency and correctness.

---

## CI Pipeline Overview

The CI process is divided into several stages:

### 1. `.pre` – Code Style & Linting

- **Purpose**: Ensure Python code follows PEP8 standards.  
- **Tool**: `pycodestyle` (via custom linter script).  
- **Execution**:
  ```bash
  pip install pycodestyle
  python backend/test/linter.py

### 2. `test` - Backend & Frontend Tests
 **Backend Tests (FastAPI)**
- Runs in: `python:latest` Docker container
- Setup:
    - Installs packages from requirements.txt
    - Runs placeholder command (to be replaced with real tests):


```
pip install -r backend/auto_settings/requirements.txt
echo "Here tests will be run"
```

**Frontend Tests (Flutter)**
- Runs in: `instrumentisto/flutter:latest` Docker container
- Steps:
    - Navigate to the Flutter project:
 
        ```
        cd frontend/lib
        touch project_settings.yaml
        cat project_settings.dart.example >> project_settings.dart
        cd ..
        flutter test
        ```

## Technologies Used

| Component        | Tool                                           |
| ---------------- | ---------------------------------------------- |
| CI Platform      | GitLab CI                                      |
| Linting          | pycodestyle                                    |
| Backend Testing  | Python / pytest                     |
| Frontend Testing | Flutter / flutter test                         |
| Docker Images    | python\:latest, instrumentisto/flutter\:latest |
