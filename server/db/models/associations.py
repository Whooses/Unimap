from sqlalchemy import Table, Column, BigInteger, ForeignKey
from db.session import Base

user_favourites = Table(
    "user_favourites",
    Base.metadata,
    Column("user_id", BigInteger, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True),
    Column("event_id", BigInteger, ForeignKey("events.id", ondelete="CASCADE"), primary_key=True)
)