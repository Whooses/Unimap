from .user import UserOut, UserInfo
from .event import EventOut

def rebuild_schemas():
    EventOut.model_rebuild(_types_namespace={"UserInfo": UserInfo})
    UserOut.model_rebuild(_types_namespace={"EventOut": EventOut})