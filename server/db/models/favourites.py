from sqlalchemy import Table, Column, ForeignKey, BigInteger
from db.session import Base

favourites_table = Table(
    "favourites",
    Base.metadata,
    Column("user_id", BigInteger, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True),
    Column("event_id", BigInteger, ForeignKey("events.id", ondelete="CASCADE"), primary_key=True)
)