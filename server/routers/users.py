from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from db.models.users import User
from db.models.events import Event
from dependencies.database_dep import get_db
from dependencies.auth_dep import get_current_user
from schemas.event import EventOut

router = APIRouter(prefix="/users", tags=["users"])

@router.post("/favourites/add", status_code=200)
def add_favourite(
    event_id: int = Query(..., description="ID of the event to favourite"),
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    db_user = db.query(User).filter(User.id == user["sub"]).first()
    db_event = db.query(Event).filter(Event.id == event_id).first()

    if not db_event:
        raise HTTPException(status_code=404, detail="Event not found")

    if db_event in db_user.favourites:
        raise HTTPException(status_code=400, detail="Event already in favourites")

    db_user.favourites.append(db_event)
    db.commit()
    return {"message": "Event added to favourites"}


@router.delete("/favourites/remove", status_code=200)
def remove_favourite(
    event_id: int = Query(..., description="ID of the event to remove from favourites"),
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    db_user = db.query(Users).filter(Users.id == user["sub"]).first()
    db_event = db.query(Event).filter(Event.id == event_id).first()

    if not db_event:
        raise HTTPException(status_code=404, detail="Event not found")

    if db_event not in db_user.favourites:
        raise HTTPException(status_code=400, detail="Event not in favourites")

    db_user.favourites.remove(db_event)
    db.commit()
    return {"message": "Event removed from favourites"}


@router.get("/favourites", response_model=list[EventOut])
def list_favourites(
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    db_user = db.query(Users).filter(Users.id == user["sub"]).first()

    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")

    return db_user.favourites