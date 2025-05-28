import os
from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession

from .database_dep import get_db
from services.event import mock_event_service, event_service
from services.event.protocol_event_service import ProtocolEventService

async def get_event_service(
    db: AsyncSession = Depends(get_db),
) -> ProtocolEventService:
    """
    Dynamically import and return the event service class based on the environment.
    """
    env = os.getenv("ENV", "development")
    if env == "production":
        return event_service.EventService(db)
    else:
        return mock_event_service.MockEventService()