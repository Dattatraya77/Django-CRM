#!/usr/bin/env bash
set -e

echo "Installing PostgreSQL..."

# Install PostgreSQL
sudo apt update
sudo apt install -y postgresql postgresql-contrib libpq-dev

echo "Starting PostgreSQL..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "Configuring PostgreSQL Database..."

DB_NAME="crm_db"
DB_USER="postgres"
DB_PASSWORD="root"

# Switch to postgres user
sudo -u postgres psql <<EOF

-- Set password for postgres user
ALTER USER postgres PASSWORD '$DB_PASSWORD';

-- Create database if not exists
SELECT 'CREATE DATABASE $DB_NAME'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$DB_NAME')\gexec

EOF

echo "Updating PostgreSQL authentication..."

# Update pg_hba.conf to allow password authentication
PG_CONF=$(sudo -u postgres psql -t -P format=unaligned -c "show hba_file")

sudo sed -i "s/local   all             postgres                                peer/local   all             postgres                                md5/" $PG_CONF
sudo sed -i "s/local   all             all                                     peer/local   all             all                                     md5/" $PG_CONF

echo "Restarting PostgreSQL..."

sudo systemctl restart postgresql

echo "PostgreSQL setup completed successfully!"