# CeramiCraft One-Click Deployment Guide

CeramiCraft is a microservices-based e-commerce platform for ceramic crafts, supporting both merchant and customer applications.

## 🏗️ Project Architecture

```
ceramicraft-deploy/
├── monitor-serv/              # Monitoring Environment Configuration
├── mysql/                     # MySQL Initialization Scripts
└── docker-compose.yml         # Production Docker Compose File
```

## Quick Start

### Prerequisites

Ensure your system has the following software installed:

- [Docker](https://docs.docker.com/get-docker/) (version 20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 2.0+)
- [Git](https://git-scm.com/downloads) (version 2.30+)

### 1. Clone the Project

```bash
# Clone the main project repository
git clone https://github.com/sw5005-sus/ceramicraft-deploy.git
cd ceramicraft-deploy
```

### 2. One-Click Deployment

```bash
# Build and start all services
docker-compose up -d

# Check service status
docker-compose ps

# View service logs
docker-compose logs -f
```

## 🛠️ Development and Debugging

### View Real-time Logs

```bash
# View all service logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f mysql
```

### Restart Services

```bash
# Restart all services
docker-compose restart

# Restart specific service
docker-compose restart mysql
```

### Rebuild Services

```bash
# Rebuild and start
docker-compose up -d --build

# Rebuild specific service
docker-compose build mysql
docker-compose up -d mysql
```

## Environment Cleanup

**Production Environment Cleanup:**
```bash
# Stop all services
docker-compose down

# Stop and remove data volumes (Warning: Will delete database data)
docker-compose down -v

# Remove all related images
docker-compose down --rmi all
```

**Development Environment Cleanup:**
```bash
# Execute in dev-env directory
cd dev-env

# Stop development environment services
docker-compose down

# Stop and remove development environment data volumes
docker-compose down -v

# Remove development environment related images
docker-compose down --rmi all
```

## 📝 Update Project

```bash
# Update main project
git pull origin main

# Rebuild and deploy
docker-compose up -d --build
```

## 🤝 Contributing

1. Fork this project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

If you encounter issues or need help:

- Submit an [Issue](https://github.com/NUS-ISS-Agile-Team/ceramicraft-deploy/issues)
- Check the project documentation
- Contact the development team

---

**Note**: This project is for development and testing environments only. For production deployment, please refer to the production environment configuration guide.
