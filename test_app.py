import app

def test_index_incremente(monkeypatch):
    monkeypatch.setattr(app.r, "incr", lambda key: 42)
    client = app.app.test_client()
    rep = client.get("/")
    assert rep.status_code == 200
    assert "42 fois" in rep.get_data(as_text=True)
