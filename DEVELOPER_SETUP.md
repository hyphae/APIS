# 🛠️ Developer Setup Guide

Welcome to the APIS development community! This guide will help you set up your local development environment to contribute to APIS.

## 📋 Prerequisites

Before you begin, ensure you have the following installed on your system:

### General Tools
- **Git**: For version control.
- **Make**: For running build scripts.
- **Python 3.6+**: Required for `apis-emulator` and other scripts.
- **Java Development Kit (JDK) 11+**: Required for Java modules (`apis-main`, `apis-common`, etc.).
- **Maven**: For building Java projects.

### OS-Specific Dependencies

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install git make maven groovy python3-venv python3-pip
```

#### macOS
We recommend using [Homebrew](https://brew.sh/):
```bash
brew install git make maven groovy python3
```

#### CentOS/RHEL
```bash
sudo yum install git make maven groovy python3
```

---

## 🚀 Setting Up the Project

### 1. Clone the Repository
Clone your fork of the repository:
```bash
git clone https://github.com/YOUR_USERNAME/APIS.git
cd APIS
```

### 2. Initialize Submodules
The APIS project uses git submodules. Initialize them to pull the code for all components:
```bash
git submodule update --init --recursive
```
*Note: The `make` commands typically handle submodule cloning, but doing it manually ensures everything is ready.*

### 3. Build the Project
Use the provided `Makefile` to build all components:
```bash
make build
```
This process may take 5-10 minutes as it downloads dependencies and compiles code.

### 4. Run the System
Start all APIS services:
```bash
make run
```

---

## 🔧 Troubleshooting

### **Port Conflicts**
If `make run` fails, check if the default ports are already in use:
- **4382**: Main Controller
- **4390**: Hardware Emulator
- **27017/27018**: MongoDB

To free a port (e.g., 4382) on Linux/macOS:
```bash
lsof -i :4382
kill -9 <PID>
```

### **Permission Denied (Scripts)**
If you encounter permission errors when running scripts:
```bash
chmod +x runner.sh
chmod +x */*.sh
```

### **Maven Build Failures**
- Ensure you are using a compatible JDK version (`java -version`).
- Try cleaning the build: `make clean` followed by `make build`.

---

## 💻 Development Workflow

1. **Create a Branch**: Always work on a new branch for your feature or fix.
   ```bash
   git checkout -b feature/my-new-feature
   ```
2. **Make Changes**: Edit the code in the respective submodule directories.
3. **Test**: Run local tests if available (check sub-repo READMEs).
4. **Commit**: Sign your commits (DCO).
   ```bash
   git commit -s -m "feat: description of change"
   ```
5. **Push**: Push to your fork and create a Pull Request.

---

## 📚 Component Documentation
- [apis-main](https://github.com/hyphae/apis-main) - Core logic
- [apis-emulator](https://github.com/hyphae/apis-emulator) - Hardware simulation
- [apis-web](https://github.com/hyphae/apis-web) - Web interface backend

Need help? Open an issue on GitHub!
