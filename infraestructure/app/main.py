from fastapi import FastAPI, HTTPException
from contextlib import asynccontextmanager
import psycopg2
import psycopg2.pool
import os

db_pool: psycopg2.pool.SimpleConnectionPool | None = None


def get_db_config():
    return {
        "host": os.getenv("DB_HOST"),
        "dbname": os.getenv("DB_NAME"),
        "user": os.getenv("DB_USER"),
        "password": os.getenv("DB_PASSWORD"),
        "sslmode": os.getenv("DB_SSLMODE", "require"),
    }


@asynccontextmanager
async def lifespan(app: FastAPI):
    global db_pool

    config = get_db_config()

    missing = [k for k, v in config.items() if v is None]
    if missing:
        raise RuntimeError(f"Missing environment variables: {missing}")

    db_pool = psycopg2.pool.SimpleConnectionPool(
        minconn=1,
        maxconn=5,
        **config,
    )

    yield  # 🚀 aplicação rodando

    if db_pool:
        db_pool.closeall()


app = FastAPI(
    title="FastAPI DevOps App",
    lifespan=lifespan,
)


@app.get("/health")
def healthcheck():
    return {"status": "ok"}


@app.get("/health/db")
def db_healthcheck():
    if not db_pool:
        raise HTTPException(status_code=500, detail="DB pool not initialized")

    conn = None
    try:
        conn = db_pool.getconn()
        cur = conn.cursor()
        cur.execute("SELECT 1")
        cur.fetchone()
        cur.close()
        return {"database": "connected"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        if conn:
            db_pool.putconn(conn)
