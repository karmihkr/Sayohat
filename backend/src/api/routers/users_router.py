import typing

import fastapi
import jwt
import requests
from jwt import InvalidTokenError

from settings_manager import settings_manager
from src.api.application_security import oauth2_scheme
from src.repositories.users_repository import users_repository

users_router = fastapi.APIRouter()


def check_token(token):
    credential_exception = fastapi.HTTPException(status_code=fastapi.status.HTTP_401_UNAUTHORIZED)
    try:
        encoded = jwt.decode(token, settings_manager.api.token.key, settings_manager.api.token.algorithm)
        if not encoded["sub"]:
            raise credential_exception
    except InvalidTokenError:
        raise credential_exception
    user = users_repository.get_matching_user(phone=encoded["sub"])
    if not user:
        raise credential_exception
    return user


@users_router.get("/user/me")
def read_own_profile(token: typing.Annotated[str, fastapi.Depends(oauth2_scheme)]):
    user = check_token(token)
    user["_id"] = str(user["_id"])
    return user


@users_router.post("/user")
def post_user(phone, name, surname, birth):
    users_repository.insert(phone=phone, name=name, surname=surname, birth=birth)
    return requests.post(f"{settings_manager.api.host}:{settings_manager.api.port}/user_existence",
                         params={"phone": phone}).json()


@users_router.put("/user")
def put_user(phone, name, surname, birth, token: typing.Annotated[str, fastapi.Depends(oauth2_scheme)]):
    user = check_token(token)
    data = {
        "name": name,
        "surname": surname,
        "phone": phone,
        "birth": birth
    }
    users_repository.update(user, data)
