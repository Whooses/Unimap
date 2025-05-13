from __future__ import annotations

from typing import Optional, List
import datetime

from pydantic import BaseModel
from .user import UserInfo


class EventOut(BaseModel):
    id: int
    title: str
    description: Optional[str]
    date: Optional[datetime.date]
    location: Optional[str]
    image_url: str
    is_public: bool
    departments: Optional[List[str]]
    categories: Optional[List[str]]
    clubs: Optional[List[str]]
    types: Optional[List[str]]

    user: UserInfo

    model_config = {
        "from_attributes": True,
    }

# Request schema for creating an event
class EventCreate(BaseModel):
    title: str
    description: Optional[str] = None
    date: Optional[datetime.date] = None
    location: Optional[str] = None
    image_url: str
    is_public: bool
    username: Optional[str] = None
    departments: Optional[List[str]] = None
    categories: Optional[List[str]] = None
    clubs: Optional[List[str]] = None
    types: Optional[List[str]] = None
    owner_id: int
    user_id: int
