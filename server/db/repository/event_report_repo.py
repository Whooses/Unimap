from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from db.models.event_reports import Event_Reports
from schemas.event_report import EventReportCreate

class EventReportRepository:
    def __init__(self, db: Session):
        self.db = db

    def create_event_report(self, report_data: EventReportCreate, reporter_id: int) -> Event_Reports:
        try:
            report = Event_Reports(**report_data.dict(), reporter_id=reporter_id)
            self.db.add(report)
            self.db.commit()
            self.db.refresh(report)
            return report
        except SQLAlchemyError as e:
            self.db.rollback()
            raise RuntimeError(f"DB error in create_event_report: {e}")