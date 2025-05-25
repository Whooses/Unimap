from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from schemas.report import ReportCreate, ReportOut
from services.reports import create_report
from dependencies.database_dep import get_db
from dependencies.auth_dep import get_current_user

router = APIRouter(prefix="/reports", tags=["Reports"])

@router.post("/", response_model=ReportOut)
def report_event(
    report_data: ReportCreate,
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    return create_report(db, report_data, reporter_id=user["sub"])