from pydantic import BaseModel

class UserResponse(BaseModel):
    phone: str
    name: str
    surname: str
    birth: str
