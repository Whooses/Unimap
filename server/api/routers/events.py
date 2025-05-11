from fastapi import APIRouter, Depends, Query, HTTPException, Response
from typing import List, Optional
from datetime import date

from schemas.event import EventCreate, EventOut
from dependencies.event_dep import get_event_service
from services.event.protocol_event_service import ProtocolEventService

router = APIRouter(prefix="/events", tags=["events"])

@router.get("/", response_model=List[EventOut])
def get_events(
    skip: int = 0,
    limit: int = 100,
    owner_id: Optional[int] = Query(None),
    search: Optional[str] = Query(None),
    start_date: Optional[date] = Query(None),
    end_date: Optional[date] = Query(None),
    event_service: ProtocolEventService = Depends(get_event_service),
):
    events = event_service.get_event_list(
        skip=skip,
        limit=limit,
        owner_id=owner_id,
        search=search,
        start_date=start_date.isoformat() if start_date else None,
        end_date=end_date.isoformat() if end_date else None,
    )
    return events

@router.post("/", response_model=EventOut)
def create_event(
    event: EventCreate,
    event_service: ProtocolEventService = Depends(get_event_service),
):
    return event_service.create_event(event)

@router.put("/{event_id}", response_model=EventOut)
def update_event(
    event_id: int,
    updated_event: EventCreate,
    event_service: ProtocolEventService = Depends(get_event_service),
):
    updated = event_service.update_event(event_id, updated_event)
    if not updated:
        raise HTTPException(status_code=404, detail="Event not found")
    return updated

@router.delete("/{event_id}", status_code=204)
def delete_event(
    event_id: int,
    event_service: ProtocolEventService = Depends(get_event_service),
):
    deleted = event_service.delete_event(event_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Event not found")
    return Response(status_code=204)