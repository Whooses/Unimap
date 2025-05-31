from fastapi import APIRouter, Depends
from schemas.bug_report import BugReportCreate, BugReportOut
from dependencies.auth_dep import get_current_user
from dependencies.bug_report_dep import get_bug_report_service
from services.reports.bug_report_service import BugReportService

router = APIRouter(prefix="/bugs", tags=["Bug Reports"])

@router.post("/", response_model=BugReportOut)
def report_bug(
    bug_data: BugReportCreate,
    user=Depends(get_current_user),
    bug_service: BugReportService = Depends(get_bug_report_service)
):
    return bug_service.create_bug_report(bug_data, reporter_id=user["sub"])