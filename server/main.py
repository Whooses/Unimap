from datetime import date
from typing import List, Optional
from fastapi import FastAPI, Depends, Query
from sqlalchemy import or_
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


@app.get("/events")
def get_events(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,

    # Filters
    search: Optional[str] = Query(None),

    departments: List[str] = Query([]),  # Example: ?departments=cms&departments=management
    categories: List[str] = Query([]),  # Example: ?categories=food&categories=sports
    clubs: List[str] = Query([]),  # Example: ?clubs=amacss
    start_date: Optional[date] = Query(None),  # Example: ?start_date=2025-02-01
    end_date: Optional[date] = Query(None),  # Example: ?end_date=2025-02-10
    event_type: Optional[str] = Query(None),  # Example: ?event_type=rsvp
):
    query = db.query(Events)

    if search:
        query = query.filter(
            or_(
                Events.title.ilike(f"%{search}%"),       # Search in title
                Events.description.ilike(f"%{search}%"), # Search in description
                Events.location.ilike(f"%{search}%")     # Search in location
            )
        )

    if departments:
        query = query.filter(Events.departments.overlap(departments)) # get the events that overlap with all filters

    if categories:
        query = query.filter(Events.categories.overlap(categories))

    if clubs:
        query = query.filter(Events.clubs.overlap(clubs))

    if start_date and end_date:
        query = query.filter(Events.date.between(start_date, end_date))
    elif start_date:
        query = query.filter(Events.date >= start_date)
    elif end_date:
        query = query.filter(Events.date <= end_date)

    if event_type:
        query = query.filter(Events.types.overlap(event_type))

    events = query.offset(skip).limit(limit).all()

    return events