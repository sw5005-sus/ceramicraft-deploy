# CeramiCraft 一键部署指南

[README in English Click Me](./README_EN.md)

CeramiCraft 是一个基于微服务架构的陶瓷工艺品电商平台，支持商户和客户端双端应用。

## 🏗️ 项目架构

```
ceramicraft-deploy/
├── monitor-serv/              # 监控环境配置
├── mysql/                     # MySQL 初始化脚本
└── docker-compose.yml         # 生产环境 Docker 编排文件
```

## 快速开始

### 前置要求

确保您的系统已安装以下软件：

- [Docker](https://docs.docker.com/get-docker/) (版本 20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (版本 2.0+)
- [Git](https://git-scm.com/downloads) (版本 2.30+)

### 1. 克隆项目

```bash
# 克隆主项目仓库
git clone https://github.com/sw5005-sus/ceramicraft-deploy.git
cd ceramicraft-deploy
```

### 2. 一键部署

```bash
# 构建并启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看服务日志
docker-compose logs -f

## 🛠️ 开发和调试

### 查看实时日志

```bash
# 查看所有服务日志
docker-compose logs -f

# 查看特定服务日志
docker-compose logs -f mysql
```

### 重启服务

```bash
# 重启所有服务
docker-compose restart

# 重启特定服务
docker-compose restart mysql
```

### 重新构建服务

```bash
# 重新构建并启动
docker-compose up -d --build

# 重新构建特定服务
docker-compose build mysql
docker-compose up -d mysql
```

## 清理环境

**生产环境清理：**
```bash
# 停止所有服务
docker-compose down

# 停止并删除数据卷 (注意：会删除数据库数据)
docker-compose down -v

# 删除所有相关镜像
docker-compose down --rmi all
```

**开发环境清理：**
```bash
# 在 dev-env 目录下执行
cd dev-env

# 停止开发环境服务
docker-compose down

# 停止并删除开发环境数据卷
docker-compose down -v

# 删除开发环境相关镜像
docker-compose down --rmi all
```

## 📝 更新项目

```bash
# 更新主项目
git pull origin main

# 重新构建并部署
docker-compose up -d --build
```

## 🤝 贡献指南

1. Fork 本项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 支持

如果您遇到问题或需要帮助：

- 提交 [Issue](https://github.com/sw5005-sus/ceramicraft-deploy/issues)
- 查看项目文档
- 联系开发团队

---

**注意**: 本项目仅用于开发和测试环境。生产环境部署请参考生产环境配置指南。