#!/bin/bash
# APIS Docker Entrypoint Script
# Starts all APIS services in the correct order

set -e

echo "=========================================="
echo "   APIS - Autonomous Power Interchange   "
echo "=========================================="

# Function to start a service in background
start_service() {
    local name=$1
    local dir=$2
    local cmd=$3
    echo "[STARTING] $name..."
    cd /app/$dir
    eval "$cmd" &
    sleep 2
}

# Start MongoDB
echo "[STARTING] MongoDB..."
mongod --dbpath /app/mongodb/db --port 27018 --bind_ip_all --fork --logpath /var/log/mongodb.log
sleep 5

# Start Service Center (bind to 0.0.0.0 for external access)
start_service "Service Center" "apis-service_center" ". venv/bin/activate && python ./manage.py runserver --settings=config.settings.apis-service_center-demo 0.0.0.0:8000"

# Start Hardware Emulator
start_service "Hardware Emulator" "apis-emulator" ". venv/bin/activate && ./startEmul.py 4"

# Start APIS Main instances (4 nodes for energy exchange)
echo "[STARTING] APIS Main (4 nodes)..."
cd /app/apis-main/exe
sh start.sh &
sleep 1
sh start2.sh &
sleep 1
sh start3.sh &
sleep 1
sh start4.sh &
sleep 2

# Start CCC (Communication Coordinator)
start_service "CCC" "apis-ccc/exe" "sh start.sh"

# Start Log Service
start_service "Log Service" "apis-log/exe" "sh start.sh"

# Start Web Service
start_service "Web Service" "apis-web/exe" "sh start.sh"

# Start Main Controller
start_service "Main Controller" "apis-main_controller" ". venv/bin/activate && ./startMain.py"

# Start Tester (patch config to bind to 0.0.0.0 for external access)
echo "[STARTING] Tester..."
cd /app/apis-tester
sed -i "s/my_host = 'localhost'/my_host = '0.0.0.0'/" config.py
. venv/bin/activate && python ./startTester.py &
sleep 2

echo ""
echo "=========================================="
echo "   All APIS services started!            "
echo "=========================================="
echo ""
echo "Available at:"
echo "  - Main Controller:   http://localhost:4382/"
echo "  - Hardware Emulator: http://localhost:4390/"
echo "  - Service Center:    http://localhost:8000/static/ui_example/staff/visual.html"
echo "  - Testing Interface: http://localhost:10000/"
echo ""

# Keep container running
tail -f /dev/null
