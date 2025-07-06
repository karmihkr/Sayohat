import datetime
import typing

import fastapi
import jwt
import requests
from fastapi.security import OAuth2PasswordRequestForm
from jwt import InvalidTokenError

from settings_manager import settings_manager
from src.api.application_security import oauth2_scheme
from src.repositories.users_repository import users_repository

registration_router = fastapi.APIRouter()


def check_token(token):
    credential_exception = fastapi.HTTPException(status_code=fastapi.status.HTTP_401_UNAUTHORIZED)
    try:
        encoded = jwt.decode(token, settings_manager.api.token.key, settings_manager.api.token.algorithm)
        if not encoded["sub"]:
            raise credential_exception
    except InvalidTokenError:
        raise credential_exception


@registration_router.post("/token")
async def token(standard_request: typing.Annotated[OAuth2PasswordRequestForm, fastapi.Depends()]):
    to_encode = {
        "sub": standard_request.username,
        "exp": datetime.datetime.now(datetime.timezone.utc) +
        datetime.timedelta(minutes=settings_manager.api.token.lifetime_minutes)
    }
    encoded_jwt = jwt.encode(to_encode,
                             settings_manager.api.token.key,
                             settings_manager.api.token.algorithm)
    return {
        "access_token": encoded_jwt,
        "token_type": "bearer"
    }


@registration_router.post("/hello")
async def hello(token: typing.Annotated[str, fastapi.Depends(oauth2_scheme)]):
    check_token(token)


@registration_router.post("/user_existence")
def user_existence(phone: str):
    response = requests.post(f"{settings_manager.api.host}:{settings_manager.api.port}/token", data={
        "username": phone,
        "password": phone
    })
    response = response.json()
    del response["token_type"]
    response["answer"] = bool(users_repository.get_matching_user(phone=phone))
    return response
