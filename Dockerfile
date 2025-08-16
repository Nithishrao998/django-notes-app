FROM python:3.9

WORKDIR /app

# Copy requirements
COPY requirements.txt /app

# Install system dependencies for mysqlclient
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app

# ✅ Force SQLite database inside container
ENV DJANGO_DB_ENGINE=django.db.backends.sqlite3
ENV DJANGO_DB_NAME=/app/db.sqlite3

# Expose port
EXPOSE 8000

# Run migrations + start server
CMD ["sh", "-c", "python manage.py migrate --noinput && python manage.py runserver 0.0.0.0:8000"]
