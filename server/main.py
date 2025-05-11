from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from db.session import engine, Base
from api.routers import events, favourites
# from db import init_db

from config import CORS_ALLOWED_ORIGINS

# Initialize the database
# init_db()

# Create tables in the database
Base.metadata.create_all(bind=engine)

# Initialize FastAPI app
app = FastAPI()

# Add CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=CORS_ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE"],  # Restrict to necessary HTTP methods
)

# Include routers
app.include_router(events.router)
app.include_router(favourites.router)
