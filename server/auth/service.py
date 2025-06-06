from jose import jwt, JWTError
from fastapi import HTTPException, status
import httpx
from config import AUTH0_DOMAIN, API_AUDIENCE, ALGORITHMS

class AuthService:
    @staticmethod
    async def _get_jwks():
        """Fetches the JSON Web Key Set (JWKS) from Auth0 asynchronously."""
        jwks_url = f"https://{AUTH0_DOMAIN}/.well-known/jwks.json"
        async with httpx.AsyncClient() as client:
            response = await client.get(jwks_url)
            response.raise_for_status()
            return response.json()["keys"]

    @staticmethod
    async def _get_signing_key(token: str):
        """Extracts the signing key from the token's header and matches it with the JWKS."""
        unverified_header = jwt.get_unverified_header(token)
        jwks = await AuthService._get_jwks()
        for key in jwks:
            if key["kid"] == unverified_header["kid"]:
                return {
                    "kty": key["kty"],
                    "kid": key["kid"],
                    "use": key["use"],
                    "n": key["n"],
                    "e": key["e"]
                }
        raise HTTPException(status_code=401, detail="Invalid signing key")

    @staticmethod
    async def verify_token(token: str):
        """Verifies the JWT token and returns the payload if valid."""
        try:
            key = await AuthService._get_signing_key(token)
            payload = jwt.decode(
                token,
                key,
                algorithms=ALGORITHMS,
                audience=API_AUDIENCE,
                issuer=f"https://{AUTH0_DOMAIN}/"
            )
            return payload  # This will be a dict of user info
        except JWTError as e:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail=f"Invalid token: {str(e)}",
                headers={"WWW-Authenticate": "Bearer"},
            )
