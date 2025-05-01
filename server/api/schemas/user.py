from typing import TYPE_CHECKING, Optional, List
from pydantic import BaseModel

if TYPE_CHECKING:
    from .event import EventOut  # forward reference only

class UserInfo(BaseModel):
    username: str
    pfp_url: Optional[str]

    model_config = {
        "from_attributes": True
    }

class UserOut(UserInfo):
    favourites: List["EventOut"] = []

    model_config = {
        "from_attributes": True
    }