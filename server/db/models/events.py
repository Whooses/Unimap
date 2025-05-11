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

from db.models.users import Users
from .favourites import favourites_table

class Events(Base):
    __tablename__ = "events"

    id           = Column(BigInteger, primary_key=True, index=True, autoincrement=True)
    title        = Column(String, nullable=False, default="none")
    description  = Column(Text, nullable=True, default="none")
    date         = Column(Date, nullable=True)
    location     = Column(String, nullable=True, default="none")
    user_id      = Column(
        BigInteger,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )
    image_url    = Column(String, nullable=False, default="none")
    is_public    = Column(Boolean, nullable=True)
    created_at   = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at   = Column(DateTime(timezone=False), nullable=True)
    username     = Column(String, nullable=True, default="none")
    departments  = Column(ARRAY(Text), nullable=True)
    categories   = Column(ARRAY(Text), nullable=True)
    clubs        = Column(ARRAY(Text), nullable=True)
    types        = Column(ARRAY(Text), nullable=True)
    owner_id     = Column(BigInteger, nullable=False, default=0)

    __table_args__ = (
        CheckConstraint("owner_id >= 0", name="events_owner_id_check"),
    )

    user = relationship(
        "Users",
        back_populates="events"
    )


liked_by = relationship(
    "Users",
    secondary=favourites_table,
    back_populates="favourites"
)
