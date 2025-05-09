from fastapi import APIRouter, Depends, Query
from sqlalchemy import or_
from sqlalchemy.orm import Session, joinedload
from typing import List, Optional
from datetime import date, datetime
from pydantic import BaseModel


class UserInfo(BaseModel):
    id: int
    username: str
    pfp_url: Optional[str]

    model_config = {
        "from_attributes": True
    }