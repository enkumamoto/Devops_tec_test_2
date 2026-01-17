from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

def get_connection():
    return psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )

@app.get("/")
def healthcheck():
    return {"status": "ok"}

@app.get("/db")
def db_check():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT 1")
    cur.close()
    conn.close()
    return {"database": "connected"}
