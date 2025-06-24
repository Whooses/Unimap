import logging
from typing import List, Optional
from datetime import datetime

from fastapi import HTTPException, status
from sqlalchemy.exc import IntegrityError, SQLAlchemyError
from sqlalchemy.ext.asyncio import AsyncSession

from db.repository.event_repo import EventRepository
from db.models.events import Event
from schemas.event import EventCreate

log = logging.getLogger(__name__)

class EventService:
    def __init__(self, db: AsyncSession):
        self.repo = EventRepository(db)

    @staticmethod
    def _err500(exc: Exception) -> HTTPException:
        return HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Internal server error. Please try again later.",
        )

    @staticmethod
    def _err409(exc: Exception) -> HTTPException:
        return HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="Duplicate or integrity constraint violation.",
        )

    @staticmethod
    def _err404() -> HTTPException:
        return HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Event not found.",
        )

    async def get_events(
        self,
        skip: int,
        limit: int,
        search: Optional[str] = None,
        tab: Optional[str] = None,  # Added tab param
        sort: Optional[str] = None,
        clubs: Optional[List[str]] = None,
        start_date: Optional[datetime] = None,
        end_date: Optional[datetime] = None,
    ) -> List[Event]:
        try:
            events = await self.repo.get_events(
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
        except SQLAlchemyError as exc:
            log.exception("DB failure in get_events")
            raise self._err500(exc) from exc

    async def get_event(self, event_id: int) -> Event:
        try:
            event = await self.repo.get_event(event_id)
            if event is None:
                raise self._err404()
            return event
        except SQLAlchemyError as exc:
            log.exception("DB failure in get_event")
            raise self._err500(exc) from exc

    async def get_user_events(
        self,
        user_id: int,
        sort: str = "latest",
        skip: int = 0,
        limit: int = 100,
    ) -> List[Event]:
        try:
            events = await self.repo.get_user_events(user_id, sort, skip, limit)
            
            return events
        except SQLAlchemyError as exc:
            log.exception("DB failure in get_user_events")
            raise self._err500(exc) from exc

    async def create_event(self, data: EventCreate) -> Event:
        try:
            event = await self.repo.create_event(data.dict())
            return event
        except IntegrityError as exc:
            log.exception("Integrity failure in create_event")
            raise self._err409(exc) from exc
        except SQLAlchemyError as exc:
            log.exception("DB failure in create_event")
            raise self._err500(exc) from exc


    async def update_event(self, event_id: int, data: EventCreate) -> Event:
        try:
            event = await self.repo.update_event(event_id, data.dict())
            if event is None:
                raise self._err404()
            return event
        except IntegrityError as exc:
            log.exception("Integrity failure in update_event")
            raise self._err409(exc) from exc
        except SQLAlchemyError as exc:
            log.exception("DB failure in update_event")
            raise self._err500(exc) from exc

    async def delete_event(self, event_id: int) -> None:
        try:
            deleted = await self.repo.delete_event(event_id)
            if not deleted:
                raise self._err404()
        except SQLAlchemyError as exc:
            log.exception("DB failure in delete_event")
            raise self._err500(exc) from exc