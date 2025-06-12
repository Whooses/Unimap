# tests/test_get_events.py
from fastapi.testclient import TestClient
import pytest

from main import app
from dependencies.event_dep import get_event_service
from .mock_responds import sample_events

import logging
from typing import List, Optional
from datetime import datetime


client = TestClient(app)

# ---------- the actual integration test ----------
def test_get_events_latest_success():
	response = client.get("/events/", params={"tab": "all", "sort": "latest"})

	# 1. correct HTTP code
	assert response.status_code == 200

	# 2. body matches exactly
	data = response.json()
	assert data == sample_events

	# 3. quick sanity: newest-first ordering still holds
	assert data[0]["date"] >= data[-1]["date"]
