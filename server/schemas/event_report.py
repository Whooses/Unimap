from pydantic import BaseModel, Field

class EventReportCreate(BaseModel):
    event_id: int
    reason: str = Field(..., min_length=5)

class EventReportOut(BaseModel):
    id: int
    event_id: int
    reason: str
    created_at: str

    model_config = {
        "from_attributes": True
    }