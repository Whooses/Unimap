from sqlalchemy.orm import Session
from typing import List, Optional
from db.models.events import Events

class EventRepository:
    def __init__(self, db: Session):
        self.db = db

    def get_events(
        self,
        skip: int = 0,
        limit: int = 100,
        owner_id: Optional[int] = None,
        search: Optional[str] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[Events]:
        query = self.db.query(Events)
        if owner_id:
            query = query.filter(Events.user_id == owner_id)
        if search:
            query = query.filter(
                (Events.title.ilike(f"%{search}%")) |
                (Events.description.ilike(f"%{search}%")) |
                (Events.location.ilike(f"%{search}%"))
            )
        if start_date and end_date:
            query = query.filter(Events.date.between(start_date, end_date))
        elif start_date:
            query = query.filter(Events.date >= start_date)
        elif end_date:
            query = query.filter(Events.date <= end_date)
        return query.offset(skip).limit(limit).all()

    def get_event(self, event_id: int) -> Optional[Events]:
        return self.db.query(Events).filter(Events.id == event_id).first()

    def create_event(self, event_data: dict) -> Events:
        db_event = Events(**event_data)
        self.db.add(db_event)
        self.db.commit()
        self.db.refresh(db_event)
        return db_event

    def update_event(self, event_id: int, event_data: dict) -> Optional[Events]:
        event = self.get_event(event_id)
        if not event:
            return None
        for field, value in event_data.items():
            setattr(event, field, value)
        self.db.commit()
        self.db.refresh(event)
        return event

    def delete_event(self, event_id: int) -> bool:
        event = self.get_event(event_id)
        if not event:
            return False
        self.db.delete(event)
        self.db.commit()
        return True