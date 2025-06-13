FROM python:latest
WORKDIR /backend
COPY ./api /backend/api
COPY ./repositories /backend/repositories
COPY ./requirements.txt /backend/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /backend/requirements.txt
CMD ["fastapi", "run", "api/application.py", "--port", "8000"]
