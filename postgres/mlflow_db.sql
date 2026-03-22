-- ./postgres/mlflow_db.sql
-- MLflow 数据库初始化脚本
-- 仅在 PostgreSQL 容器首次启动时执行

-- 创建 MLflow 专用数据库
CREATE DATABASE mlflow_db;

-- 创建 MLflow 专用用户 (密码请修改为强密码)
CREATE USER mlflow_user WITH PASSWORD 'MlflowSecurePass2026!';

-- 授权用户对数据库的完整权限
GRANT ALL PRIVILEGES ON DATABASE mlflow_db TO mlflow_user;

-- 授权 schema 权限 (PostgreSQL 15+ 需要)
\c mlflow_db
GRANT ALL ON SCHEMA public TO mlflow_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO mlflow_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO mlflow_user;

-- 设置默认权限 (后续创建的表也自动授权)
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO mlflow_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO mlflow_user;