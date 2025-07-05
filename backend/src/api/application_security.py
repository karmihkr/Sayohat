import jwt
from typing import Annotated
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm

from settings_manager import settings_manager
from src.repositories.users_repository import users_repository

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/token")

async def get_current_user_phone(token: Annotated[str, Depends(oauth2_scheme)]) -> str:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(
            token,
            settings_manager.api.token.key,
            algorithms=[settings_manager.api.token.algorithm]
        )
        phone: str = payload.get("sub")
        if phone is None:
            raise credentials_exception
    except jwt.PyJWTError:
        raise credentials_exception

    if not users_repository.get_matching_user(phone=phone):
        raise HTTPException(status_code=404, detail="User not found")
    return phone
