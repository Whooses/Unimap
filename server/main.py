from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from db.session import engine, Base
from routers import users, events, bug_reports, event_reports

from config import CORS_ALLOWED_ORIGINS

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
app.include_router(users.router)
app.include_router(events.router)
app.include_router(event_reports.router)
app.include_router(bug_reports.router)
