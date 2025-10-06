FROM python:3.8-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    libpq-dev \
    gcc \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/odoo

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all custom addons
COPY . /opt/odoo/custom-addons

# Expose Odoo port
EXPOSE 8069

# Run Odoo
CMD ["python3", "-m", "odoo", "--addons-path=/opt/odoo/custom-addons", "--db_host=$DB_HOST", "--db_port=$DB_PORT", "--db_user=$DB_USER", "--db_password=$DB_PASSWORD"]
