import fastapi
from src.api.routers.rides_router import rides_router

application = fastapi.FastAPI()
for router in (rides_router,):
    application.include_router(router)
