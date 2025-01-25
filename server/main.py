from fastapi import FastAPI
from databases import Database
from dotenv import load_dotenv
from contextlib import asynccontextmanager
import os

load_dotenv()

DATABASE_PASSWORD = os.getenv('DATABASE_PASSWORD')
DATABASE_URL = f"postgresql://postgres.olxchrqwobbpgwqyuvos:{DATABASE_PASSWORD}@aws-0-ca-central-1.pooler.supabase.com:6543/postgres"

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Initialize and connect to the database
    database = Database(DATABASE_URL)
    await database.connect()

    # Store the database instance in app.state
    app.state.database = database
    yield

    # Disconnect from the database
    await database.disconnect()

app = FastAPI(lifespan=lifespan)

@app.get("/")
def read_root():
    return {"message": "Server is running"}

@app.get("/events")
async def get_events():
    # Retrieve the database instance from app.state
    database = app.state.database
    query = "SELECT * FROM events"
    results = await database.fetch_all(query)
    return results