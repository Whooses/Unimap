import logging
from typing import List, Optional


from fastapi import HTTPException, status
from sqlalchemy.exc import IntegrityError, SQLAlchemyError
from sqlalchemy.orm import Session

from db.repository.event_repo import EventRepository
from schemas.event import EventCreate, EventOut
from db.models.events import Events

log = logging.getLogger(__name__)

class EventService:
    def __init__(self, db):
        self.repo = EventRepository(db)

    # ── tiny helpers ────────────────────────────────────────────────────
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

    # ── public API ──────────────────────────────────────────────────────
    def get_events(
        self,
        skip: int = 0,
        limit: int = 100,
        owner_id: Optional[int] = None,
        search: Optional[str] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[EventOut]:
        try:
            events = self.repo.get_events(
                skip=skip,
                limit=limit,
                owner_id=owner_id,
                search=search,
                start_date=start_date,
                end_date=end_date,
            )
            return [EventOut.from_orm(e) for e in events]
        except SQLAlchemyError as exc:
            log.exception("DB failure in get_events")
            raise self._err500(exc) from exc

    def get_event(self, event_id: int) -> EventOut:
        try:
            event = self.repo.get_event(event_id)
            if event is None:
                raise self._err404()
            return EventOut.from_orm(event)
        except SQLAlchemyError as exc:
            log.exception("DB failure in get_event")
            raise self._err500(exc) from exc

    def create_event(self, data: EventCreate) -> EventOut:
        try:
            ev = self.repo.create_event(data.dict())
            return EventOut.from_orm(ev)
        except IntegrityError as exc:          # <-- specific first
            log.exception("Integrity failure in create_event")
            raise self._err409(exc) from exc
        except SQLAlchemyError as exc:
            log.exception("DB failure in create_event")
            raise self._err500(exc) from exc

    def update_event(self, event_id: int, data: EventCreate) -> EventOut:
        try:
            ev = self.repo.update_event(event_id, data.dict())
            if ev is None:
                raise self._err404()
            return EventOut.from_orm(ev)
        except IntegrityError as exc:
            log.exception("Integrity failure in update_event")
            raise self._err409(exc) from exc
        except SQLAlchemyError as exc:
            log.exception("DB failure in update_event")
            raise self._err500(exc) from exc

    def delete_event(self, event_id: int) -> None:
        try:
            deleted = self.repo.delete_event(event_id)
            if not deleted:
                raise self._err404() from exc
        except SQLAlchemyError as exc:
            log.exception("DB failure in delete_event")
            raise self._err500(exc) from exc