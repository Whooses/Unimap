from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from db.session import engine, Base
from api.routers import events
from db import init_db

# Initialize the database
init_db()

# Create tables in the database
Base.metadata.create_all(bind=engine)

# Initialize FastAPI app
app = FastAPI()

# Add CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://127.0.0.1:8000", "http://localhost:8000"],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE"],  # Restrict to necessary HTTP methods
)

# Include routers
app.include_router(events.router)
