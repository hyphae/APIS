## 🛠️ Development Guide

This guide covers local development setup for contributors.

### Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| **Docker** | 20.10+ | Container runtime |
| **Docker Compose** | v2.0+ | Service orchestration |
| **Git** | 2.30+ | Version control |

Optional (for native development without Docker):
- **JDK** 11+ and **Maven** 3.6+
- **Groovy** 2.5+
- **Python** 3.8+ with `python3-venv`
- **MongoDB** 6.0+

---

### Running with Docker Compose

```bash
# Build from source and start all services
docker compose up --build

# Run in detached mode
docker compose up --build -d

# View logs
docker compose logs -f apis

# Stop everything
docker compose down

# Stop and clean volumes
docker compose down -v
```

### Running Natively

See [Host Installation](INSTALL_HOST.md) for native setup instructions.

```bash
# Build all components
make build

# Start all services (requires MongoDB running on port 27017)
make run

# Stop all services
make stop
```

---

### Project Architecture

```
APIS/                          # Orchestrator repository
├── Makefile                   # Build/run/stop orchestrator
├── docker-compose.yml         # Docker Compose configuration
├── docker/
│   ├── Dockerfile             # Multi-stage build
│   └── entrypoint.sh          # Service startup script
├── mongodb/                   # MongoDB scripts
├── apis-bom/                  # [Java] Bill of Materials
├── apis-common/               # [Java] Shared libraries
├── apis-main/                 # [Java/Vert.x] Core energy exchange engine
├── apis-ccc/                  # [Java/Vert.x] Cluster coordination
├── apis-log/                  # [Java] Log aggregation
├── apis-web/                  # [Java/Vert.x] Web API layer
├── apis-emulator/             # [Python] Hardware simulator
├── apis-main_controller/      # [Python] Dashboard UI
├── apis-service_center/       # [Python/Django] Admin panel
└── apis-tester/               # [Python] Test framework
```

### Service Ports

| Port | Service | Protocol |
|------|---------|----------|
| 4382 | Main Controller | HTTP |
| 4390 | Emulator | HTTP |
| 8000 | Service Center | HTTP |
| 10000 | Tester | HTTP |
| 27017 | MongoDB | TCP |

### Build Order

Java services must be built in order:

1. `apis-bom` (Maven BOM — install first)
2. `apis-common` (Shared library — install second)
3. `apis-main`, `apis-ccc`, `apis-log`, `apis-web` (Can build in parallel)
4. Python services (`apis-emulator`, `apis-main_controller`, `apis-service_center`, `apis-tester`) can build in parallel

---

### Troubleshooting

**Port conflicts:** Ensure ports 4382, 4390, 8000, 10000, and 27017 are not in use.

**Docker build fails:** Clear Docker cache and rebuild:
```bash
docker compose build --no-cache
```

**Services not connecting:** Services may take 30-60 seconds to fully start due to Hazelcast cluster formation. Check logs:
```bash
docker compose logs -f apis
```
