from typing import List, Optional
from sqlalchemy.orm import Session
from db.repository.event_repo import EventRepository
from schemas.event import EventCreate, EventOut
from db.models.events import Events

class EventService:
    def __init__(self, db: Session):
        self.repo = EventRepository(db)

    def get_events(
        self,
        skip: int = 0,
        limit: int = 100,
        owner_id: Optional[int] = None,
        search: Optional[str] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[EventOut]:
        return self.repo.get_events(
            skip=skip,
            limit=limit,
            owner_id=owner_id,
            search=search,
            start_date=start_date,
            end_date=end_date,
        )

    def get_event(self, event_id: int) -> Optional[EventOut]:
        return self.repo.get_event(event_id)

    def create_event(self, event_create: EventCreate) -> EventOut:
        return self.repo.create_event(event_create.dict())

    def update_event(self, event_id: int, event_update: EventCreate) -> Optional[EventOut]:
        return self.repo.update_event(event_id, event_update.dict())

    def delete_event(self, event_id: int) -> bool:
        return self.repo.delete_event(event_id)