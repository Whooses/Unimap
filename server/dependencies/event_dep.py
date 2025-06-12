import os
from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession

from .database_dep import get_db
from services.event.event_service import EventService

async def get_event_service(
    db: AsyncSession = Depends(get_db),
) -> EventService:
    """
    Dynamically import and return the event service class based on the environment.
    """
    return EventService(db)