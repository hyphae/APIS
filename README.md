# 🔋 APIS - Autonomous Power Interchange System

> **Share energy like sharing WiFi** - Connect your batteries and let communities power themselves

![image 8](https://github.com/user-attachments/assets/2630dda3-97c9-424f-b20f-034af584be10)

---

## 🎯 What is APIS?

**APIS** is an innovative open-source platform that enables **Physical Peer-to-Peer (PP2P) energy sharing** between distributed batteries in microgrids. By leveraging Variable Renewable Energy (VRE) sources, APIS builds resilient microgrids that enhance community self-sufficiency and reduce dependency on traditional centralized power generation.

### 🌟 Why This Matters

Imagine if your home battery could automatically share power with your neighbors when they need it, and get power back when you need it. That's exactly what APIS does!

- **💰 Save Money**: Share excess solar power instead of selling it back to the grid at low prices
- **🔋 Stay Powered**: Never run out of energy when your neighbors have extra
- **🌱 Go Green**: Maximize renewable energy use in your community  
- **🏠 Be Independent**: Reduce reliance on big power companies
- **🛡️ Build Resilience**: Keep communities powered during grid outages

Click [here](https://www.sonycsl.co.jp/tokyo/11481/) for more details about the research behind APIS.

---

## 🏗️ Understanding APIS Architecture

### Core Concepts

Before diving into the technical details, let's understand the key concepts that make APIS unique:

#### 🔋 **Physical Peer-to-Peer (PP2P) Energy Sharing**
Unlike traditional energy systems where power flows from centralized generators to consumers, APIS enables **direct energy transfer between batteries**. Imagine your home battery lending power directly to your neighbor's battery - no grid involvement required!

**Why This Matters:**
- **Efficiency**: Eliminates transmission losses through the grid
- **Resilience**: Works during power outages
- **Economics**: Keep energy money in the community
- **Sustainability**: Maximize renewable energy utilization

#### ⚡ **Constant Current Control**
APIS uses **precise current control** to enable exact energy amounts to be transferred between specific batteries. This is technically challenging because:

- Traditional voltage control fails when batteries have different charge levels
- APIS maintains constant current regardless of voltage differences
- Enables "fixed-amount" energy transactions (e.g., exactly 1 kWh from Battery A to Battery B)

#### 🧠 **Autonomous Distributed Control**
Every APIS installation runs the **same software** and makes **independent decisions** based on local conditions. This creates a truly decentralized network where:

- **No Central Authority**: No single point of control or failure
- **Flexible Rules**: Each battery system can have different trading preferences
- **Dynamic Adaptation**: Conditions can change based on time, price, or energy availability
- **Scalable**: Works from 2 batteries to thousands

### System Building Blocks

#### The Three Layers of APIS

**1. Hardware Layer** 🔌
- **Real Batteries**: Physical energy storage systems
- **DC/DC Converters**: Power electronics that control energy flow
- **Sensors**: Voltage, current, temperature monitoring
- **Communication**: Hardware interfaces (CAN bus, RS-485, etc.)

**2. Control Layer** 🧠
- **Energy Engine**: Decision-making algorithms for trading
- **Communication Protocols**: Peer discovery and negotiation
- **Safety Systems**: Over-current protection, emergency shutdown
- **State Management**: Battery status, transaction records

**3. User Layer** 👥
- **Monitoring Dashboards**: Real-time system visualization
- **Configuration Interfaces**: Trading rules and preferences
- **Analytics**: Performance metrics and reporting
- **Community Management**: Multi-user coordination

#### Data Flow Patterns

**Energy Flow** (Physical):
```
Battery A → DC/DC Converter → Power Lines → DC/DC Converter → Battery B
```

**Information Flow** (Digital):
```
Sensors → Control System → Decision Engine → Trading Protocol → Peer Systems
```

**User Interaction** (Interface):
```
User → Web Dashboard → API Gateway → Control Systems → Hardware
```

### Getting Started Prerequisites

#### Technical Knowledge Required

**For Basic Usage:**
- Basic computer skills (installing software, using web browsers)
- Understanding of electricity concepts (voltage, current, batteries)
- No programming knowledge required

**For Development:**
- **Programming**: Java, Python, or Groovy knowledge
- **Web Development**: HTML/CSS/JavaScript for UI changes
- **Systems Administration**: Linux server management
- **Electronics**: Understanding of DC/DC converters and battery systems

#### System Requirements

**Minimum Hardware:**
- **CPU**: Dual-core 2GHz+ processor
- **RAM**: 4GB (8GB recommended)
- **Storage**: 20GB free space
- **Network**: 100Mbps Ethernet (Gigabit preferred)

**Recommended for Development:**
- **CPU**: Quad-core 3GHz+ processor
- **RAM**: 16GB
- **Storage**: 50GB SSD
- **Network**: Gigabit Ethernet

#### Time Investment

**Quick Evaluation**: 30 minutes (just run the demo)
**Basic Installation**: 1-2 hours (follow quick start guide)
**Full System Setup**: 4-8 hours (production deployment)
**Development Setup**: 1-2 days (learning curve for contributors)

### Common Misconceptions

**❌ APIS is just software for existing solar systems**
✅ APIS is a complete peer-to-peer energy trading platform that works with any batteries

**❌ APIS requires special hardware**
✅ APIS works with standard batteries and DC/DC converters (with proper drivers)

**❌ APIS needs internet to function**
✅ APIS works completely offline in local networks (internet optional for remote monitoring)

**❌ APIS is only for solar power**
✅ APIS works with any DC energy source (solar, wind, grid, generators)

**❌ APIS replaces the electrical grid**
✅ APIS complements the grid by enabling local energy sharing and backup power

### Architecture Decision Records

**Why Java for core components?**
- Mature ecosystem for enterprise applications
- Excellent threading support for concurrent energy trading
- Strong tooling ecosystem (Maven, IDEs, profilers)

**Why Python for user interfaces?**
- Rapid development and prototyping
- Rich web framework ecosystem (Flask, Django)
- Easy integration with scientific computing (NumPy, Pandas)

**Why MongoDB for data storage?**
- Flexible schema for varying energy transaction data
- Good performance for time-series energy data
- Easy horizontal scaling for large deployments

**Why multicast UDP for communication?**
- Efficient broadcast to multiple peers simultaneously
- Low latency for real-time energy trading decisions
- No single point of failure (peer-to-peer)

---

## 🔧 How It Works

## 🔧 How It Works

![image 5](https://github.com/user-attachments/assets/4a2b2b5c-41e6-4bc8-8d7f-a150740c80e5)

### Physical Peer to Peer (PP2P) Energy Sharing

APIS achieves **precise energy sharing between batteries using constant current control**. This technology:

- ✅ **Offsets energy shortages** by delivering the necessary amount from surplus batteries
- ✅ **Enables fixed-amount power transfers** between specific users (batteries)
- ✅ **Supports P2P energy trading** based on energy amount and price conditions
- ✅ **Works where voltage control fails** - providing true peer-to-peer transactions

![PP2P Technology Diagram](https://user-images.githubusercontent.com/71874910/95694571-c0c47080-0c6d-11eb-9935-89d62e43228c.PNG)

### Autonomous Distributed Control

**The same software is installed on every battery system**, creating a truly decentralized network where:

- 🤖 **Smart Decision Making**: Each system makes autonomous trading decisions
- ⚙️ **Flexible Conditions**: Set different trading rules for each battery system
- 🕐 **Dynamic Updates**: Change conditions for each time window
- 📊 **Custom Parameters**: Configure energy amount, pricing, and timing preferences

![Autonomous Control Diagram](https://user-images.githubusercontent.com/71874910/95833927-3ff19b80-0d77-11eb-9bc7-1994e641d5fd.PNG)

---

## 🚀 Quick Start Guide

### ⚡ Prerequisites Check (30 seconds)

Before starting, ensure your system is ready:

```bash
# Quick system check
echo "=== APIS Quick Start Prerequisites ==="
echo "Operating System: $(uname -s)"
echo "Available Memory: $(free -h | grep '^Mem:' | awk '{print $2}')"

# Check core dependencies
command -v git >/dev/null 2>&1 && echo "✓ Git installed" || echo "✗ Git missing"
command -v make >/dev/null 2>&1 && echo "✓ Make installed" || echo "✗ Make missing"
command -v java >/dev/null 2>&1 && echo "✓ Java installed" || echo "✗ Java missing"
command -v mvn >/dev/null 2>&1 && echo "✓ Maven installed" || echo "✗ Maven missing"
command -v python3 >/dev/null 2>&1 && echo "✓ Python3 installed" || echo "✗ Python3 missing"

# Check disk space (need ~20GB)
DISK_SPACE=$(df . | tail -1 | awk '{print $4}')
if [ "$DISK_SPACE" -gt 20000000 ]; then
    echo "✓ Sufficient disk space"
else
    echo "✗ Insufficient disk space (need 20GB+)"
fi
```

**If any prerequisites are missing, see the [System Requirements & Setup](#-system-requirements--setup) section above.**

---

### 🏃‍♂️ Express Start (5 Minutes - If Prerequisites OK)

```bash
# 1. Clone and enter project
git clone https://github.com/hyphae/APIS.git
cd APIS

# 2. Build all components (takes 5-10 minutes)
make build

# 3. Start the system
make run
```

**Success Indicators:**
- No error messages during build
- Multiple terminal windows open (one per service)
- Services show "Started" or similar status messages

---

### 🌐 Access Your APIS System

Once running, access these interfaces:

| Service | URL | Purpose | Expected Status |
|---------|-----|---------|-----------------|
| 📊 **Main Controller** | `http://localhost:4382/` | Primary dashboard and energy trading controls | Shows battery status and control panel |
| 🔧 **Hardware Emulator** | `http://localhost:4390/` | Battery and DC/DC converter simulation | Simulator control interface |
| 🧪 **Testing Interface** | `http://localhost:10000/` | System testing and validation tools | Test scenario controls |
| 🏢 **Service Center** | `http://localhost:8000/static/ui_example/staff/visual.html` | Admin interface (login: admin/admin) | Community management dashboard |

> **💡 Pro Tip**: If `0.0.0.0` doesn't work, try `localhost` or `127.0.0.1` instead

---

### ⚡ Start Your First Energy Exchange

#### Step-by-Step Energy Trading Demo

1. **Open Main Controller**
   - Navigate to `http://localhost:4382/`
   - Clear browser cache (Ctrl+F5 or Cmd+Shift+R)
   - You should see the main dashboard

2. **Check System Status**
   - Look for "System Status: Ready" indicator
   - Verify battery icons show (Battery 1, Battery 2, etc.)
   - Check that all components show green/connected status

3. **Start Energy Trading**
   - Find the "Global Mode" dropdown or button
   - Change from "Stop" to "Run"
   - Click "Apply" or "Start Trading"

4. **Watch Energy Flow**
   - Monitor battery SOC (State of Charge) levels
   - Observe energy transfer animations between batteries
   - Check transaction logs for trading activity
   - View real-time power flow diagrams

5. **Experiment with Settings**
   - Adjust trading parameters (price, amount limits)
   - Try different battery configurations
   - Observe how the system adapts to changes

---

### 🔄 Alternative Quick Start Methods

#### Option 1: Individual Service Testing
```bash
# Test components one by one
make run-apis-emulator    # Start just the emulator
make run-apis-main_controller  # Add the controller

# Then check individual URLs
# http://localhost:4390/ (emulator)
# http://localhost:4382/ (controller)
```

#### Option 2: Minimal Configuration
```bash
# For systems with limited resources
make run-mongodb          # Just database
make run-apis-service_center  # Just admin interface
# Access: http://localhost:8000/static/ui_example/staff/visual.html
```

#### Option 3: Development Mode
```bash
# Build only core components first
make build-apis-emulator
make build-apis-main_controller
make build-apis-web

# Test core functionality
make run-apis-emulator
make run-apis-main_controller
make run-apis-web
```

---

### 🚨 Quick Start Troubleshooting

#### If Build Fails
```bash
# Check what failed
make build 2>&1 | tail -20  # See last 20 lines of errors

# Common fixes:
# Out of memory: Close other applications
# Network timeout: Check internet, retry
# Permission denied: Use sudo for system installs
# Java version wrong: Ensure Java 11 exactly
```

#### If Services Don't Start
```bash
# Check if ports are available
lsof -i :4382 || echo "Port 4382 free"
lsof -i :4390 || echo "Port 4390 free"
lsof -i :27018 || echo "MongoDB port free"

# Kill conflicting processes
# Linux/macOS:
kill -9 $(lsof -ti :4382)  # Replace with actual port

# Windows:
# Use Task Manager or: taskkill /PID <PID> /F
```

#### If Web Interfaces Don't Load
```bash
# Try different URLs
curl -I http://localhost:4382/  # Should return HTTP 200
curl -I http://127.0.0.1:4382/  # Alternative localhost

# Check if services are actually running
ps aux | grep python  # Should see Python processes
ps aux | grep java    # Should see Java processes

# Firewall issues (Linux)
sudo ufw allow 4382
sudo ufw allow 4390
```

#### If Energy Trading Doesn't Start
- **Check Global Mode**: Ensure it's set to "Run" in Main Controller
- **Verify Battery Connection**: Look for green status indicators
- **Check Logs**: Look for error messages in terminal windows
- **Network Issues**: Ensure multicast is enabled (firewall settings)
- **MongoDB**: Verify database is running on port 27018

---

### 🛑 Stop and Cleanup

```bash
# Stop all services
make stop

# Clean build artifacts (optional)
make clean

# Reset everything (CAUTION: removes all data)
rm -rf apis-*/ mongodb/db/*
```

---

### 📞 Need Help?

- **Check the [detailed troubleshooting section](#-troubleshooting)**
- **Verify your [system meets requirements](#-system-requirements--setup)**
- **Join the community** for support
- **File an issue** on GitHub with your error logs

**Expected Timeline:**
- Prerequisites check: 30 seconds
- Full build: 5-10 minutes (depends on internet speed)
- System startup: 1-2 minutes
- First energy exchange: Instant once system is ready

**🎉 Success!** You should now see energy autonomously flowing between virtual batteries, demonstrating peer-to-peer energy sharing in action.

---

## 🛠️ System Components

![image 9](https://github.com/user-attachments/assets/61ced950-9bc5-4cef-84dd-f322c10fdd1b)

APIS is a distributed system composed of multiple specialized services that work together to enable peer-to-peer energy sharing. Each component has a specific role in the overall architecture, communicating through well-defined APIs and protocols.

---

## 🏗️ System Architecture Overview

### Data Flow Architecture
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   User Interface│    │  Control Plane   │    │  Data Plane     │
│                 │    │                  │    │                 │
│ • Main Controller│◄──►│ • Service Center │◄──►│ • APIS Main     │
│ • Web Dashboard │    │ • CCC Network    │    │ • Energy Engine │
│ • Admin Interface│    │ • Analytics      │    │ • Trading Logic │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 ▼
                    ┌─────────────────────┐
                    │  Hardware Layer     │
                    │                     │
                    │ • Battery Emulator  │
                    │ • Real Hardware     │
                    │ • DC/DC Converters  │
                    └─────────────────────┘
```

### Communication Patterns
- **Multicast UDP**: Real-time energy trading data
- **HTTP REST APIs**: Configuration and status queries
- **WebSocket**: Live dashboard updates
- **MongoDB**: Persistent data storage

---

## 🔋 Core Components Deep Dive

### 🧠 APIS Main - The Energy Exchange Engine

**What it does:** The heart of the energy trading system. Implements the autonomous distributed control algorithm that makes real-time decisions about energy transfers between batteries.

**Key Features:**
- **Autonomous Trading**: Each instance makes independent decisions based on local conditions
- **Real-time Optimization**: Continuously calculates optimal energy flows using constant current control
- **Multi-battery Coordination**: Manages up to 4 battery systems simultaneously
- **Fault Tolerance**: Continues operating even if individual batteries fail

**Technical Details:**
- **Language**: Java + Groovy
- **Protocol**: Custom multicast UDP for peer discovery and trading
- **Ports**: Dynamic (assigned at startup)
- **Dependencies**: MongoDB for transaction logging

**How it works:**
1. Discovers other APIS Main instances on the network via multicast
2. Monitors local battery SOC (State of Charge) levels
3. Calculates trading opportunities based on predefined rules
4. Executes energy transfers using precise current control
5. Logs all transactions for analytics and billing

---

### 📊 Main Controller - Visual Dashboard

**What it does:** Provides the primary user interface for monitoring and controlling energy exchanges in real-time.

**Key Features:**
- **Live Monitoring**: Real-time visualization of energy flows between batteries
- **System Control**: Start/stop energy trading, adjust parameters
- **Battery Status**: SOC levels, voltage, current, temperature readings
- **Trading History**: View past energy transactions and efficiency metrics

**Technical Details:**
- **Language**: Python (Flask web framework)
- **Frontend**: HTML/CSS/JavaScript with real-time charts
- **Port**: 4382
- **Communication**: REST APIs to APIS Main services

**User Workflow:**
1. Access web interface at `http://localhost:4382`
2. View current battery status and network topology
3. Set global mode to "Run" to enable autonomous trading
4. Monitor energy flows and system performance
5. Adjust trading parameters if needed

---

### 🌐 APIS Web - API Gateway & Data Services

**What it does:** Acts as the central communication hub, providing REST APIs for external systems and managing data flow between components.

**Key Features:**
- **REST API**: Standardized interface for all system operations
- **Data Aggregation**: Collects and correlates data from multiple APIS Main instances
- **External Integration**: Enables integration with home automation, smart grids
- **Authentication**: Basic security for API access

**Technical Details:**
- **Language**: Java (Spring Boot)
- **Port**: 8080 (internal), 80/443 (external)
- **Database**: MongoDB for configuration and logs
- **Protocol**: HTTP/JSON for all communications

**API Endpoints:**
- `GET /api/batteries` - Battery status information
- `POST /api/trade` - Initiate energy transfer
- `GET /api/history` - Transaction history
- `PUT /api/config` - System configuration

---

### 🔧 Hardware Emulator - Development & Testing

**What it does:** Simulates real battery hardware and DC/DC converters, allowing development and testing without expensive physical equipment.

**Key Features:**
- **Realistic Simulation**: Models battery chemistry, charging/discharging curves
- **Multiple Battery Types**: Supports different battery technologies (Li-ion, Lead-acid, etc.)
- **Fault Simulation**: Can simulate hardware failures for testing
- **Network Simulation**: Models communication delays and network partitions

**Technical Details:**
- **Language**: Python
- **Port**: 4390
- **Protocol**: Simulates real hardware communication protocols
- **Accuracy**: Within 5% of real hardware behavior

**Use Cases:**
- **Development**: Test new features without hardware
- **Education**: Learn energy trading concepts
- **CI/CD**: Automated testing of system changes
- **Demo**: Showcase APIS capabilities

---

## 🏢 Advanced Services Architecture

### 🏢 Service Center - Community Management Hub

**What it does:** Central administration system for managing large APIS deployments across multiple households or communities.

**Key Features:**
- **User Management**: Household registration, authentication, permissions
- **Network Topology**: Visualize and manage community energy networks
- **Billing Integration**: Track energy credits/debits for settlements
- **System Monitoring**: Health monitoring across all network nodes

**Technical Details:**
- **Language**: Python (Django framework)
- **Port**: 8000
- **Database**: PostgreSQL (via MongoDB adapter)
- **Authentication**: JWT tokens, role-based access control

**Community Workflow:**
1. Households register through Service Center
2. Define energy sharing rules and pricing
3. Monitor community-wide energy flows
4. Generate reports for billing and optimization

---

### 📡 CCC (Community Communication Center) - Inter-Network Coordination

**What it does:** Enables communication and coordination between separate APIS networks, creating larger regional energy markets.

**Key Features:**
- **Network Federation**: Connect multiple APIS communities
- **Data Aggregation**: Collect anonymized statistics across networks
- **Load Balancing**: Optimize energy flows across regions
- **Privacy Protection**: Maintains data isolation between networks

**Technical Details:**
- **Language**: Java
- **Protocol**: Secure MQTT for inter-network communication
- **Database**: Distributed MongoDB clusters
- **Security**: End-to-end encryption, certificate-based auth

---

### 📋 APIS Log - Analytics & Data Lake

**What it does:** Comprehensive data collection and analytics system that captures all system events for monitoring, debugging, and optimization.

**Key Features:**
- **Multicast Listener**: Captures UDP broadcasts from all APIS components
- **Data Warehousing**: Stores structured and unstructured system data
- **Real-time Analytics**: Dashboard for system performance metrics
- **Historical Analysis**: Long-term trend analysis and reporting

**Technical Details:**
- **Language**: Java (Spring Boot)
- **Database**: MongoDB with time-series collections
- **Protocol**: UDP multicast listener, REST API
- **Storage**: Optimized for high-volume time-series data

**Data Collected:**
- Energy transaction records
- System performance metrics
- Battery health indicators
- Network topology changes
- Error logs and system events

---

### 🧪 APIS Tester - Quality Assurance Framework

**What it does:** Automated testing suite that validates system behavior under various conditions and scenarios.

**Key Features:**
- **Scenario Testing**: Predefined test cases for common energy scenarios
- **Load Testing**: Stress testing with multiple concurrent transactions
- **Integration Testing**: End-to-end workflow validation
- **Regression Testing**: Ensures new changes don't break existing functionality

**Technical Details:**
- **Language**: Python (pytest framework)
- **Integration**: REST APIs, direct component communication
- **Reporting**: HTML/XML test reports with detailed metrics
- **CI/CD**: Integrates with continuous integration pipelines

---

## ⚡ Production Hardware Integration

### ⚙️ DC/DC Battery Communication Driver

**What it does:** Production-ready hardware interface for real DC/DC converters and battery management systems.

**Key Features:**
- **Hardware Abstraction**: Unified interface for different DC/DC converter brands
- **Safety Systems**: Emergency shutdown, over-current protection
- **Calibration**: Automatic calibration of current/voltage sensors
- **Monitoring**: Real-time hardware health and diagnostic data

**Technical Details:**
- **Language**: C++ (performance-critical), Python (control logic)
- **Hardware**: RS-485, CAN bus, Modbus protocols
- **Safety**: IEC 60479 standards compliance
- **Supported Hardware**: Major DC/DC converter manufacturers

**Production Deployment:**
1. Replaces emulator in production environments
2. Requires calibration with specific hardware
3. Includes safety interlocks and monitoring
4. Supports hot-swapping of battery systems

---

### 🚀 Build & Version Update System

**What it does:** Enterprise-grade deployment and update management for large-scale APIS installations.

**Key Features:**
- **Automated Deployment**: Zero-touch installation across multiple nodes
- **Version Control**: Centralized management of software versions
- **Rollback Capability**: Automatic rollback on deployment failures
- **Configuration Management**: Centralized configuration for all nodes

**Technical Details:**
- **Language**: Shell scripts, Ansible playbooks
- **Orchestration**: Supports Docker, Kubernetes, bare-metal
- **Security**: Signed updates, integrity verification
- **Monitoring**: Deployment progress and health monitoring

---

### 📖 Hardware Compatibility Guide

**What it does:** Comprehensive documentation of supported hardware configurations, specifications, and integration guides.

**Content Includes:**
- **Battery Systems**: Compatible battery types, capacities, communication protocols
- **DC/DC Converters**: Supported models, specifications, wiring diagrams
- **Sensors**: Voltage, current, temperature monitoring requirements
- **Network Equipment**: Switches, cabling, network topology recommendations

**Technical Details:**
- **Format**: Detailed technical specifications with diagrams
- **Updates**: Regularly updated as new hardware is certified
- **Testing**: Hardware validation procedures and checklists

---

## 🔄 Component Interaction Flow

### Normal Operation Sequence
1. **System Startup**: MongoDB → Service Center → Individual APIS instances
2. **Network Discovery**: APIS Main instances discover each other via multicast
3. **Hardware Connection**: Emulator/Real hardware connects to APIS Main
4. **Trading Session**: Autonomous energy trading begins based on rules
5. **Data Collection**: All events logged to APIS Log via multicast
6. **User Monitoring**: Main Controller displays real-time status
7. **Analytics**: APIS Log processes data for insights and reporting

### Failure Recovery
1. **Component Failure**: Individual service crashes or network disconnects
2. **Automatic Restart**: System attempts local restart of failed component
3. **Network Reconnection**: Surviving instances redistribute load
4. **Data Synchronization**: State synchronization when component recovers
5. **Alert Generation**: Notifications sent to administrators

This modular architecture ensures APIS can scale from single-home setups to community-wide energy networks while maintaining reliability and ease of maintenance.

---

## 💻 Installation Guide

![image 2](https://github.com/user-attachments/assets/66de9429-c395-4b02-a015-b4a11e455b1f)

### 🖥️ System Requirements & Setup

#### Supported Operating Systems

**✅ Fully Tested & Supported:**
- **Ubuntu**: 18.04 LTS, 20.04 LTS, 22.04 LTS
- **CentOS**: 7, 8, Stream 8, Stream 9
- **RHEL**: 7, 8, 9
- **Fedora**: 35, 36, 37
- **macOS**: Catalina (10.15), Big Sur (11.x), Monterey (12.x), Ventura (13.x)
- **Windows**: 10 (21H2+), 11 (via WSL2)

**⚠️ Important Notes:**
- Virtual environments are not currently supported for production deployments
- Windows requires WSL2 for full functionality
- Minimum 8GB RAM recommended for development
- 20GB free disk space for full build

---

#### 🐧 Linux Setup Guides

##### Ubuntu/Debian (18.04, 20.04, 22.04)
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install core dependencies
sudo apt install -y git make maven groovy python3-venv python3-pip openjdk-11-jdk

# Install additional tools
sudo apt install -y curl wget unzip vim htop

# Verify installations
java -version    # Should show Java 11
mvn -version     # Should show Maven 3.6+
python3 --version # Should be 3.6.9+
groovy --version  # Should work
```

##### CentOS/RHEL 7 & 8
```bash
# Enable EPEL repository (for additional packages)
sudo yum install -y epel-release

# Install core dependencies
sudo yum install -y git make maven groovy python3-virtualenv python3-pip java-11-openjdk-devel

# For CentOS 7, install newer Python if needed
sudo yum install -y centos-release-scl
sudo yum install -y rh-python38-python rh-python38-python-pip
# Then use: scl enable rh-python38 bash

# Verify installations
java -version
mvn -version
python3 --version
```

##### Fedora (35+)
```bash
# Install core dependencies
sudo dnf install -y git make maven groovy python3-virtualenv python3-pip java-11-openjdk-devel

# Install additional development tools
sudo dnf install -y curl wget unzip vim htop

# Verify installations
java -version
mvn -version
python3 --version
```

##### Arch Linux/Manjaro
```bash
# Install core dependencies
sudo pacman -Syu git make maven groovy python-virtualenv python-pip jdk11-openjdk

# Install additional tools
sudo pacman -S curl wget unzip vim htop

# Verify installations
java -version
mvn -version
python3 --version
```

---

#### 🍎 macOS Setup Guide

##### Using Homebrew (Recommended)
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core dependencies
brew install git make maven groovy python3 openjdk@11

# Add Java to PATH (add to ~/.zshrc or ~/.bash_profile)
echo 'export PATH="/usr/local/opt/openjdk@11/bin:$PATH"' >> ~/.zshrc
echo 'export JAVA_HOME="/usr/local/opt/openjdk@11"' >> ~/.zshrc
source ~/.zshrc

# Verify installations
java -version     # Should show Java 11
mvn -version      # Should show Maven 3.6+
python3 --version # Should be 3.8+
groovy --version  # Should work
```

##### Alternative: Using MacPorts
```bash
# Install MacPorts
# Download from: https://www.macports.org/install.php

# Install dependencies
sudo port install git maven3 groovy python39 py39-pip openjdk11

# Verify installations
java -version
mvn -version
python3 --version
```

---

#### 🪟 Windows Setup Guide

##### Option 1: Windows Subsystem for Linux (WSL2) - Recommended
```powershell
# Enable WSL2 (PowerShell as Administrator)
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Restart computer, then install Ubuntu
wsl --install -d Ubuntu
wsl --set-default-version 2

# Launch Ubuntu and follow Ubuntu setup instructions above
```

##### Option 2: Native Windows with Git Bash + MSYS2
```powershell
# Install Chocolatey (package manager)
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install dependencies via Chocolatey
choco install -y git make maven groovy python3 openjdk11

# Install MSYS2 for additional Unix tools
choco install -y msys2

# Add to PATH (environment variables)
# C:\Program Files\Git\bin
# C:\Program Files\Java\jdk-11\bin
# C:\Program Files\Maven\bin
# C:\tools\msys64\usr\bin
```

**Windows-Specific Notes:**
- Use Git Bash or WSL terminal instead of Command Prompt
- Some features may not work in native Windows environment
- WSL2 provides best compatibility with Linux workflows
- MongoDB may require additional Windows-specific configuration

---

#### 📋 Prerequisites Checklist

**Before running `make build`, verify:**

- [ ] **Git**: `git --version` (2.20+)
- [ ] **Make**: `make --version` (4.0+)
- [ ] **Java 11**: `java -version` (exactly 11, not 8 or 17)
- [ ] **Maven**: `mvn -version` (3.6+)
- [ ] **Groovy**: `groovy --version` (2.5+)
- [ ] **Python 3**: `python3 --version` (3.6.9+)
- [ ] **Pip**: `python3 -m pip --version`
- [ ] **Internet connection** for downloading dependencies
- [ ] **20GB free disk space**
- [ ] **8GB RAM minimum**

**Test Installation:**
```bash
# Quick verification script
echo "=== APIS Prerequisites Check ==="
echo "Git: $(git --version)"
echo "Make: $(make --version)"
echo "Java: $(java -version 2>&1 | head -n 1)"
echo "Maven: $(mvn -version 2>&1 | head -n 1)"
echo "Python: $(python3 --version)"
echo "Groovy: $(groovy --version 2>&1 | head -n 1)"
echo "Disk space: $(df -h . | tail -n 1)"
```

### 🚀 Installation Steps

**1. Clone the Repository**
```bash
git clone https://github.com/hyphae/APIS.git
cd APIS
```

**2. Build All Components**
```bash
make build
```
*This downloads and compiles all necessary software - takes 5-10 minutes*

**3. Start the System**
```bash
make run
```

**4. Verify Installation**
- Open `http://0.0.0.0:4382/` in your browser
- You should see the APIS control panel
- All components should show as "Running" status

### 🔧 Troubleshooting

#### Common Build Issues

**Build Fails with "Command not found"**
```bash
# Solution: Install missing prerequisites
# Ubuntu/Debian:
sudo apt update
sudo apt install git make maven groovy python3-venv python3-pip openjdk-11-jdk

# CentOS/RHEL/Fedora:
sudo yum install git make maven groovy python3-virtualenv python3-pip java-11-openjdk-devel
# OR
sudo dnf install git make maven groovy python3-virtualenv python3-pip java-11-openjdk-devel

# macOS:
brew install git make maven groovy python3 openjdk@11
```

**Maven/Java Version Issues**
```bash
# Check versions
java -version  # Should be Java 11
mvn -version   # Should be Maven 3.6+

# If wrong version, set JAVA_HOME
export JAVA_HOME=/path/to/java11
export PATH=$JAVA_HOME/bin:$PATH
```

**Python Virtual Environment Issues**
```bash
# If venv creation fails
python3 -m pip install --user virtualenv
# OR force reinstall
python3 -m pip install --upgrade pip setuptools wheel
```

**Git Clone Failures**
```bash
# If behind corporate firewall
git config --global http.proxy http://proxy.company.com:8080
git config --global https.proxy https://proxy.company.com:8080

# If SSL certificate issues
git config --global http.sslVerify false  # Temporary fix only
```

#### Runtime Issues

**Port Conflicts**
```bash
# Check what's using the ports
# Linux/macOS:
lsof -i :4382  # Main Controller
lsof -i :4390  # Hardware Emulator
lsof -i :10000 # Testing Interface
lsof -i :27018 # MongoDB

# Windows (PowerShell):
Get-NetTCPConnection -LocalPort 4382
Get-NetTCPConnection -LocalPort 4390

# Kill conflicting processes
kill -9 <PID>  # Linux/macOS
taskkill /PID <PID> /F  # Windows
```

**Database Connection Issues**
```bash
# MongoDB not starting
# Check if port 27018 is available
# Ensure mongodb/db directory exists and has write permissions
chmod 755 mongodb/db

# Reset database if corrupted
rm -rf mongodb/db/*
./mongodb/start.sh
```

**Service Won't Start**
```bash
# Check service logs in respective directories
tail -f apis-main/exe/logs/application.log
tail -f apis-web/exe/logs/web.log

# Common issues:
# 1. Previous instance still running - use 'make stop' first
# 2. Missing dependencies - check build completed successfully
# 3. Port conflicts - see port conflict section above
# 4. Permission issues - ensure executable permissions
chmod +x apis-*/exe/start.sh
```

**Web Interface Not Loading**
```bash
# Clear browser cache completely
# Try different browsers (Chrome, Firefox, Safari)
# Check if services are actually running
ps aux | grep python  # Should see multiple Python processes
ps aux | grep java    # Should see Java processes

# Network issues - try localhost instead of 0.0.0.0
# http://localhost:4382/ instead of http://0.0.0.0:4382/
```

#### Windows-Specific Issues

**Windows Command Prompt Issues**
```cmd
REM Use PowerShell instead of CMD for better compatibility
REM Or install Windows Subsystem for Linux (WSL)
```

**WSL Setup Issues**
```bash
# Install WSL2 if using Windows 10/11
wsl --install -d Ubuntu

# If WSL networking issues
# Edit /etc/resolv.conf in WSL
nameserver 8.8.8.8
nameserver 1.1.1.1
```

**Path Issues on Windows**
```cmd
REM Add to PATH environment variable:
REM C:\Program Files\Git\bin
REM C:\Program Files\Java\jdk-11\bin
REM C:\Program Files\Maven\bin
```

#### Advanced Troubleshooting

**Complete System Reset**
```bash
# Stop everything
make stop

# Clean all builds
make clean

# Remove all cloned repositories (CAUTION: loses local changes)
rm -rf apis-*/

# Fresh start
make build
make run
```

**Debug Mode**
```bash
# Run individual services with verbose logging
cd apis-main/ && make package && ./exe/start.sh
cd apis-web/ && make package && ./exe/start.sh

# Check system resources
df -h  # Disk space
free -h  # Memory (Linux)
top -p <PID>  # Process monitoring
```

**Getting Help**
- Check [GitHub Issues](https://github.com/hyphae/APIS/issues) for similar problems
- Join the community discussions
- Provide detailed error logs when asking for help

---

## 📖 How to Use APIS

### 🎮 Basic Operations

**Start the System:**
```bash
make run
```

**Monitor System Health:**
- Check component status through the Main Controller interface
- Monitor energy flow patterns and transaction logs  
- Review system performance metrics in the Service Center

**Stop the System:**
```bash
make stop
```

### ⚙️ Configuration

**Energy Trading Setup:**
1. Access the web interfaces to modify transaction parameters
2. Adjust energy trading conditions per time window
3. Configure battery system preferences and constraints
4. Set pricing rules and availability schedules

**System Monitoring:**
- Real-time energy flow visualization
- Transaction history and analytics
- Performance metrics and system health
- Community-wide energy balance reports

---

## 🌍 Key Benefits

![image 4](https://github.com/user-attachments/assets/7c3b06b0-34f8-4efa-91f8-461dad45ffb9)

### For Homeowners 🏠
- **💰 Lower Bills**: Reduce electricity costs significantly
- **🔋 Backup Power**: Access community energy when your battery runs low
- **🤖 Fully Automatic**: Set preferences once, let APIS handle everything
- **📱 Easy Monitoring**: Simple web interface accessible from any device

### For Communities 🏘️
- **🌱 Environmental Impact**: Maximize clean energy use and reduce carbon footprint
- **🛡️ Disaster Resilience**: Keep power flowing during grid outages and emergencies  
- **💼 Economic Benefits**: Keep energy money in the community
- **🏠 Energy Independence**: Reduce reliance on big power companies

### For Developers 👨‍💻
- **🔓 Open Source**: Free to use and modify under Apache License 2.0
- **📚 Well Documented**: Comprehensive guides and API references
- **🤝 Active Community**: Get help and contribute back
- **✅ Proven Technology**: Already working in real installations worldwide

---

## 🛠️ Development Workflow

This section covers development practices, testing strategies, and contribution workflows for APIS contributors.

---

### 🚀 Development Environment Setup

#### 1. Prerequisites Installation
Follow the [System Requirements & Setup](#-system-requirements--setup) guide above, then install additional development tools:

```bash
# Development tools
sudo apt install -y git-lfs docker-compose jq curl wget

# Code quality tools
sudo apt install -y shellcheck pylint black

# IDE support (optional)
sudo apt install -y vim emacs code  # Or your preferred editor
```

#### 2. Clone and Initialize
```bash
# Clone your fork (replace with your username)
git clone https://github.com/YOUR_USERNAME/APIS.git
cd APIS

# Add upstream remote
git remote add upstream https://github.com/hyphae/APIS.git

# Initialize submodules if any
git submodule update --init --recursive

# Create development branch
git checkout -b development
```

#### 3. Development Build
```bash
# Full development build with verbose output
make build 2>&1 | tee build.log

# Or build individual components for faster iteration
make build-apis-main
make build-apis-web
```

---

### 🧪 Testing Strategies

#### Unit Testing
```bash
# Test individual components
cd apis-main/
mvn test

cd ../apis-web/
mvn test

# Python components
cd ../apis-emulator/
python3 -m pytest tests/

# Run all tests
make test  # If available
```

#### Integration Testing
```bash
# Start minimal test environment
make run-mongodb
make run-apis-emulator

# Run integration tests
cd apis-tester/
python3 -m pytest integration_tests/

# Full system integration test
make run
# Wait for startup, then run: make test-integration
```

#### Manual Testing Scenarios

**Energy Trading Test:**
1. Start system: `make run`
2. Access Main Controller: `http://localhost:4382/`
3. Set different battery SOC levels via emulator
4. Enable trading and observe energy flows
5. Verify transactions are logged in MongoDB

**Network Resilience Test:**
1. Start multi-node setup
2. Simulate network partition (disconnect one node)
3. Verify system continues operating
4. Reconnect and verify state synchronization

**Load Testing:**
1. Use APIS Tester component
2. Configure multiple concurrent energy transfers
3. Monitor system performance and stability

---

### 🔍 Debugging Techniques

#### Component-Specific Debugging

**APIS Main (Java/Groovy):**
```bash
# Enable debug logging
cd apis-main/
export JAVA_OPTS="-Dlogging.level.com.hyphae=DEBUG"
./exe/start.sh

# Attach debugger
# JVM will listen on port 5005 for remote debugging
export JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"
```

**Main Controller (Python):**
```bash
cd apis-main_controller/
# Run with debug mode
python3 -m flask run --debug --host=0.0.0.0 --port=4382

# Or use pdb for breakpoints
python3 -m pdb startMain.py
```

**Web Services (Java Spring):**
```bash
cd apis-web/
# Enable actuator endpoints
export JAVA_OPTS="-Dmanagement.endpoints.web.exposure.include=*"
mvn spring-boot:run

# Access health checks: http://localhost:8080/actuator/health
```

#### System-Wide Debugging

**Network Traffic Analysis:**
```bash
# Monitor multicast traffic
tcpdump -i any port 5000  # Adjust port as needed

# Monitor HTTP traffic
tcpdump -i any port 80 or port 8080 or port 4382
```

**Database Debugging:**
```bash
# Connect to MongoDB
mongo --port 27018

# Check collections
show dbs
use apis
show collections
db.energy_transactions.find().limit(5)

# Monitor database operations
db.serverStatus()
```

**Log Analysis:**
```bash
# Aggregate logs from all components
find . -name "*.log" -exec tail -f {} \;

# Search for specific errors
grep -r "ERROR" apis-*/logs/

# Monitor system resources
top -p $(pgrep -f "java\|python")
```

---

### 🔄 Development Workflow

#### Feature Development Process

1. **Plan Your Changes**
   ```bash
   # Create feature branch from latest main
   git checkout main
   git pull upstream main
   git checkout -b feature/your-feature-name
   ```

2. **Implement Changes**
   ```bash
   # Make your code changes
   # Follow existing code style
   # Add/update tests
   # Update documentation
   ```

3. **Local Testing**
   ```bash
   # Run relevant tests
   make test-component-name

   # Manual testing
   make run
   # Test your changes in browser/dev tools
   ```

4. **Code Quality Checks**
   ```bash
   # Run linters
   find . -name "*.py" -exec pylint {} \;
   find . -name "*.sh" -exec shellcheck {} \;

   # Format code
   black apis-*/**/*.py
   ```

5. **Commit and Push**
   ```bash
   # Stage changes
   git add .

   # Commit with clear message
   git commit -m "feat: add energy trading optimization

   - Implement new trading algorithm
   - Add configuration options
   - Update documentation
   - Add unit tests"

   # Push to your fork
   git push origin feature/your-feature-name
   ```

#### Pull Request Process

1. **Create PR**
   - Go to your fork on GitHub
   - Click "New Pull Request"
   - Select your feature branch
   - Fill out PR template with:
     - Clear title and description
     - What problem it solves
     - How to test the changes
     - Screenshots/videos if UI changes

2. **PR Review**
   - Address reviewer feedback
   - Keep PR updated with main branch
   - Ensure CI checks pass

3. **Merge**
   - Squash merge for clean history
   - Delete feature branch after merge

---

### 🔧 Advanced Development Tasks

#### Working with Individual Components

**Developing APIS Main:**
```bash
cd apis-main/
# Edit source code
vim src/main/java/com/hyphae/apis/main/EnergyTradingEngine.java

# Build and test
mvn clean compile
mvn test

# Package for deployment
mvn package
```

**Developing Hardware Emulator:**
```bash
cd apis-emulator/
# Activate virtual environment
. venv/bin/activate

# Edit Python code
vim battery_emulator.py

# Run tests
python3 -m pytest tests/

# Test changes
python3 startEmul.py 4
```

#### Database Schema Changes

```bash
# Backup existing data
mongodump --port 27018 --out backup-$(date +%Y%m%d)

# Modify schema in code
# Update relevant service

# Test migration
make run-mongodb
# Run your service with new schema

# Rollback if needed
mongorestore --port 27018 backup-20231206
```

#### Performance Profiling

```bash
# Java profiling
cd apis-main/
export JAVA_OPTS="-agentlib:hprof=cpu=samples,depth=10,interval=5,lineno=y,file=cpu.hprof"
./exe/start.sh

# Python profiling
cd apis-emulator/
python3 -m cProfile -s time startEmul.py 4

# System monitoring
# Use htop, iotop, or nmon for resource monitoring
```

---

### 🚢 Deployment and CI/CD

#### Local Deployment Testing

```bash
# Build production artifacts
make build

# Test deployment
make run

# Verify all services start correctly
curl -f http://localhost:4382/ || echo "Main Controller failed"
curl -f http://localhost:4390/ || echo "Emulator failed"
```

#### CI/CD Pipeline Overview

APIS uses GitHub Actions for continuous integration:

**Automated Checks:**
- Code linting (shellcheck, pylint)
- Unit tests for all components
- Integration tests with emulator
- Build verification on multiple OS
- Documentation validation

**Release Process:**
1. Create release branch from main
2. Update version numbers in all components
3. Run full test suite
4. Create GitHub release
5. Deploy to package repositories

#### Contributing to CI/CD

```yaml
# Example GitHub Actions workflow addition
- name: Test Energy Trading Logic
  run: |
    make run-mongodb
    make run-apis-emulator
    cd apis-tester/
    python3 -m pytest test_energy_trading.py
```

---

### 📚 Development Resources

#### Code Structure
```
APIS/
├── apis-main/           # Core energy trading engine (Java)
├── apis-web/            # REST API services (Java/Spring)
├── apis-emulator/       # Hardware simulation (Python)
├── apis-main_controller/# Web dashboard (Python/Flask)
├── apis-service_center/ # Admin interface (Python/Django)
├── apis-log/            # Analytics system (Java)
├── apis-ccc/            # Inter-network communication (Java)
├── apis-tester/         # Testing framework (Python)
└── mongodb/             # Database configuration
```

#### Key Files
- `Makefile` - Build orchestration
- `runner.sh` - Service startup script
- `*/pom.xml` - Java project configurations
- `*/requirements.txt` - Python dependencies
- `*/venv.sh` - Python environment setup

#### Communication Channels
- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: General questions and community support
- **Architecture Decisions**: Documented in relevant component READMEs

#### Getting Help
- **Code Examples**: Check existing implementations in each component
- **Tests**: Look at test files for usage examples
- **Documentation**: Component-specific docs in `*/doc/` directories
- **Community**: Join discussions for guidance on complex changes

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### 🌟 Ways to Contribute

**Even if you're not a programmer:**
- 📝 Improve documentation (fix typos, add examples)
- 🧪 Test new features and report bugs
- 🗣️ Help answer questions in forums
- 📢 Share your APIS success stories

**If you code:**
- 🐛 Fix bugs and improve stability
- ⚡ Add new features and capabilities
- 🔧 Create better tools and interfaces
- 📊 Improve performance and efficiency

**If you're a hardware person:**
- 🔌 Create drivers for new battery systems
- ⚙️ Design better integration methods
- 📐 Contribute hardware compatibility guides
- 🛠️ Help with installation and setup

### 📋 Contribution Guidelines

- Follow existing code style and conventions
- Include comprehensive tests for new features
- Update documentation for any API changes
- Provide clear commit messages and PR descriptions
- Test changes across different operating systems when possible

---

## 🆘 Getting Help & Support

### 🔍 Self-Service Options
- **📖 Documentation**: Most questions answered in our comprehensive guides
- **🔍 GitHub Issues**: Search existing problems and solutions
- **💬 Community Forums**: Ask and answer questions with other users

### 📞 Direct Support
- **🐛 Bug Reports**: Create a GitHub issue for bug reports
- **💡 Feature Requests**: Suggest improvements through GitHub issues
- **🔒 Security Issues**: Contact maintainers directly for sensitive matters

---

## 📄 License & Legal

**APIS** is released under the **[Apache License Version 2.0](https://github.com/hyphae/APIS/blob/master/LICENSE)**

**What this means for you:**
- ✅ Use it for free, forever
- ✅ Modify it however you want
- ✅ Use it in commercial products
- ✅ No fees or royalties
- ✅ Patent protection included

**What you need to do:**
- 📋 Include the license notice if you redistribute
- 📋 Note any changes you make
- 📋 That's pretty much it!

See the [LICENSE](https://github.com/hyphae/APIS/blob/master/LICENSE) file for all legal details.  
See the [NOTICE](https://github.com/hyphae/APIS/blob/master/NOTICE.md) for additional notices.

---

## 🎯 What's Next for APIS

### 🔜 Coming Soon
- **📱 Mobile App**: Control APIS from your smartphone
- **☁️ Cloud Integration**: Connect with major cloud platforms  
- **🤖 AI Optimization**: Smarter energy trading decisions
- **🔌 More Hardware**: Support for additional battery brands

### 🚀 Long-Term Vision
- **🌐 Global Network**: Connect APIS communities worldwide
- **🌱 Carbon Credits**: Automatic environmental impact tracking
- **💹 Dynamic Pricing**: Real-time energy market integration
- **👥 Peer Review**: Community-driven system improvements

---

## 🏁 Ready to Get Started?

![image 7](https://github.com/user-attachments/assets/8e38740d-4ccf-4c46-a81c-400b8841cab4)

**Choose your path:**

### 🏠 **For Homeowners**
Try the [Quick Start](#-quick-start-5-minutes) guide above and start saving on your energy bills today!

### 👨‍💻 **For Developers** 
Explore the system components and documentation to start building energy applications.

### 🏘️ **For Communities**
Set up APIS for your neighborhood and bring energy independence to your community.

### 🎓 **For Researchers**
Contribute to the future of distributed energy systems through APIS development and research.

---

*Made with ❤️ by the APIS Community - Powering the future, one battery at a time.*
