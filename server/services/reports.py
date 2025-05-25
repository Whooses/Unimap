from sqlalchemy.orm import Session
from db.models.reports import Reports
from schemas.report import ReportCreate

def create_report(db: Session, report_data: ReportCreate, reporter_id: int):
    report = Reports(**report_data.dict(), reporter_id=reporter_id)
    db.add(report)
    db.commit()
    db.refresh(report)
    return report