# CeramiCraft Local Stack

本地一键启动全部 CeramiCraft 后端服务。

## 前置条件

customer-support-agent 服务是本地构建的，需要先 clone 仓库到与 `ceramicraft-deploy` 同级的目录：

```
parent/
├── ceramicraft-deploy/          ← 本仓库
└── ceramicraft-customer-support-agent/  ← 需要手动 clone
```

```bash
# 在 ceramicraft-deploy 的同级目录下
git clone https://github.com/sw5005-sus/ceramicraft-customer-support-agent.git
```

## 快速开始

```bash
# 1. 进入 local-stack 目录
cd ceramicraft-deploy/local-stack

# 2. 复制环境变量模板
cp .env.example .env

# 3. 编辑 .env，填入必要的密钥（见下方说明）

# 4. 启动全部服务
docker compose up -d

# 5. 查看状态
docker compose ps
```

## 服务端口映射

| 服务 | 容器端口 | 宿主机端口 | Health Check |
|------|---------|-----------|-------------|
| MySQL | 3306 | 3306 | mysqladmin ping |
| PostgreSQL | 5432 | 5432 | pg_isready |
| Kafka | 9092 | 9092 | broker-api-versions |
| MongoDB | 27017 | 27017 | mongosh ping |
| Redis | 6379 | 6379 | redis-cli ping |
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
| `ZITADEL_ADMIN_CLIENT_ID` | Zitadel OAuth Client ID（商家登录） | Zitadel Console → App |
| `ZITADEL_ADMIN_CLIENT_SECRET` | Zitadel OAuth Client Secret | Zitadel Console → App |
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
docker compose up -d mysql postgres kafka mongodb redis

# 查看某个服务日志
docker compose logs -f mcp-server

# 重启某个服务
docker compose restart product-ms

# 停止并清理
docker compose down

# 停止并删除数据卷（重来）
docker compose down -v
```

## 注意事项

1. **首次启动慢** — MySQL 需要导入 ~35MB 的 order_db.sql，耐心等 1-2 分钟
2. **目录结构** — customer-support-agent 是本地构建，需要仓库在 `ceramicraft-deploy` 同级目录（见前置条件）
3. **S3 图片上传不可用** — product-ms 的 S3 presign 需要 AWS 凭证，本地跳过
4. **Zitadel 认证** — user-ms 需要 4 个 Zitadel 环境变量才能正常工作（API Key + OAuth Client），不填则登录功能不可用
