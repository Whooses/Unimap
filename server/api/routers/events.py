from fastapi import APIRouter, Depends, Query, HTTPException
from fastapi.responses import Response
from sqlalchemy import or_
from sqlalchemy.orm import Session, joinedload
from typing import List, Optional
from datetime import date
from db.models.events import Events
from api.dependencies import get_db
from api.schemas.event import EventOut, EventCreate

router = APIRouter(prefix="/events", tags=["events"])

@router.get("/", response_model=List[EventOut])
def get_events(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,
    owner_id: Optional[int] = Query(None),
    search: Optional[str] = Query(None),
    start_date: Optional[date] = Query(None),
    end_date: Optional[date] = Query(None),
):
    query = db.query(Events).options(joinedload(Events.user))

    if owner_id:
        query = query.filter(Events.user_id == owner_id)

    if search:
        query = query.filter(
            or_(
                Events.title.ilike(f"%{search}%"),
                Events.description.ilike(f"%{search}%"),
                Events.location.ilike(f"%{search}%"),
            )
        )

    if start_date and end_date:
        query = query.filter(Events.date.between(start_date, end_date))
    elif start_date:
        query = query.filter(Events.date >= start_date)
    elif end_date:
        query = query.filter(Events.date <= end_date)

    events = query.offset(skip).limit(limit).all()
    return events


@router.post("/", response_model=EventOut)
def create_event(event: EventCreate, db: Session = Depends(get_db)):
    db_event = Events(**event.dict())
    db.add(db_event)
    db.commit()
    db.refresh(db_event)

    db_event = db.query(Events).options(joinedload(Events.user)).filter(Events.id == db_event.id).first()

    return db_event

@router.put("/{event_id}", response_model=EventOut)
def update_event(event_id: int, updated_event: EventCreate, db: Session = Depends(get_db)):
    event = db.query(Events).filter(Events.id == event_id).first()
    if not event:
        raise HTTPException(status_code=404, detail="Event not found")

    for field, value in updated_event.dict().items():
        setattr(event, field, value)

    db.commit()
    db.refresh(event)
    return event

@router.delete("/{event_id}", status_code=204)
def delete_event(event_id: int, db: Session = Depends(get_db)):
    event = db.query(Events).filter(Events.id == event_id).first()
    if not event:
        raise HTTPException(status_code=404, detail="Event not found")

    db.delete(event)
    db.commit()
    return Response(status_code=204)