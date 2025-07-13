import typing

import fastapi
import jwt
from jwt import InvalidTokenError

from settings_manager import settings_manager
from src.api.application_security import oauth2_scheme
from src.repositories.places_repository import places_repository

places_router = fastapi.APIRouter()


def check_token(token, _id=None):
    credential_exception = fastapi.HTTPException(status_code=fastapi.status.HTTP_401_UNAUTHORIZED)
    try:
        encoded = jwt.decode(token, settings_manager.api.token.key, settings_manager.api.token.algorithm)
        if not encoded["sub"]:
            raise credential_exception
    except InvalidTokenError:
        raise credential_exception
    if _id:
        place = places_repository.get_matching_place(_id=_id)
        return place


@places_router.post("/place")
async def post_place(longitude: float,
                     latitude: float,
                     country: str,
                     city: str,
                     street: str,
                     _id: str,
                     token: typing.Annotated[str, fastapi.Depends(oauth2_scheme)]):
    place = check_token(token, _id)
    if not place:
        places_repository.insert(longitude=longitude,
                                 latitude=latitude,
                                 country=country,
                                 city=city,
                                 street=street,
                                 _id=_id)
