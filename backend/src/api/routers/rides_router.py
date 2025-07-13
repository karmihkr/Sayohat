import typing

import fastapi
import jwt
from jwt import InvalidTokenError

from settings_manager import settings_manager
from src.api.application_security import oauth2_scheme
from src.api.routers.users_router import read_own_profile
from src.repositories.rides_repository import rides_repository

rides_router = fastapi.APIRouter()


def check_token(token):
    credential_exception = fastapi.HTTPException(status_code=fastapi.status.HTTP_401_UNAUTHORIZED)
    try:
        encoded = jwt.decode(token, settings_manager.api.token.key, settings_manager.api.token.algorithm)
        if not encoded["sub"]:
            raise credential_exception
    except InvalidTokenError:
        raise credential_exception


@rides_router.post("/ride")
async def post_ride(from_place_id: str,
                    to_place_id: str,
                    year: int,
                    month: int,
                    day: int,
                    passengers: int,
                    hours: int,
                    minutes: int,
                    price: float,
                    description: str,
                    car_model: str,
                    car_color: str,
                    car_plate: str,
                    token: typing.Annotated[str, fastapi.Depends(oauth2_scheme)]):
    rides_repository.insert(driver_id=read_own_profile(token)["_id"],
                            from_place_id=from_place_id,
                            to_place_id=to_place_id,
                            year=year,
                            month=month,
                            day=day,
                            passengers=passengers,
                            hours=hours,
                            minutes=minutes,
                            price=price,
                            description=description,
                            car_model=car_model,
                            car_color=car_color,
                            car_plate=car_plate)


# @rides_router.get("/ride")
# async def find_matching_ride(driver_id: int | None = None,
#                              begin_id: int | None = None,
#                              end_id: int | None = None,
#                              price: int | None = None,
#                              available_places: int | None = None,
#                              vehicle_number: str | None = None):
#     json = rides_repository.get_matching_ride(price=price)
#
#
