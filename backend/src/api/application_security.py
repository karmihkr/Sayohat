from fastapi.security import OAuth2PasswordBearer
from fastapi.security import OAuth2PasswordRequestForm

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/token")
