#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Entrypoint script for APIS container
# Starts all services and keeps the container running

set -e

APIS_DIR="/APIS"
cd "$APIS_DIR"

echo "========================================"
echo " APIS - Autonomous Power Interchange System"
echo " Starting all services..."
echo "========================================"

# Start apis-service_center (Django)
echo "[1/8] Starting apis-service_center on port 8000..."
cd "$APIS_DIR/apis-service_center"
. venv/bin/activate
python3 ./manage.py runserver --settings=config.settings.apis-service_center-demo 0.0.0.0:8000 &
deactivate 2>/dev/null || true

# Start apis-emulator
echo "[2/8] Starting apis-emulator on port 4390..."
cd "$APIS_DIR/apis-emulator"
. venv/bin/activate
python3 ./startEmul.py 4 &
deactivate 2>/dev/null || true

# Start apis-main instances (4 nodes)
echo "[3/8] Starting apis-main (4 instances)..."
cd "$APIS_DIR/apis-main/exe"
java -Djava.net.preferIPv4Stack=true -Duser.timezone=Asia/Tokyo \
    -Djava.util.logging.config.file=./logging.properties \
    -Dvertx.hazelcast.config=./cluster.xml \
    -jar ../target/apis-main-3.0.0-fat.jar -conf ./config.json \
    -cluster -cluster-host 127.0.0.1 &

java -Djava.net.preferIPv4Stack=true -Duser.timezone=Asia/Tokyo \
    -Djava.util.logging.config.file=./logging.properties \
    -Dvertx.hazelcast.config=./cluster.xml \
    -jar ../target/apis-main-3.0.0-fat.jar -conf ./config2.json \
    -cluster -cluster-host 127.0.0.1 &

java -Djava.net.preferIPv4Stack=true -Duser.timezone=Asia/Tokyo \
    -Djava.util.logging.config.file=./logging.properties \
    -Dvertx.hazelcast.config=./cluster.xml \
    -jar ../target/apis-main-3.0.0-fat.jar -conf ./config3.json \
    -cluster -cluster-host 127.0.0.1 &

java -Djava.net.preferIPv4Stack=true -Duser.timezone=Asia/Tokyo \
    -Djava.util.logging.config.file=./logging.properties \
    -Dvertx.hazelcast.config=./cluster.xml \
    -jar ../target/apis-main-3.0.0-fat.jar -conf ./config4.json \
    -cluster -cluster-host 127.0.0.1 &

# Start apis-ccc
echo "[4/8] Starting apis-ccc..."
cd "$APIS_DIR/apis-ccc/exe"
java -Djava.net.preferIPv4Stack=true -Duser.timezone=Asia/Tokyo \
    -Djava.util.logging.config.file=./logging.properties \
    -Dvertx.hazelcast.config=./cluster.xml \
    -jar ../target/apis-ccc-3.0.0-fat.jar -conf ./config.json \
    -cluster -cluster-host 127.0.0.1 &

# Start apis-log
echo "[5/8] Starting apis-log..."
cd "$APIS_DIR/apis-log/exe"
java -Djava.net.preferIPv4Stack=true -Duser.timezone=Asia/Tokyo \
    -Djava.util.logging.config.file=./logging.properties \
    -jar ../target/apis-log-3.0.0-fat.jar -conf ./config.json &

# Start apis-web
echo "[6/8] Starting apis-web..."
cd "$APIS_DIR/apis-web/exe"
java -Djava.net.preferIPv4Stack=true -Duser.timezone=Asia/Tokyo \
    -Djava.util.logging.config.file=./logging.properties \
    -Dvertx.hazelcast.config=./cluster.xml \
    -jar ../target/apis-web-3.0.0-fat.jar run \
    jp.co.sony.csl.dcoes.apis.tools.web.util.Starter \
    --conf ./config.json --cluster --cluster-host 127.0.0.1 &

# Start apis-main_controller
echo "[7/8] Starting apis-main_controller on port 4382..."
cd "$APIS_DIR/apis-main_controller"
. venv/bin/activate
python3 ./startMain.py &
deactivate 2>/dev/null || true

# Start apis-tester
echo "[8/8] Starting apis-tester on port 10000..."
cd "$APIS_DIR/apis-tester"
. venv/bin/activate
python3 ./startTester.py &
deactivate 2>/dev/null || true

echo "========================================"
echo " All services started!"
echo " Dashboard:    http://localhost:4382"
echo " Emulator:     http://localhost:4390"
echo " Tester:       http://localhost:10000"
echo " Admin Panel:  http://localhost:8000/static/ui_example/staff/visual.html"
echo "========================================"

# Keep the container running and forward signals
wait
