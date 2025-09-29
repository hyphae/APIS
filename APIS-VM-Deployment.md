# API Deployment on AWS EC2 Instance

This guide walks through the step-by-step process of deploying APIs on an AWS EC2 instance.

## 🚀 Key Feature: Persistent Service Management

The deployment system is designed to **keep services running after SSH disconnection** using:
- `nohup` commands to ignore hangup signals
- Background processes (`&`)
- Proper logging to files in `logs/` directory
- Process management via Makefile targets

## System Architecture

The APIS system includes the following microservices:
- **apis-main** (with 4 instances for load distribution)
- **apis-ccc** - Core Control Center
- **apis-log** - Logging service
- **apis-web** - Web interface
- **apis-emulator** - Service emulator
- **apis-main_controller** - Main controller service
- **apis-service_center** - Service center with database
- **apis-tester** - Testing service
- **MongoDB** - Database service


## 🚀 Critical Improvement: Persistent Service Management

### The Problem
With the initial configuration, all APIS services would immediately stop when you exited the terminal/SSH session. This made the deployment unsuitable for production use as services couldn't run independently.

### The Solution
The Makefile has been modified with **Detached Mode Setup** that uses `nohup` and background processes to ensure services continue running after terminal sessions end.


## Prerequisites
- AWS account with EC2 access
- Basic knowledge of SSH and command line
- Your API code ready for deployment

## Step 1: Launch EC2 Instance

### 1.1 Configure Instance
- Go to AWS Management Console → EC2
- Click "Launch Instance"
- Choose Amazon Linux 2 AMI (or your preferred OS)
- Select instance type (e.g., t2.micro for testing)
- Configure instance details (default settings usually sufficient)

### 1.2 Security Group Configuration
Create security group with rules:
```yaml
Type: SSH, Port: 22, Source: My IP
Type: Custom TCP, Port: [Your API Port --> 4382, 4390, 10000, 8000] Source: 0.0.0.0/0

### 1.3 Key Pair
Create new key pair or use existing
Download .pem file and secure it

## Step 2: Connect to Instance

# Change permissions on key file
chmod 400 your-key.pem

# SSH into instance
ssh -i "your-key.pem" ubuntu@your-instance-ip


## Step 3: Environment Setup

### 3.1 Update System
sudo yum update -y

### 3.2 Install Dependencies
sudo apt install git make maven groovy python3-venv python3-pip


### 3.3 Install MongoDB 7.0 with Compatibility Fix
Fix MongoDB GPG Key and Repository Issues:

# Remove any existing MongoDB lists that may cause conflicts
sudo rm -f /etc/apt/sources.list.d/mongodb*.list

# Download and install the official MongoDB 7.0 GPG key
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-archive-keyring.gpg

# Add the MongoDB repository with correct key reference
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu $(lsb_release -sc)/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Update APT and install MongoDB
sudo apt update && sudo apt install -y mongodb-org

## Step 4: Deploy Application
### 4.1 Clone Repository

git clone https://github.com/hyphae/APIS.git
cd APIS

### 4.2 Fix NumPy Dependency Issue
Before running make build, resolve numpy compatibility:

# First remove the existing numpy line from requirements
sed -i '/numpy/d' requirements.txt

# Then add the compatible version
echo "numpy>=1.21.0" >> requirements.txt

# Key Makefile Modifications
Replace the content of the Makefile with this EC2_Makefile completely. You can find in the files in the repository

## Step 5: Build and Start Services
### 5.1 Build Services
make build
make run
make stop