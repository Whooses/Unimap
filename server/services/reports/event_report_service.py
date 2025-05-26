import logging
from fastapi import HTTPException, status
from sqlalchemy.exc import IntegrityError, SQLAlchemyError

from db.repository.event_report_repo import EventReportRepository
from db.models.event_reports import Event_Reports
from schemas.event_report import EventReportCreate

log = logging.getLogger(__name__)

class EventReportService:
    def __init__(self, db):
        self.repo = EventReportRepository(db)

    # ── error helpers ───────────────────────────────────────────────────
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
            detail="Reported event not found.",
        )

    # ── public API ──────────────────────────────────────────────────────
    def create_event_report(self, data: EventReportCreate, reporter_id: int) -> Event_Reports:
        try:
            return self.repo.create_event_report(data, reporter_id)
        except IntegrityError as exc:
            log.exception("Integrity error in create_event_report")
            raise self._err409(exc) from exc
        except SQLAlchemyError as exc:
            log.exception("DB error in create_event_report")
            raise self._err500(exc) from exc