from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import select, or_, and_
from sqlalchemy.orm import selectinload
from typing import List, Optional

from db.models.events import Event

class EventRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_events(
        self,
        skip: int = 0,
        limit: int = 100,
        search: Optional[str] = None,
        tab: str = "all",
        sort: str = "latest",
        clubs: Optional[List[str]] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[Event]:
        try:
            stmt = select(Event).options(selectinload(Event.user))
            filters = []

            # Search filter
            if search:
                filters.append(
                    or_(
                        Event.title.ilike(f"%{search}%"),
                        Event.description.ilike(f"%{search}%"),
                        Event.location.ilike(f"%{search}%"),
                    )
                )

            # Tab filter
            if tab == "in_person":
                filters.append(Event.location.isnot(None))
            elif tab == "online":
                filters.append(Event.location.is_(None))

            # Clubs filter
            if clubs:
                filters.append(Event.clubs.overlap(clubs))

            # Date filters
            if start_date and end_date:
                filters.append(Event.date.between(start_date, end_date))
            elif start_date:
                filters.append(Event.date >= start_date)
            elif end_date:
                filters.append(Event.date <= end_date)

            # Apply all filters
            if filters:
                stmt = stmt.where(and_(*filters))

            # Apply sorting
            if sort == "latest":
                stmt = stmt.order_by(Event.date.desc())
            elif sort == "upcoming":
                stmt = stmt.order_by(Event.date.asc())
            elif sort == "recently_added":
                stmt = stmt.order_by(Event.id.desc())
            elif sort == "past":
                from datetime import datetime
                today = datetime.now().date()
                filters.append(Event.date < today)
                stmt = stmt.order_by(Event.date.desc())

            # Apply pagination
            stmt = stmt.offset(skip).limit(limit)

            result = await self.db.execute(stmt)
            return result.scalars().all()
        except SQLAlchemyError as e:
            raise RuntimeError(f"Database error in get_events: {e}")

    async def get_event(self, event_id: int) -> Optional[Event]:
        try:
            stmt = select(Event).options(selectinload(Event.user)).where(Event.id == event_id)
            result = await self.db.execute(stmt)
            return result.scalars().first()
        except SQLAlchemyError as e:
            raise RuntimeError(f"Database error in get_event: {e}")

    async def create_event(self, event_data: dict) -> Event:
        try:
            db_event = Event(**event_data)
            self.db.add(db_event)
            await self.db.commit()
            await self.db.refresh(db_event)
            return db_event
        except SQLAlchemyError as e:
            await self.db.rollback()
            raise RuntimeError(f"Database error in create_event: {e}")

    async def update_event(self, event_id: int, event_data: dict) -> Optional[Event]:
        try:
            event = await self.get_event(event_id)
            if not event:
                return None
            for field, value in event_data.items():
                setattr(event, field, value)
            await self.db.commit()
            await self.db.refresh(event)
            return event
        except SQLAlchemyError as e:
            await self.db.rollback()
            raise RuntimeError(f"Database error in update_event: {e}")

    async def delete_event(self, event_id: int) -> bool:
        try:
            event = await self.get_event(event_id)
            if not event:
                return False
            await self.db.delete(event)
            await self.db.commit()
            return True
        except SQLAlchemyError as e:
            await self.db.rollback()
            raise RuntimeError(f"Database error in delete_event: {e}")