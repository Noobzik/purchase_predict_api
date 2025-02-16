FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

RUN apt update
RUN apt install libgomp1 -y

# Mise à jour de pip3
#RUN pip install --upgrade pip
#RUN python3 --version

RUN mkdir /app

WORKDIR /app


COPY app.py /app/app.py
COPY src/ /app/src/
COPY requirements.txt /app/requirements.txt

RUN uv pip install --no-cache-dir -r requirements.txt --system
# On ouvre et expose le port 80
EXPOSE 80

# Lancement de l'API
# Attention : ne pas lancer en daemon !
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "-w", "4"]