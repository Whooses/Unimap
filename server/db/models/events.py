from sqlalchemy import (
    Column,
    BigInteger,
    String,
    Text,
    Date,
    Boolean,
    DateTime,
    ForeignKey,
)
from sqlalchemy.sql import func
from db.session import Base


class Events(Base):
    __tablename__ = "events"

    id = Column(BigInteger, primary_key=True, index=True, autoincrement=True)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=True)
    date = Column(Date, nullable=True)
    location = Column(String, nullable=True)
    user = Column(
        BigInteger, ForeignKey("users.id"), nullable=False
    )  # Assuming "users" table exists
    image_url = Column(String, nullable=False)
    is_public = Column(Boolean, nullable=True)
    created_at = Column(
        DateTime(timezone=True), server_default=func.now(), nullable=False
    )
    updated_at = Column(DateTime(timezone=True), nullable=True)
