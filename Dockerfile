FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend

# Install system dependencies (only if you really want mysqlclient, else remove this block)
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend

EXPOSE 8000

# Force the container to always run Django server (skip migrations if DB not needed)
CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:8000 || tail -f /dev/null"]
