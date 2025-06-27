import fastapi

from src.api.responses.rides_responsies import RideCreatedSuccessfully, RideQueriedSuccessfully
from src.repositories.rides_repository import rides_repository

rides_router = fastapi.APIRouter()


@rides_router.post("/new/ride")
async def new_ride(driver_id: int,
                   begin_id: int,
                   end_id: int,
                   price: int,
                   available_places: int,
                   vehicle_number: str):
    rides_repository.insert(driver_id=driver_id,
                            begin_id=begin_id,
                            end_id=end_id,
                            price=price,
                            available_places=available_places,
                            vehicle_number=vehicle_number)
    return RideCreatedSuccessfully()


@rides_router.get("/ride")
async def find_matching_ride(driver_id: int | None = None,
                             begin_id: int | None = None,
                             end_id: int | None = None,
                             price: int | None = None,
                             available_places: int | None = None,
                             vehicle_number: str | None = None):
    json = rides_repository.get_matching_ride(price=price)
    return RideQueriedSuccessfully(json)


@rides_router.get("/rides")
async def find_matching_rides(driver_id: int | None = None,
                              begin_id: int | None = None,
                              end_id: int | None = None,
                              price: int | None = None,
                              available_places: int | None = None,
                              vehicle_number: str | None = None):
    json = rides_repository.get_matching_rides(price=price)
    return RideQueriedSuccessfully(json)
