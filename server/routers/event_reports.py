from fastapi import APIRouter, Depends
from schemas.event_report import EventReportCreate, EventReportOut
from dependencies.auth_dep import get_current_user
from dependencies.event_report_dep import get_event_report_service
from services.reports.event_report_service import EventReportService

router = APIRouter(prefix="/reports", tags=["Reports"])

@router.post("/", response_model=EventReportOut)
def report_event(
    report_data: EventReportCreate,
    user=Depends(get_current_user),
    report_service: EventReportService = Depends(get_event_report_service)
):
    return report_service.create_event_report(report_data, reporter_id=user["sub"])