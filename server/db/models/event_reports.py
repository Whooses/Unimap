from sqlalchemy import Column, Integer, Text, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from db.session import Base


class EventReports(Base):
    __tablename__ = "event_reports"

    id = Column(Integer, primary_key=True, index=True)
    reason = Column(Text, nullable=False)
    event_id = Column(Integer, ForeignKey("event.id", ondelete="CASCADE"), nullable=False)
    reporter_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    reporter = relationship("User", back_populates="event_reports")
    event = relationship("Event", back_populates="event_reports")

