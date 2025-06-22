import datetime
import typing

import fastapi
import jwt
from jwt import InvalidTokenError

from settings_manager import settings_manager
from src.api.application_security import OAuth2PasswordRequestForm
from src.api.application_security import oauth2_scheme

registration_router = fastapi.APIRouter()


@registration_router.post("/token")
async def token(standard_request: typing.Annotated[OAuth2PasswordRequestForm, fastapi.Depends()]):
    to_encode = {
        "sub": standard_request.username,
        "exp": datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(minutes=settings_manager.api.token.lifetime_minutes.get())
    }
    encoded_jwt = jwt.encode(to_encode,
                             settings_manager.api.token.key.get(),
                             settings_manager.api.token.algorithm.get())
    return {
        "access_token": encoded_jwt,
        "token_type": "bearer"
    }

@registration_router.get("/sayhi")
async def protected_function(token: typing.Annotated[str, fastapi.Depends(oauth2_scheme)]):
    credential_exception = fastapi.HTTPException(
        status_code=fastapi.status.HTTP_401_UNAUTHORIZED,
        detail="Your credentials are corrupted"
    )
    try:
        encoded = jwt.decode(token, settings_manager.api.token.key.get(), settings_manager.api.token.algorithm.get())
        if not encoded["sub"]:
            raise credential_exception
    except InvalidTokenError:
        raise credential_exception
    return "hi"


