import os
from services.event import mock_event_service, event_service
from services.event.protocol_event_service import ProtocolEventService

def get_event_service() -> ProtocolEventService:
    """
    Dynamically import and return the event service class based on the environment.
    """
    env = os.getenv("ENV", "development")
    if env == "production":
        return event_service.EventService()
    else:
        return mock_event_service.MockEventService()