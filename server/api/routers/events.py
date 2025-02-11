from fastapi import APIRouter, Depends, Query
from sqlalchemy.future import select
from sqlalchemy import or_
from typing import List, Optional
from datetime import date
from db.models.events import Events
from api.dependencies import get_db
from sqlalchemy.orm import Session

router = APIRouter(prefix="/events", tags=["events"])

@router.get("/")
def get_events(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,


    # Filters
    owner_id: Optional[int] = Query(None),  # Example: ?owner_id=4

    search: Optional[str] = Query(None),

    departments: List[str] = Query([]),  # Example: ?departments=cms&departments=management
    categories: List[str] = Query([]),  # Example: ?categories=food&categories=sports
    clubs: List[str] = Query([]),  # Example: ?clubs=amacss
    start_date: Optional[date] = Query(None),  # Example: ?start_date=2025-02-01
    end_date: Optional[date] = Query(None),  # Example: ?end_date=2025-02-10
    event_type: Optional[str] = Query(None),  # Example: ?event_type=rsvp
):
    query = db.query(Events)


    if owner_id:
        query = query.filter(Events.owner_id == owner_id)

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