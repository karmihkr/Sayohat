import fastapi
from api.registration.test_router import test_router

application = fastapi.FastAPI()
for router in (test_router,):
    application.include_router(router)
