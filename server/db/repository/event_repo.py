from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import desc, asc, func
from datetime import datetime, date

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
        clubs: Optional[List[str]] = None,
        sort: Optional[str] = None,  # Add sort param
    ) -> List[Events]:
        try:
            query = self.db.query(Events)
            print(sort)

            if owner_id:
                query = query.filter(Events.user_id == owner_id)
            if search:
                query = query.filter(
                    (Events.title.ilike(f"%{search}%")) |
                    (Events.description.ilike(f"%{search}%")) |
                    (Events.location.ilike(f"%{search}%"))
                )
            if clubs:
                query = query.filter(Events.clubs.overlap(clubs))
            if start_date and end_date:
                query = query.filter(Events.date.between(start_date, end_date))
            if start_date:
                query = query.filter(Events.date >= start_date)
            if end_date:
                query = query.filter(Events.date <= end_date)

            now = func.current_date()

            # Sorting logic
            if sort == "latest":
                query = query.order_by(desc(Events.date))
            elif sort == "upcoming":
                query = query.filter(Events.date >= now).order_by(asc(Events.date))
            elif sort == "recently_added":
                query = query.order_by(desc(Events.created_at))
            elif sort == "past":
                query = query.filter(Events.date < now).order_by(desc(Events.date))
            else:
                query = query.order_by(desc(Events.date))  # Default

            return query.offset(skip).limit(limit).all()
        except SQLAlchemyError as e:
            raise RuntimeError(f"Database error in get_events: {e}")

    def get_event(self, event_id: int) -> Optional[Events]:
        try:
            return self.db.query(Events).filter(Events.id == event_id).first()
        except SQLAlchemyError as e:
            raise RuntimeError(f"Database error in get_event: {e}")

    def create_event(self, event_data: dict) -> Events:
        try:
            db_event = Events(**event_data)
            self.db.add(db_event)
            self.db.commit()
            self.db.refresh(db_event)
            return db_event
        except SQLAlchemyError as e:
            self.db.rollback()
            raise RuntimeError(f"Database error in create_event: {e}")

    def update_event(self, event_id: int, event_data: dict) -> Optional[Events]:
        try:
            event = self.get_event(event_id)
            if not event:
                return None
            for field, value in event_data.items():
                setattr(event, field, value)
            self.db.commit()
            self.db.refresh(event)
            return event
        except SQLAlchemyError as e:
            self.db.rollback()
            raise RuntimeError(f"Database error in update_event: {e}")

    def delete_event(self, event_id: int) -> bool:
        try:
            event = self.get_event(event_id)
            if not event:
                return False
            self.db.delete(event)
            self.db.commit()
            return True
        except SQLAlchemyError as e:
            self.db.rollback()
            raise RuntimeError(f"Database error in delete_event: {e}")