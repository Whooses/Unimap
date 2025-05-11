from pydantic import BaseModel
from typing import List, Optional, TYPE_CHECKING

if TYPE_CHECKING:
    from api.schemas.event import EventOut

class UserInfo(BaseModel):
    username: str
    pfp_url: Optional[str]
    favourites: Optional[List["EventOut"]] = []

    model_config = {
        "from_attributes": True
    }