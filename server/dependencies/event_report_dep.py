import os
from fastapi import Depends
from sqlalchemy.orm import Session
from dependencies.database_dep import get_db
from services.reports.event_report_service import EventReportService

def get_event_report_service(
    db: Session = Depends(get_db),
) -> EventReportService:
    return EventReportService(db)