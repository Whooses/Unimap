from __future__ import annotations

from typing import Optional, List
from datetime import datetime

from pydantic import BaseModel
from .user import UserInfo


class EventOut(BaseModel):
    id: int
    title: str
    description: Optional[str]
    date: Optional[datetime]
    location: Optional[str]
    image_url: str

    user: UserInfo

    model_config = {
        "from_attributes": True,
    }

# Request schema for creating an event
class EventCreate(BaseModel):
    title: str
    description: Optional[str] = None
    date: Optional[datetime] = None
    location: Optional[str] = None
    image_url: str
    is_public: bool
    user_id: int
    departments: Optional[List[str]] = None
    categories: Optional[List[str]] = None
    types: Optional[List[str]] = None
    is_in_person: Optional[bool] = None
    is_online: Optional[bool] = None
