from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import desc, asc, func
from datetime import datetime, date

from typing import List, Optional

from db.models.events import Events

class EventRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_events(
        self,
        skip: int = 0,
        limit: int = 100,
        search: Optional[str] = None,
        tab: Optional[str] = None,  # Added tab param
        sort: Optional[str] = None,
        clubs: Optional[List[str]] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[Events]:
        try:
            query = self.db.query(Events)

            if search:
                filters.append(
                    or_(
                        Events.title.ilike(f"%{search}%"),
                        Events.description.ilike(f"%{search}%"),
                        Events.location.ilike(f"%{search}%"),
                    )
                )
            if clubs:
                query = query.filter(Events.clubs.overlap(clubs))
            if start_date and end_date:
                query = query.filter(Events.date.between(start_date, end_date))
            if start_date:
                query = query.filter(Events.date >= start_date)
            if end_date:
                query = query.filter(Events.date <= end_date)

                        # Tab filtering logic
            if tab == "inPerson":
                query = query.filter(Events.types.contains(["In person"]))
            elif tab == "online":
                query = query.filter(Events.types.contains(["Online"]))

            now = func.current_date()

            # If tab == "all" or None, do not filter by type

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