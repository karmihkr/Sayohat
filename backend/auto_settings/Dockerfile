FROM python:latest
WORKDIR /backend
COPY src /backend/src
COPY auto_settings/requirements.txt /backend/requirements.txt
COPY project_settings.yaml /backend/project_settings.yaml
COPY settings_manager.py /backend/settings_manager.py
RUN pip install --no-cache-dir --upgrade -r /backend/requirements.txt
CMD ["fastapi", "run", "src/api/application.py", "--port", "8000"]
