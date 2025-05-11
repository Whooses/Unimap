from typing import Protocol, List, Optional
from schemas.event import EventCreate, EventOut

class ProtocolEventService(Protocol):
    def get_event_list(
        self,
        skip: int = 0,
        limit: int = 100,
        owner_id: Optional[int] = None,
        search: Optional[str] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[EventOut]:
        """Get a list of events with optional filters and pagination."""
        pass

    def get_event(self, event_id: int) -> Optional[EventOut]:
        """Get event details by event ID."""
        pass

    def create_event(self, event_create: EventCreate) -> EventOut:
        """Create a new event."""
        pass

    def update_event(self, event_id: int, event_update: EventCreate) -> Optional[EventOut]:
        """Update an existing event."""
        pass

    def delete_event(self, event_id: int) -> bool:
        """Delete an event by ID."""
        pass
