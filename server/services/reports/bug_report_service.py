import logging
from fastapi import HTTPException, status
from sqlalchemy.exc import IntegrityError, SQLAlchemyError

from db.repository.bug_report_repo import BugReportRepository
from db.models.bug_reports import BugReports
from schemas.bug_report import BugReportCreate

log = logging.getLogger(__name__)

class BugReportService:
    def __init__(self, db):
        self.repo = BugReportRepository(db)

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

    # ── public API ──────────────────────────────────────────────────────
    def create_bug_report(self, data: BugReportCreate, reporter_id: int) -> BugReports:
        try:
            return self.repo.create_bug_report(data, reporter_id)
        except IntegrityError as exc:
            log.exception("Integrity error in create_bug_report")
            raise self._err409(exc) from exc
        except SQLAlchemyError as exc:
            log.exception("DB error in create_bug_report")
            raise self._err500(exc) from exc