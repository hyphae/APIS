# APIS - Autonomous Power Interchange System
# Docker container for running all APIS services
#
# Build: docker build -t apis:latest .
# Run:   docker-compose up

FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    make \
    maven \
    groovy \
    python3 \
    python3-venv \
    python3-pip \
    openjdk-11-jdk \
    wget \
    gnupg \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - \
    && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list \
    && apt-get update \
    && apt-get install -y mongodb-org \
    && rm -rf /var/lib/apt/lists/*

# Set Java environment - detect architecture dynamically
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
    echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> /etc/profile.d/java.sh; \
    else \
    echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-arm64" >> /etc/profile.d/java.sh; \
    fi && \
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/java.sh

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Create working directory
WORKDIR /app

# Copy repository files
COPY . /app/

# Create MongoDB data directory
RUN mkdir -p /app/mongodb/db /data/db

# Clone and build all APIS components
# Use bash shell to ensure proper environment
SHELL ["/bin/bash", "-c"]

# Build apis-bom and apis-common with version 3.0.0 for compatibility with GitHub repos
# The GitHub repos expect version 3.0.0 in their pom.xml files
RUN source /etc/profile.d/java.sh && \
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java)))) && \
    echo "JAVA_HOME is set to: $JAVA_HOME" && \
    # Patch apis-bom version to 3.0.0
    sed -i 's|<version>3.4.1</version>|<version>3.0.0</version>|g' /app/apis-bom/pom.xml && \
    cd /app/apis-bom && mvn install && \
    # Patch apis-common version to 3.0.0
    sed -i 's|<version>3.4.1</version>|<version>3.0.0</version>|g' /app/apis-common/pom.xml && \
    cd /app/apis-common && mvn install && \
    # Now clone and build remaining components from GitHub
    cd /app && \
    git clone https://github.com/hyphae/apis-main.git && \
    cd apis-main && mvn package -Dmaven.test.skip=true && \
    cd /app && \
    git clone https://github.com/hyphae/apis-ccc.git && \
    cd apis-ccc && mvn package -Dmaven.test.skip=true && \
    cd /app && \
    git clone https://github.com/hyphae/apis-log.git && \
    cd apis-log && mvn package -Dmaven.test.skip=true && \
    cd /app && \
    git clone https://github.com/hyphae/apis-web.git && \
    cd apis-web && mvn package -Dmaven.test.skip=true && \
    cd /app && \
    # Python components
    git clone https://github.com/hyphae/apis-emulator.git && \
    cd apis-emulator && sh venv.sh && \
    cd /app && \
    git clone https://github.com/hyphae/apis-main_controller.git && \
    cd apis-main_controller && sh venv.sh && \
    cd /app && \
    git clone https://github.com/hyphae/apis-service_center.git && \
    cd apis-service_center && sh venv.sh && sh initdb.sh && \
    cd /app && \
    git clone https://github.com/hyphae/apis-tester.git && \
    cd apis-tester && sh venv.sh

# Expose service ports
# 4382 - Main Controller
# 4390 - Hardware Emulator
# 8000 - Service Center
# 10000 - Testing Interface
# 27018 - MongoDB
EXPOSE 4382 4390 8000 10000 27018

# Copy and set entrypoint script
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/app/docker-entrypoint.sh"]
