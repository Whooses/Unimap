from pydantic import BaseModel, Field
from typing import Optional

class BugReportCreate(BaseModel):
    description: str = Field(..., min_length=5)
    screenshot_url: Optional[str] = None

class BugReportOut(BaseModel):
    id: int
    description: str
    screenshot_url: Optional[str]
    created_at: str

    class Config:
        from_attributes = True