from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Position(BaseModel):
    x: float
    y: float

INITIAL_POSITION = {'x': 0, 'y': 0}

POSITIONS = {
        1: Position(**INITIAL_POSITION),
        2: Position(**INITIAL_POSITION)
        }

@app.get("/position/{player_id}")
def get_player_position(player_id: int):
    return POSITIONS[player_id]

@app.post("/position/{player_id}")
def update_player_position(player_id: int, position: Position):
    POSITIONS[player_id] = position
    return {"player_id": player_id, "position": POSITIONS[player_id]}
