from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from schemas.bug import BugReportCreate, BugReportOut
from services.bugs import create_bug_report
from dependencies.database_dep import get_db
from dependencies.auth_dep import get_current_user

router = APIRouter(prefix="/bugs", tags=["Bug Reports"])

@router.post("/", response_model=BugReportOut)
def report_bug(
    bug_data: BugReportCreate,
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    return create_bug_report(db, bug_data, reporter_id=user["sub"])