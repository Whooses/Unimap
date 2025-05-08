from fastapi import Depends
from fastapi.security import OAuth2PasswordBearer
from .service import AuthService

# This tells FastAPI to expect a token in the Authorization header
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")  # tokenUrl is required but not actually used by Auth0

def get_current_user(token: str = Depends(oauth2_scheme)):
    return AuthService.verify_token(token)
