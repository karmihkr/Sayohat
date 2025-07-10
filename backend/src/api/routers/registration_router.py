import datetime
import typing

import fastapi
import jwt
import requests
from fastapi.security import OAuth2PasswordRequestForm
from jwt import InvalidTokenError

from settings_manager import settings_manager
from src.api.application_security import oauth2_scheme

registration_router = fastapi.APIRouter()


def check_token(token):
    credential_exception = fastapi.HTTPException(status_code=fastapi.status.HTTP_401_UNAUTHORIZED)
    try:
        encoded = jwt.decode(token, settings_manager.api.token.key, settings_manager.api.token.algorithm)
        if not encoded["sub"]:
            raise credential_exception
    except InvalidTokenError:
        raise credential_exception


@registration_router.post("/telegram_verification")
async def end_telegram_verification(code: str, request_id: str):
    response = requests.post(settings_manager.telegram.check_verification_url, params={
        "request_id": request_id, "code": code
    }, headers={
        "Authorization": f"Bearer {settings_manager.telegram.key}",
        "Content-Type": "application/json",
    })
    if response.status_code != 200:
        raise fastapi.HTTPException(status_code=response.status_code, detail=response.reason)
    response = response.json()
    try:
        if response["result"]["verification_status"]["status"] != "code_valid":
            raise fastapi.HTTPException(status_code=fastapi.status.HTTP_417_EXPECTATION_FAILED)
    except KeyError:
        raise fastapi.HTTPException(status_code=fastapi.status.HTTP_204_NO_CONTENT)
    return {
        "result": True
    }


@registration_router.post("/token")
async def token(standard_request: typing.Annotated[OAuth2PasswordRequestForm, fastapi.Depends()],
                side_verification_success: typing.Annotated[bool, fastapi.Depends(end_telegram_verification)]):
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


@registration_router.get("/telegram_verification")
async def begin_telegram_verification(phone: str):
    response = requests.post(settings_manager.telegram.send_verification_url, params={
        "phone_number": phone, "code_length": "4"
    }, headers={
        "Authorization": f"Bearer {settings_manager.telegram.key}",
        "Content-Type": "application/json",
    })
    if response.status_code != 200:
        raise fastapi.HTTPException(status_code=response.status_code, detail=response.reason)
    response = response.json()
    try:
        if response["result"]["delivery_status"]["status"] != "sent":
            raise fastapi.HTTPException(status_code=fastapi.status.HTTP_417_EXPECTATION_FAILED)
    except KeyError:
        raise fastapi.HTTPException(status_code=fastapi.status.HTTP_204_NO_CONTENT)
    return {
        "request_id": response["result"]["request_id"]
    }
