from sqlalchemy import Column, Integer, Text, ForeignKey, DateTime, String, func
from sqlalchemy.orm import relationship
from db.session import Base

class BugReports(Base):
    __tablename__ = "bug_reports"

    id = Column(Integer, primary_key=True, index=True)
    description = Column(Text, nullable=False)
    screenshot_url = Column(String, nullable=True)

    reporter_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    reporter = relationship("User", back_populates="bug_reports")