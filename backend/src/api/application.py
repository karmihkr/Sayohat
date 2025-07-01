import fastapi
from src.api.routers.rides_router import rides_router
from src.api.routers.registration_router import registration_router
from src.api.routers.users_router import users_router

application = fastapi.FastAPI()
for router in (rides_router, registration_router, users_router):
    application.include_router(router)
