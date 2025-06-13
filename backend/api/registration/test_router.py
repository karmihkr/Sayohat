import fastapi
from repositories.test_repository import mongodb


test_router = fastapi.APIRouter()


@test_router.get("/insert")
def test_page_insert():
    mongodb.insert_test_message()
    return {"Status": "Success"}


@test_router.get("/get")
def test_page_get():
    return mongodb.get_test_message()

