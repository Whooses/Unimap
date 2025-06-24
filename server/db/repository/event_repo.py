from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import select, or_, and_
from sqlalchemy.orm import selectinload
from typing import List, Optional

from db.models.events import Event
from db.repository.query_helper import EventQueryBuilder

from datetime import datetime

class EventRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_events(
        self,
        skip: int,
        limit: int,
        search: Optional[str] = None,
        tab: str = "all",
        sort: str = "latest",
        clubs: Optional[List[str]] = None,
        start_date: Optional[datetime] = None,
        end_date: Optional[datetime] = None,
    ) -> List[Event]:
        try:
            stmt = (
                EventQueryBuilder()
                .apply_filters(search, tab, clubs, start_date, end_date)
                .apply_sort(sort)
                .paginate(skip, limit)
                .build()
            )
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

    async def get_user_events(
        self,
        user_id: int,
        sort: str = "latest",
        skip: int = 0,
        limit: int = 100,
    ) -> List[Event]:
        try:
            stmt = (
                EventQueryBuilder()
                .apply_sort(sort)
                .set_user(user_id)
                .paginate(skip, limit)
                .build()
            )
            result = await self.db.execute(stmt)

            return result.scalars().all()
        except SQLAlchemyError as e:
            raise RuntimeError(f"Database error in get_user: {e}")

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