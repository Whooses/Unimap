from typing import Protocol, List, Optional
from schemas.event import EventCreate, EventOut
from db.models.events import Events

class ProtocolEventService(Protocol):
    """
    Event Service Protocol

    This protocol defines the contract for event-related business logic operations.
    The service is responsible for orchestrating event CRUD operations, applying business rules,
    and handling expected errors internally. Expected errors (such as validation failures,
    transient database issues, or retryable errors) should be managed within the service,
    possibly including retries or sending problematic payloads to a dead-letter queue (DLQ).
    Only truly unexpected or unrecoverable issues (such as configuration errors or internal data corruption)
    should result in exceptions being raised to the caller.
    """

    async def get_events(
        self,
        skip: int = 0,
        limit: int = 100,
        search: Optional[str] = None,
        tab: Optional[str] = None,  # Added tab param
        sort: Optional[str] = None,
        clubs: Optional[List[str]] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[Events]:
        """
        Retrieve a list of events with optional filters and pagination.

        Handles expected errors such as invalid filter parameters or transient database issues internally,
        possibly with retries or logging. Returns an empty list if no events are found or if recoverable
        errors occur. Raises exceptions only for unrecoverable issues (e.g., configuration errors).

        Returns:
            List[Events]: List of event objects matching the filters.

        Raises:
            RuntimeError: For unrecoverable or unexpected internal errors.
        """
        pass

    async def get_event(self, event_id: int) -> Optional[Events]:
        """
        Retrieve event details by event ID.

        Handles expected errors such as missing or invalid IDs internally. Returns None if the event
        does not exist or if recoverable errors occur. Raises exceptions only for unrecoverable issues.

        Args:
            event_id (int): The ID of the event to retrieve.

        Returns:
            Optional[Events]: The event object if found, otherwise None.

        Raises:
            RuntimeError: For unrecoverable or unexpected internal errors.
        """
        pass

    async def create_event(self, event_create: EventCreate) -> Events:
        """
        Create a new event.

        Handles expected errors such as validation failures or transient database issues internally,
        possibly with retries or logging. Raises exceptions only for unrecoverable issues (e.g., corrupted payload).

        Args:
            event_create (EventCreate): The event creation data.

        Returns:
            EventOut: The created event object.

        Raises:
            RuntimeError: For unrecoverable or unexpected internal errors.
        """
        pass

    async def update_event(self, event_id: int, event_update: EventCreate) -> Optional[Events]:
        """
        Update an existing event.

        Handles expected errors such as validation failures, missing events, or transient issues internally.
        Returns None if the event does not exist or if recoverable errors occur. Raises exceptions only for
        unrecoverable issues.

        Args:
            event_id (int): The ID of the event to update.
            event_update (EventCreate): The updated event data.

        Returns:
            Optional[Events]: The updated event object if successful, otherwise None.

        Raises:
            RuntimeError: For unrecoverable or unexpected internal errors.
        """
        pass

    async def delete_event(self, event_id: int) -> bool:
        """
        Delete an event by ID.

        Handles expected errors such as missing events or transient database issues internally,
        possibly with retries or logging. Returns False if the event does not exist or if recoverable
        errors occur. Raises exceptions only for unrecoverable issues.

        Args:
            event_id (int): The ID of the event to delete.

        Returns:
            bool: True if the event was deleted, False otherwise.

        Raises:
            RuntimeError: For unrecoverable or unexpected internal errors.
        """
        pass
