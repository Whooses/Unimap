from sqlalchemy.orm import Session
from db.models.bug_reports import BugReports
from schemas.bug import BugReportCreate

def create_bug_report(db: Session, bug_data: BugReportCreate, reporter_id: int):
    bug = BugReports(**bug_data.dict(), reporter_id=reporter_id)
    db.add(bug)
    db.commit()
    db.refresh(bug)
    return bug