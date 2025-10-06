FROM python:3.9-slim-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libpq-dev \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    zlib1g-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt/odoo

# Copy requirements first
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip wheel setuptools && \
    pip install --no-cache-dir -r requirements.txt

# Copy entire project
COPY . .

# Expose Odoo port
EXPOSE 8069

# Start command - adjust based on your Odoo structure
CMD ["python3", "odoo-bin"]
