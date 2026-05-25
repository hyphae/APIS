## 💻 Docker Installation & Troubleshooting Guide

### 1. Environment Setup

The environment is containerized to ensure consistency and avoid host machine dependency issues. You must map the required ports during the initial run to access the web interfaces later.

1. **Pull the base image:**
```bash
docker pull ubuntu:20.04

```


2. **Run the container with port mappings:**
```bash
docker run -it \
  -p 10000:10000 \
  -p 4382:4382 \
  -p 4390:4390 \
  -p 8000:8000 \
  -p 27017:27017 \
  --name apis-dev \
  ubuntu:20.04

```


3. **Install dependencies:**
Inside the container shell, install the necessary packages:
```bash
apt-get update && apt-get install -y \
    git \
    make \
    maven \
    groovy \
    python3-venv \
    python3-pip \
    mongodb

```



### 2. Clone and Build APIS

Clone the main repository which contains the Makefile orchestrator.

1. **Clone the repo:**
```bash
git clone https://github.com/hyphae/APIS
cd APIS

```


2. **Build all services:**
```bash
make build

```



### 3. Configuration Fix: Standardize MongoDB Port

To ensure seamless communication, all service configurations were standardized to the default MongoDB port, **27017**, resolving previous discrepancies where some services expected 27018.
<img width="885" height="296" alt="Image" src="https://github.com/user-attachments/assets/bac792fe-6c90-4ace-b3cf-416edf5d629b" />

### 4. Running the Application Suite

1. **Start services:**
```bash
make run

```


2. **Verify services:**
Access the interfaces from your host machine browser:
* **APIS Web Interface:** `http://localhost:4382`
* **Emulator Interface:** `http://localhost:4390`

<img width="1765" height="804" alt="Image" src="https://github.com/user-attachments/assets/47157db0-5a09-40b4-8c71-002e42f5d0ef" />

### 5. Persisting the Environment

To save your progress, commit the configured container to a new image from a **new terminal on your host**:

1. **Commit the container:**
```bash
docker commit apis-dev hyphae-apis-stable:latest

```


2. **Pre-built Image:**
Alternatively, pull the verified stable image:
```bash
docker pull 3akare/hyphaes-stable:latest

```



---

## ⚠️ Troubleshooting & Known Issues

### 1. Missing Port Mappings (macOS/Linux)

**Problem:** Services run successfully inside the container but `http://localhost:4382` is unreachable from the host.
**Cause:** Using `docker run` without `-p` flags.
**Solution:** You must define all ports (`10000, 4382, 4390, 8000, 27017`) at the time of container creation. Docker does not allow adding port mappings to a running container.

### 2. MongoDB Installation Failure (Ubuntu 22.04+)

**Problem:** `E: Package 'mongodb' has no installation candidate`.
**Cause:** Recent Ubuntu versions (22.04, 24.04) removed `mongodb` from default repos in favor of official MongoDB sources.
**Solution:** Add the official MongoDB 7.0 repository:

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update && sudo apt-get install -y mongodb-org

```

### 3. Python Version Incompatibility

**Problem:** `pip` fails when installing `numpy==1.19.4`.
**Cause:** Ubuntu 24.04 uses Python 3.12. NumPy 1.19.4 is deprecated and incompatible with Python versions > 3.9.
**Solution:** * **Recommended:** Use the `ubuntu:20.04` Docker image as specified in Section 1, which utilizes Python 3.8.

* **Manual Fix:** Update `apis-emulator/requirements.txt` to use `numpy>=1.26.0` if running on a modern host OS.
