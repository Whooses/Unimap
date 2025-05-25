from pydantic import BaseModel, Field

class ReportCreate(BaseModel):
    event_id: int
    reason: str = Field(..., min_length=5)

class ReportOut(BaseModel):
    id: int
    event_id: int
    reason: str
    created_at: str

    class Config:
        from_attributes = True