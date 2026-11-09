FROM python:3.12-slim

LABEL org.opencontainers.image.source="https://github.com/AzmogEx/ws-cicd-Adam"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION}

RUN addgroup --system app \
    && adduser --system --ingroup app --no-create-home app \
    && chown -R app:app /app

USER app

EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
