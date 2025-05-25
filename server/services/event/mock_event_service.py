from typing import List, Optional
from .mock_data import mock_events
from schemas.event import EventCreate, EventOut
from schemas.user import UserInfo

class MockEventService:
    def get_events(
        self,
        skip: int = 0,
        limit: int = 100,
        search: Optional[str] = None,
        tab: Optional[str] = None,  # Added tab param
        sort: Optional[str] = None,
        clubs: Optional[List[str]] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> List[EventOut]:
        events = mock_events

        # Tab filtering
        if tab == "in_person":
            events = [e for e in events if "In person" in e.types]
        elif tab == "online":
            events = [e for e in events if "Online" in e.types]

        # Search filtering
        if search:
            events = [e for e in events if search.lower() in (e.title or "").lower()]

        # Clubs filtering
        if clubs:
            events = [
                e for e in events
                if e.clubs and any(club in e.clubs for club in clubs)
            ]

        # Date filtering
        if start_date:
            events = [e for e in events if e.date and str(e.date) >= start_date]
        if end_date:
            events = [e for e in events if e.date and str(e.date) <= end_date]

        # Sorting
        if sort:
            reverse = False
            sort_key = None
            if sort.startswith("-"):
                reverse = True
                sort_key = sort[1:]
            else:
                sort_key = sort

            if hasattr(EventOut, sort_key):
                events = sorted(events, key=lambda e: getattr(e, sort_key, None), reverse=reverse)

        # Pagination
        paginated = events[skip:skip+limit]
        return paginated

    def get_event(self, event_id: int) -> Optional[EventOut]:
        for event in mock_events:
            if event.id == event_id:
                return event
        return None

    def create_event(self, event_create: EventCreate) -> EventOut:
        new_id = max((event.id for event in mock_events), default=0) + 1
        user = UserInfo(
            id=event_create.user_id,
            username=event_create.username or "unknown",
            pfp_url=None
        )
        event = EventOut(
            id=new_id,
            title=event_create.title,
            description=event_create.description,
            date=event_create.date,
            location=event_create.location,
            image_url=event_create.image_url,
            is_public=event_create.is_public,
            departments=event_create.departments,
            categories=event_create.categories,
            clubs=event_create.clubs,
            types=event_create.types,
            user=user,
        )
        mock_events.append(event)
        return event

    def update_event(self, event_id: int, event_update: EventCreate) -> Optional[EventOut]:
        for idx, event in enumerate(mock_events):
            if event.id == event_id:
                user = UserInfo(
                    id=event_update.user_id,
                    username=event_update.username or "unknown",
                    pfp_url=None
                )
                updated_event = EventOut(
                    id=event_id,
                    title=event_update.title,
                    description=event_update.description,
                    date=event_update.date,
                    location=event_update.location,
                    image_url=event_update.image_url,
                    is_public=event_update.is_public,
                    departments=event_update.departments,
                    categories=event_update.categories,
                    clubs=event_update.clubs,
                    types=event_update.types,
                    user=user,
                )
                mock_events[idx] = updated_event
                return updated_event
        return None

    def delete_event(self, event_id: int) -> bool:
        for idx, event in enumerate(mock_events):
            if event.id == event_id:
                del mock_events[idx]
                return True
        return False