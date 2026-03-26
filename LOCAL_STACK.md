# CeramiCraft Local Stack

本地一键启动全部 CeramiCraft 后端服务。

## 快速开始

```bash
# 1. 进入 deploy 目录
cd ceramicraft-deploy

# 2. 复制环境变量模板
cp .env.example .env

# 3. 编辑 .env，填入必要的密钥（见下方说明）

# 4. 启动全部服务
docker compose -f docker-compose.local.yml up -d

# 5. 查看状态
docker compose -f docker-compose.local.yml ps
```

## 服务端口映射

| 服务 | 容器端口 | 宿主机端口 | Health Check |
|------|---------|-----------|-------------|
| MySQL | 3306 | 3306 | mysqladmin ping |
| PostgreSQL | 5432 | 5432 | pg_isready |
| Kafka | 9092 | 9092 | broker-api-versions |
| MongoDB | 27017 | 27017 | mongosh ping |
| Redis | 6379 | 6379 | redis-cli incr |
| product-ms | 8080 / 5001 | **8081** / 5011 | /product-ms/v1/ping |
| order-ms | 8080 / 5001 | **8082** / 5012 | /order-ms/v1/ping |
| user-ms | 8080 / 5001 | **8083** / 5013 | /user-ms/v1/ping |
| comment-ms | 8080 / 5001 | **8084** / 5014 | /comment-ms/v1/ping |
| payment-ms | 8080 / 5001 | **8085** / 5015 | /payment-ms/v1/ping |
| log-ms | 8080 / 50051 | **8086** / 50061 | /log-ms/v1/ping |
| notification-ms | 8080 / 50051 | **8087** / 50062 | /notification-ms/v1/ping |
| mcp-server | 8080 | **8088** | /health |
| cs-agent | 8080 | **8089** | /health |

## 环境变量说明

### 已填好默认值（开箱即用）

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `MYSQL_PASSWORD` | `ceramicraft123` | MySQL root 密码 |
| `POSTGRES_USER` | `ceramicraft` | PostgreSQL 用户名 |
| `POSTGRES_PASSWORD` | `ceramicraft123` | PostgreSQL 密码 |

### 需要你填的

| 变量 | 说明 | 从哪里获取 |
|------|------|-----------|
| `ZITADEL_APP_API_KEY` | Zitadel App API Key（JSON） | Vault `secret/ceramicraft` |
| `ZITADEL_SERVICE_API_KEY` | Zitadel Service Account Key（JSON） | Vault `secret/ceramicraft` |
| `OPENAI_API_KEY` | OpenAI API Key | 已有，填到 .env |
| `SMTP_PASSWORD` | QQ 邮箱 SMTP 授权码 | Vault（可选） |
| `SMTP_EMAIL_FROM` | 发件人邮箱 | Vault（可选） |
| `FIREBASE_CREDENTIALS_JSON` | FCM 推送凭证 JSON | Vault（可选） |
| `LANGSMITH_API_KEY` | LangSmith 追踪（可选） | langsmith.com |

## 架构

```
                    ┌─────────────────────────────────────────────┐
                    │           Docker Compose Network            │
                    │                                             │
                    │  ┌─────┐ ┌────────┐ ┌─────┐ ┌──────┐ ┌───┐│
                    │  │MySQL│ │Postgres│ │Kafka│ │Mongo │ │Redis│
                    │  └──┬──┘ └───┬────┘ └──┬──┘ └──┬───┘ └─┬──┘│
                    │     │        │         │       │       │    │
                    │  ┌──┴────────┴─────────┴───────┴───────┴──┐│
                    │  │         Go Backend Services             ││
                    │  │  product │ order │ user │ comment │ pay ││
                    │  └────────────────┬────────────────────────┘│
                    │                   │ HTTP :8080              │
                    │  ┌────────────────┴───────────────────────┐ │
                    │  │  Python Services                       │ │
                    │  │  log-ms │ notification-ms │ mcp-server │ │
                    │  └────────────────┬───────────────────────┘ │
                    │                   │ MCP (Streamable HTTP)   │
                    │  ┌────────────────┴───────────────────────┐ │
                    │  │  customer-support-agent                │ │
                    │  └────────────────────────────────────────┘ │
                    └─────────────────────────────────────────────┘
```

## 常用命令

```bash
# 只启动基础设施
docker compose -f docker-compose.local.yml up -d mysql postgres kafka mongodb redis

# 查看某个服务日志
docker compose -f docker-compose.local.yml logs -f mcp-server

# 重启某个服务
docker compose -f docker-compose.local.yml restart product-ms

# 停止并清理
docker compose -f docker-compose.local.yml down

# 停止并删除数据卷（重来）
docker compose -f docker-compose.local.yml down -v
```

## 注意事项

1. **首次启动慢** — MySQL 需要导入 ~35MB 的 order_db.sql，耐心等 1-2 分钟
2. **customer-support-agent 是本地构建** — 需要 Docker 能访问 `../ceramicraft-customer-support-agent` 目录
3. **S3 图片上传不可用** — product-ms 的 S3 presign 需要 AWS 凭证，本地跳过
4. **Zitadel 认证** — user-ms 需要 Zitadel API key 才能完成登录流程，不填则登录功能不可用
