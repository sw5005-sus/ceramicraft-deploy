#!/bin/bash
set -e

# 1. read environment variables or set defaults
DB_NAME=${MLFLOW_DB_NAME:-mlflow_db}
DB_USER=${MLFLOW_DB_USER:-mlflow_user}
DB_PASS=${MLFLOW_DB_PASSWORD:-MlflowDefaultPass2026!}

# 2. create database and user if not exists
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" <<-EOSQL
    DO \$$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '$DB_USER') THEN
            CREATE USER $DB_USER WITH LOGIN PASSWORD '$DB_PASS';
        ELSE
            ALTER ROLE $DB_USER WITH LOGIN PASSWORD '$DB_PASS';
        END IF;
    END
    \$$;

    SELECT 'CREATE DATABASE $DB_NAME'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$DB_NAME')\gexec
EOSQL

# 3. grant permissions to the user 
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$DB_NAME" <<-EOSQL
    ALTER DATABASE $DB_NAME OWNER TO $DB_USER;
    GRANT ALL ON SCHEMA public TO $DB_USER;

    -- Grant privileges on existing tables and sequences in the public schema
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO $DB_USER;
    GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;
    
    -- Ensure future tables and sequences in the public schema grant privileges to $DB_USER
    ALTER DEFAULT PRIVILEGES IN SCHEMA public
        GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO $DB_USER;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public
        GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO $DB_USER;
EOSQL

# 4. modify pg_hba.conf to allow remote connections (for K3s)
HBA_FILE="/var/lib/postgresql/data/pg_hba.conf"
if ! grep -q "0.0.0.0/0" "$HBA_FILE"; then
    echo "Updating pg_hba.conf for K3s..."
    echo "host all all 0.0.0.0/0 scram-sha-256" >> "$HBA_FILE"
    pg_ctl reload
fi