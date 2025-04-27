from pydantic import BaseModel
from typing import Optional, List
from datetime import date, datetime
from .user import UserInfo

class EventOut(BaseModel):
    id: int
    title: str
    description: Optional[str]
    date: Optional[date]                # was start_at/end_at
    location: Optional[str]
    image_url: str
    is_public: Optional[bool]
    created_at: datetime
    updated_at: Optional[datetime]
    username: Optional[str]
    departments: Optional[List[str]]
    categories: Optional[List[str]]
    clubs: Optional[List[str]]
    types: Optional[List[str]]
    owner_id: int
    user_id: int
    user: UserInfo

    model_config = {
        "from_attributes": True
    }
