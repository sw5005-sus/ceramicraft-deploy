# CeramiCraft Local Stack

本地一键启动 CeramiCraft 后端服务（基础设施 + Go 微服务 + Python 微服务）。

> **AI Agent 不包含在本 compose 中。** 每位组员自行启动自己的 Agent 服务，连接本 stack 暴露的 MCP Server（`http://localhost:8088/mcp`）。

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

## 连接你的 AI Agent

本 compose 只提供后端基础设施和 MCP Server。AI Agent 需要你单独启动：

```bash
# 方法 1：Docker（推荐）
cd ceramicraft-customer-support-agent   # 或你自己的 agent 仓库
docker compose up -d

# 方法 2：本地直接运行
uv run python serve.py
```

Agent 配置要点：
- **MCP Server URL**: `http://localhost:8088/mcp`
- 如果 agent 也在 Docker 里，需要加入同一网络（`docker compose` 默认网络名为 `ceramicraft_default`），然后用 `http://mcp-server:8080/mcp`
- **认证**: Agent 透传用户的 Zitadel JWT 到 MCP Server，MCP Server 统一验证

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
| `JWT_SECRET` | Go 服务共用的 JWT 签名密钥 | 自行生成或从 Vault |
| `VAULT_ADDR` | Vault 地址 | 默认 `http://vault.local:8200`，HTTPS 需改 |
| `VAULT_ROLE_ID` | Vault AppRole Role ID | Vault 管理员提供 |
| `VAULT_SECRET_ID` | Vault AppRole Secret ID | Vault 管理员提供 |
| `ZITADEL_APP_API_KEY` | Zitadel App API Key（JSON） | Vault `secret/ceramicraft` |
| `ZITADEL_SERVICE_API_KEY` | Zitadel Service Account Key（JSON） | Vault `secret/ceramicraft` |
| `ZITADEL_ADMIN_CLIENT_ID` | Zitadel OAuth Client ID（商家登录） | Zitadel Console → App |
| `ZITADEL_ADMIN_CLIENT_SECRET` | Zitadel OAuth Client Secret | Zitadel Console → App |
| `RBAC_PROJECT_ID` | Zitadel RBAC Project ID（可选） | Zitadel Console |
| `SMTP_PASSWORD` | QQ 邮箱 SMTP 授权码（可选） | Vault |
| `SMTP_EMAIL_FROM` | 发件人邮箱（可选） | Vault |
| `FIREBASE_CREDENTIALS_JSON` | FCM 推送凭证 JSON（可选） | Vault |

## 架构

```
┌─ Docker Compose Network ────────────────────────┐
│                                                  │
│  Infrastructure:                                 │
│    MySQL · Postgres · Kafka · MongoDB · Redis    │
│                       │                          │
│  Go Services:         │ HTTP                     │
│    product · order · user · comment · payment    │
│                       │                          │
│  Python Services:     │ HTTP                     │
│    log-ms · notification-ms · mcp-server         │
│                       │                          │
└───────────────────────┼──────────────────────────┘
                        │
                        │ MCP (Streamable HTTP)
                        │ http://localhost:8088/mcp
                        ▼
┌─ AI Agents (independently deployed) ────────────┐
│  e.g. customer-support-agent :8089               │
└──────────────────────────────────────────────────┘
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
2. **S3 图片上传不可用** — product-ms 的 S3 presign 需要 AWS 凭证，本地跳过
3. **Zitadel 认证** — user-ms 需要 4 个 Zitadel 环境变量才能正常工作（API Key + OAuth Client），不填则登录功能不可用


## 故障排查

### 端口被占用

Windows 上某些端口可能被系统服务占用（如 Hyper-V 保留端口），导致容器启动失败：

```
Error response from daemon: Ports are not available: exposing port TCP 0.0.0.0:9092 -> 0.0.0.0:0: listen tcp 0.0.0.0:9092: bind: An attempt was made to access a socket in a way forbidden by its access permissions.
```

**排查步骤：**

```powershell
# 1. 查看哪个进程占了端口
netstat -ano | findstr :<端口号>

# 2. 查看 Hyper-V / WSL 保留的端口范围
netsh interface ipv4 show excludedportrange protocol=tcp
```

**解决方案：**

- **方法 1 — 改映射端口**（推荐）：在 `docker-compose.yml` 里把宿主机端口改掉，比如 `3306` → `13306`
- **方法 2 — 释放保留端口**：

  ```powershell
  # 管理员权限运行
  net stop winnat
  net start winnat
  ```

- **方法 3 — 排除端口不被保留**：

  ```powershell
  # 管理员权限运行，永久排除某端口
  netsh int ipv4 add excludedportrange protocol=tcp startport=9092 numberofports=1
  ```

> 如果你遇到端口冲突，参照上述方法处理。

### `docker compose restart` 不读新的 `.env`

修改 `.env` 后，用 `restart` 不会重读环境变量。必须用：

```bash
docker compose up -d
```

这会重建受影响的容器并应用新的环境变量。

### Vault 连接问题

Go 服务（order-ms / payment-ms / user-ms）启动时需要连 Vault 拉取配置。如果 Vault 不可达，服务会启动失败。

- 确认 `.env` 中 `VAULT_ADDR`、`VAULT_ROLE_ID`、`VAULT_SECRET_ID` 已正确填写
- 默认 `VAULT_ADDR=http://vault.local:8200`；如果 Vault 用 HTTPS + 自签证书，compose 中已设置 `VAULT_SKIP_VERIFY=true`
- Vault TLS 证书签给 `vault.local` 域名，compose 中已配置 `extra_hosts` 将其解析到实际 IP
