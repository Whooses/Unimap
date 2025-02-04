from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

# Replace with your Supabase database URL
DATABASE_URL = "postgresql://postgres.olxchrqwobbpgwqyuvos:x7OwMPNJElTCCR0C@aws-0-ca-central-1.pooler.supabase.com:6543/postgres"

# Create the database engine
engine = create_engine(DATABASE_URL)

# Create a configured SessionLocal class
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base class for models
Base = declarative_base()


