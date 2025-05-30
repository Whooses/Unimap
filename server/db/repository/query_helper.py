from typing import Optional, List
from datetime import datetime
from sqlalchemy import select, or_, and_
from sqlalchemy.orm import selectinload
from sqlalchemy.exc import SQLAlchemyError

from db.models.events import Event


class EventQueryBuilder:
    """
    Builds a SQLAlchemy statement for querying Event records
    with optional filters, sorting, and pagination.
    """
    def __init__(self):
        self._stmt = select(Event).options(selectinload(Event.user))

    def apply_filters(
        self,
        search: Optional[str] = None,
        tab: str = "all",
        clubs: Optional[List[str]] = None,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> "EventQueryBuilder":
        filters = []

        # Search filter
        if search:
            filters.append(
                or_(
                    Event.title.ilike(f"%{search}%"),
                    Event.description.ilike(f"%{search}%"),
                    Event.location.ilike(f"%{search}%"),
                )
            )

        # Tab filter
        if tab == "in_person":
            filters.append(Event.location.isnot(None))
        elif tab == "online":
            filters.append(Event.location.is_(None))

        # Clubs filter
        if clubs:
            filters.append(Event.clubs.overlap(clubs))

        # Date filters
        if start_date and end_date:
            filters.append(Event.date.between(start_date, end_date))
        elif start_date:
            filters.append(Event.date >= start_date)
        elif end_date:
            filters.append(Event.date <= end_date)

        if filters:
            self._stmt = self._stmt.where(and_(*filters))
        return self

    def apply_sort(self, sort: str = "latest") -> "EventQueryBuilder":
        if sort == "latest":
            self._stmt = self._stmt.order_by(Event.date.desc())
        elif sort == "upcoming":
            self._stmt = self._stmt.order_by(Event.date.asc())
        elif sort == "recently_added":
            self._stmt = self._stmt.order_by(Event.id.desc())
        elif sort == "past":
            today = datetime.now().date()
            self._stmt = self._stmt.where(Event.date < today).order_by(Event.date.desc())
        return self

    def paginate(self, skip: int = 0, limit: int = 100) -> "EventQueryBuilder":
        self._stmt = self._stmt.offset(skip).limit(limit)
        return self

    def build(self):
        return self._stmt

