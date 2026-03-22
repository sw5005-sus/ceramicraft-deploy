#!/bin/bash
set -e

# 使用 psql 执行初始化逻辑
# 变量说明：
# MLFLOW_DB_USER 和 MLFLOW_DB_PASSWORD 应通过 docker-compose 环境变量传入
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- 1. 创建用户 (如果不存在)
    DO \$$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '${MLFLOW_DB_USER:-mlflow_user}') THEN
            CREATE USER ${MLFLOW_DB_USER:-mlflow_user} WITH PASSWORD '${MLFLOW_DB_PASSWORD:-MlflowDefaultPass2026}';
        END IF;
    END
    \$$;

    -- 2. 创建数据库 (注意：CREATE DATABASE 不能在事务块/DO块中执行)
    -- 我们通过 shell 逻辑或 SQL 技巧来处理
EOSQL

# 检查数据库是否存在并创建
DATABASE_EXISTS=$(psql -tAc "SELECT 1 FROM pg_database WHERE datname='${MLFLOW_DB_NAME:-mlflow_db}'")
if [ "$DATABASE_EXISTS" != "1" ]; then
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE DATABASE ${MLFLOW_DB_NAME:-mlflow_db} OWNER ${MLFLOW_DB_USER:-mlflow_user};"
fi

# 3. 授权逻辑
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "${MLFLOW_DB_NAME:-mlflow_db}" <<-EOSQL
    -- 授权 Schema 权限 (PostgreSQL 15+)
    GRANT ALL ON SCHEMA public TO ${MLFLOW_DB_USER:-mlflow_user};
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ${MLFLOW_DB_USER:-mlflow_user};
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO ${MLFLOW_DB_USER:-mlflow_user};

    -- 设置默认权限
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO ${MLFLOW_DB_USER:-mlflow_user};
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO ${MLFLOW_DB_USER:-mlflow_user};
    
    -- 打印进度
    \echo 'MLflow database initialization completed successfully.'
EOSQL