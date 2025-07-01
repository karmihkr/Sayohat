import fastapi
import requests

from settings_manager import settings_manager
from src.repositories.users_repository import users_repository

users_router = fastapi.APIRouter()


@users_router.post("/user")
def insert(phone, name, surname, birth):
    users_repository.insert(phone=phone, name=name, surname=surname, birth=birth)
    return requests.post(f"{settings_manager.api.host}:{settings_manager.api.port}/user_existence",
                         params={"phone": phone}).json()
