import os
from fastapi import Depends
from sqlalchemy.orm import Session

from .database_dep import get_db  # Make sure you have this dependency
from services.event import mock_event_service, event_service
from services.event.protocol_event_service import ProtocolEventService

def get_event_service(
    db: Session = Depends(get_db),
) -> ProtocolEventService:
    """
    Dynamically import and return the event service class based on the environment.
    """
    env = os.getenv("ENV", "development")
    if env == "production":
        return event_service.EventService(db)
    else:
        return mock_event_service.MockEventService()