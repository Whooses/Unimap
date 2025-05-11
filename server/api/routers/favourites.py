from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import Response
from sqlalchemy.orm import Session
from db.models.users import Users
from db.models.events import Events
from api.dependencies import get_db
from auth.dependencies import get_current_user
from api.schemas.event import EventOut

router = APIRouter(prefix="/favourites", tags=["favourites"])


@router.post("/{event_id}/toggle", status_code=200)
def toggle_favourite(
    event_id: int,
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    # Get user and event
    db_user = db.query(Users).filter(Users.id == user["sub"]).first()
    db_event = db.query(Events).filter(Events.id == event_id).first()

    if not db_event:
        raise HTTPException(status_code=404, detail="Event not found")

    # Toggle favourite
    if db_event in db_user.favourites:
        db_user.favourites.remove(db_event)
        db.commit()
        return {"message": "Removed from favourites"}
    else:
        db_user.favourites.append(db_event)
        db.commit()
        return {"message": "Added to favourites"}


@router.get("/", response_model=list[EventOut])
def list_favourites(
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    db_user = db.query(Users).filter(Users.id == user["sub"]).first()
    return db_user.favourites