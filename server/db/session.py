import os

from dotenv import load_dotenv
from config import DATABASE_URL

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.orm import declarative_base

# Load environment variables
load_dotenv()

# Retrieve database URL
if not DATABASE_URL:
    raise ValueError("DATABASE_URL environment variable is not set!")

# Create the async database engine
engine = create_async_engine(DATABASE_URL, connect_args={"statement_cache_size": 0})

# Create a configured AsyncSessionLocal class
AsyncSessionLocal = async_sessionmaker(
    autocommit=False, autoflush=False, bind=engine, class_=AsyncSession
)

# Base class for models
Base = declarative_base()
