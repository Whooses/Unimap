from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import select, or_, and_
from sqlalchemy.orm import selectinload
from typing import List, Optional

from db.models.events import Events

class EventRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_events(
        self,
        skip: int = 0,
        limit: int = 100,
        owner_id: Optional[int] = None,
        search: Optional[str] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[Events]:
        try:
            stmt = select(Events).options(selectinload(Events.user))
            filters = []
            if owner_id:
                filters.append(Events.user_id == owner_id)
            if search:
                filters.append(
                    or_(
                        Events.title.ilike(f"%{search}%"),
                        Events.description.ilike(f"%{search}%"),
                        Events.location.ilike(f"%{search}%"),
                    )
                )
            if start_date and end_date:
                filters.append(Events.date.between(start_date, end_date))
            if start_date:
                filters.append(Events.date >= start_date)
            if end_date:
                filters.append(Events.date <= end_date)
            if filters:
                stmt = stmt.where(and_(*filters))
            stmt = stmt.offset(skip).limit(limit)
            result = await self.db.execute(stmt)
            return result.scalars().all()
        except SQLAlchemyError as e:
            raise RuntimeError(f"Database error in get_events: {e}")

    async def get_event(self, event_id: int) -> Optional[Events]:
        try:
            stmt = select(Events).options(selectinload(Events.user)).where(Events.id == event_id)
            result = await self.db.execute(stmt)
            return result.scalars().first()
        except SQLAlchemyError as e:
            raise RuntimeError(f"Database error in get_event: {e}")

    async def create_event(self, event_data: dict) -> Events:
        try:
            db_event = Events(**event_data)
            self.db.add(db_event)
            await self.db.commit()
            await self.db.refresh(db_event)
            return db_event
        except SQLAlchemyError as e:
            await self.db.rollback()
            raise RuntimeError(f"Database error in create_event: {e}")

    async def update_event(self, event_id: int, event_data: dict) -> Optional[Events]:
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