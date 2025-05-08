import os

from dotenv import load_dotenv
from config import DATABASE_URL

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Load environment variables
load_dotenv()

# Retrieve database URL
if not DATABASE_URL:
    raise ValueError("DATABASE_URL environment variable is not set!")

# Create the database engine
engine = create_engine(DATABASE_URL)

# Create a configured SessionLocal class
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base class for models
Base = declarative_base()
