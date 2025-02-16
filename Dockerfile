FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

RUN apt update && apt install -y --no-install-recommends libgomp1 \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Mise à jour de pip3
#RUN pip install --upgrade pip
#RUN python3 --version

WORKDIR /app


COPY app.py /app/app.py
COPY src/ /app/src/
COPY requirements.txt /app/requirements.txt

RUN uv pip install --no-cache-dir -r requirements.txt --system
# On ouvre et expose le port 80
EXPOSE $PORT

# Lancement de l'API
# Attention : ne pas lancer en daemon !
CMD exec gunicorn -b :$PORT -w 4 app:app