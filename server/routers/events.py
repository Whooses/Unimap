from fastapi import APIRouter, Depends, Query, HTTPException, Response
from typing import List, Optional
from datetime import datetime

from schemas.event import EventCreate, EventOut
from dependencies.event_dep import get_event_service
from services.event.event_service import EventService

router = APIRouter(prefix="/events", tags=["events"])

@router.get("/", response_model=List[EventOut])
async def get_events(
    skip: int = 0,
    limit: int = 100,
    search: Optional[str] = Query(None),
    tab: str = Query(..., description="Must be one of: all, in_person, online"),
    sort: str = Query(..., description="Must be one of: latest, upcoming, recently_added, past"),
    clubs: Optional[List[str]] = Query(None),
    start_date: Optional[datetime] = Query(None),
    end_date: Optional[datetime] = Query(None),
    event_service: EventService = Depends(get_event_service),
):
    events = await event_service.get_events(
        skip=skip,
        limit=limit,
        search=search,
        tab=tab,
        sort=sort,
        clubs=clubs,
        start_date=start_date,
        end_date=end_date,
    )
    return events

@router.get("/user/{user_id}", response_model=List[EventOut])
async def get_user_events(
    user_id: int,
    sort: str = Query(..., description="Must be one of: latest, upcoming, recently_added, past"),
    skip: int = 0,
    limit: int = 100,
    event_service: EventService = Depends(get_event_service),
):
    events = await event_service.get_user_events(user_id, sort=sort, skip=skip, limit=limit)
    return events

@router.post("/", response_model=EventOut)
async def create_event(
    event: EventCreate,
    event_service: EventService = Depends(get_event_service),
):
    return await event_service.create_event(event)


@router.put("/{event_id}", response_model=EventOut)
async def update_event(
    event_id: int,
    updated_event: EventCreate,
    event_service: EventService = Depends(get_event_service),
):
    updated = await event_service.update_event(event_id, updated_event)
    return updated

@router.delete("/{event_id}", status_code=204)
async def delete_event(
    event_id: int,
    event_service: EventService = Depends(get_event_service),
):
    await event_service.delete_event(event_id)
    return Response(status_code=204)