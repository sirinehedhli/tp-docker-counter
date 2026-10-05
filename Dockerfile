# Image de base Alpine : très légère
FROM python:3.12-alpine

WORKDIR /app

# Utilisateur non-root (sécurité)
RUN adduser -D appuser

# On copie d'abord requirements.txt pour profiter du cache Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Le code change souvent : on le copie après les dépendances
COPY app.py .

# L'application ne tourne plus en root
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]