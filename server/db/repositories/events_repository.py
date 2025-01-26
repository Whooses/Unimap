from sqlalchemy.orm import Session
from db.models.events import Events

class EventRepository:
    def __init__(self, db: Session):
        self.db = db

    def get_event_by_id(self, event_id: int) -> Event:
        return self.db.query(Event).filter(Event.id == event_id).first()

    def get_all_events(self, skip: int = 0, limit: int = 100):
        return self.db.query(Event).offset(skip).limit(limit).all()

    def create_event(self, event_data: dict) -> Event:
        event = Event(**event_data)
        self.db.add(event)
        self.db.commit()
        self.db.refresh(event)
        return event

    def update_event(self, event_id: int, event_data: dict) -> Event:
        event = self.db.query(Event).filter(Event.id == event_id).first()
        if event:
            for key, value in event_data.items():
                setattr(event, key, value)
            self.db.commit()
            self.db.refresh(event)
        return event

    def delete_event(self, event_id: int) -> bool:
        event = self.db.query(Event).filter(Event.id == event_id).first()
        if event:
            self.db.delete(event)
            self.db.commit()
            return True
        return False