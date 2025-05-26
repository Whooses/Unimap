import os
from fastapi import Depends
from sqlalchemy.orm import Session
from dependencies.database_dep import get_db
from services.reports.bug_report_service import BugReportService

def get_bug_report_service(
    db: Session = Depends(get_db),
) -> BugReportService:
    return BugReportService(db)