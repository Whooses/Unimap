# tests/test_get_events.py
from fastapi.testclient import TestClient
import pytest

from dependencies.event_dep import get_event_service
from services.event.mock_event_service import MockEventService
from main import app

@pytest.fixture
def client():
    app.dependency_overrides[get_event_service] = lambda: MockEventService()
    with TestClient(app) as test_client:
        yield test_client
    app.dependency_overrides.clear()

def test_get_events(client):
    response = client.get(
        "/events/",
        params={
            "tab": "all",
            "sort": "latest"
        }
    )
    assert response.status_code == 200
    assert isinstance(response.json(), list)

