from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from db.session import SessionLocal, engine, Base
from db.models.events import Events

# Create tables in the database (if they don't exist)
Base.metadata.create_all(bind=engine)

app = FastAPI()


# Dependency to get the database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# Example route to get all events
@app.get("/events")
def get_events(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    events = db.query(Events).offset(skip).limit(limit).all()
    return events
