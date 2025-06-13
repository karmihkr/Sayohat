import fastapi


test_router = fastapi.APIRouter()


@test_router.get("/registration")
def test_page():
    return {"Said": "Blue Whale"}
