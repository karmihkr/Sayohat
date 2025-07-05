import fastapi
import jwt
import requests

from settings_manager import settings_manager
from src.repositories.users_repository import users_repository
from typing import Annotated
from fastapi import Depends, HTTPException
from src.api.application_security import oauth2_scheme
from fastapi import Depends, HTTPException

users_router = fastapi.APIRouter()


@users_router.post("/user")
def insert(phone, name, surname, birth):
    users_repository.insert(phone=phone, name=name, surname=surname, birth=birth)
    return requests.post(f"{settings_manager.api.host}:{settings_manager.api.port}/user_existence",
                         params={"phone": phone}).json()

@users_router.get("/user/me")
def read_own_profile(token: Annotated[str, Depends(oauth2_scheme)]):
    try:
        payload = jwt.decode(
            token,
            settings_manager.api.token.key,
            algorithms=[settings_manager.api.token.algorithm],
        )
        phone = payload.get("sub")
        if phone is None:
            raise ValueError
    except Exception:
        raise HTTPException(status_code=401, detail="Invalid authentication token")
    user = users_repository.get_matching_user(phone=phone)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user["_id"] = str(user["_id"])
    return user
