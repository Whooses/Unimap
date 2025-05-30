from sqlalchemy import (
    Column,
    BigInteger,
    String,
    Text,
    Date,
    DateTime,
    Boolean,
    ForeignKey,
    CheckConstraint,
    func
)
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.orm import relationship
from db.session import Base

from db.models.users import User

class Event(Base):
    __tablename__ = "event"

    id           = Column(BigInteger, primary_key=True, index=True, autoincrement=True)
    title        = Column(String, nullable=False, default="none")
    description  = Column(Text, nullable=True, default="none")
    date         = Column(DateTime(timezone=True), nullable=True)
    location     = Column(String, nullable=True, default="none")
    user_id      = Column(
        BigInteger,
        ForeignKey("user.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )
    image_url    = Column(String, nullable=False, default="none")
    is_public    = Column(Boolean, nullable=True)
    created_at   = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at   = Column(DateTime(timezone=True), nullable=True)
    departments  = Column(ARRAY(Text), nullable=True)
    categories   = Column(ARRAY(Text), nullable=True)
    clubs        = Column(ARRAY(Text), nullable=True)
    types        = Column(ARRAY(Text), nullable=True)
    is_in_person = Column(Boolean, nullable=True, default=False)
    is_online    = Column(Boolean, nullable=True, default=False)

    user = relationship(
        "User",
        back_populates="events"
    )

    event_reports = relationship(
        "EventReports",
        back_populates="event",
        cascade="all, delete-orphan"
        )