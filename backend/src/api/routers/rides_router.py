import typing

import fastapi
import jwt
from bson import ObjectId
from jwt import InvalidTokenError

from settings_manager import settings_manager
from src.api.application_security import oauth2_scheme
from src.api.routers.users_router import read_own_profile
from src.repositories.places_repository import places_repository
from src.repositories.rides_repository import rides_repository
from src.repositories.users_repository import users_repository

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


@rides_router.get("/rides/{driver_id}")
async def get_matching_rides(driver_id: str,
                             token: typing.Annotated[str, fastapi.Depends(oauth2_scheme)]):
    check_token(token)
    return {
        "rides": [{
            "_id": ride["_id"],
            "driver_name": (driver := users_repository.get_matching_user(_id=ObjectId(ride["driver_id"])))["name"],
            "driver_surname": driver["surname"],
            "driver_phone": driver["phone"],
            "from_country": (from_place := places_repository.get_matching_place(_id=ride["from_place_id"]))["country"],
            "from_city": from_place["city"],
            "from_street": from_place["street"],
            "to_country": (to_place := places_repository.get_matching_place(_id=ride["to_place_id"]))["country"],
            "to_city": to_place["city"],
            "to_street": to_place["street"],
            "year": ride["year"],
            "month": ride["month"],
            "day": ride["day"],
            "hours": ride["hours"],
            "minutes": ride["minutes"],
            "passengers": ride["passengers"],
            "price": ride["price"],
            "description": ride["description"],
            "car_model": ride["car_model"],
            "car_color": ride["car_color"],
            "car_plate": ride["car_plate"]
        } for ride in rides_repository.get_matching_rides(driver_id=driver_id)]
    }
