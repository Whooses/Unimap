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
from db.models.favourites import favourite_table

class Users(Base):
    __tablename__ = "users"

    id         = Column(BigInteger, primary_key=True, index=True, autoincrement=True)
    username   = Column(String, unique=True, nullable=False, index=True)
    email      = Column(String, unique=True, nullable=False, index=True)
    pfp_url    = Column(String, nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), nullable=True)

    events = relationship(
        "Events",
        back_populates="user",
        cascade="all, delete-orphan"
    )

    favourites = relationship(
        "Events",
        secondary=favourite_table,
        backref="favourited_by"
    )

    reports = relationship(
        "EventReport",
        back_populates="reporter",
        cascade="all, delete-orphan"
    )

    bug_reports = relationship(
        "BugReport",
        back_populates="reporter",
        cascade="all, delete-orphan"
    )

