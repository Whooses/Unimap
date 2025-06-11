from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from db.models.bug_reports import BugReports
from schemas.bug_report import BugReportCreate

class BugReportRepository:
    def __init__(self, db: Session):
        self.db = db

    def create_bug_report(self, bug_data: BugReportCreate, reporter_id: int) -> BugReports:
        try:
            bug = BugReports(**bug_data.dict(), reporter_id=reporter_id)
            self.db.add(bug)
            self.db.commit()
            self.db.refresh(bug)
            return bug
        except SQLAlchemyError as e:
            self.db.rollback()
            raise RuntimeError(f"DB error in create_bug_report: {e}")