FROM python:latest
WORKDIR /backend
COPY ../src /backend/src
COPY ./requirements.txt /backend/requirements.txt
COPY ../project_settings.yaml /backend/project_settings.yaml
RUN pip install --no-cache-dir --upgrade -r /backend/requirements.txt
CMD ["fastapi", "run", "api/application.py", "--port", "8000"]
