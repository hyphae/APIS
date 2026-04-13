# SPDX-License-Identifier: Apache-2.0
# Multi-stage Dockerfile for APIS (Autonomous Power Interchange System)
# Builds all services from source for full reproducibility.

# ==============================================================================
# Stage 1: Builder - Compile Java services and prepare Python virtual environments
# ==============================================================================
FROM ubuntu:20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    make \
    maven \
    groovy \
    python3-venv \
    python3-pip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Clone and build all sub-repositories using the Makefile orchestrator
COPY Makefile runner.sh ./

# Clone all repositories
RUN make apis-bom apis-common apis-main apis-ccc apis-log apis-web \
    apis-emulator apis-main_controller apis-service_center apis-tester

# Build Java dependencies first (order matters)
RUN cd apis-bom && make install
RUN cd apis-common && make install

# Build Java services (produces fat JARs)
RUN cd apis-main && make package
RUN cd apis-ccc && make package
RUN cd apis-log && make package
RUN cd apis-web && make package

# Build Python services (create virtual environments)
RUN cd apis-emulator && sh venv.sh
RUN cd apis-main_controller && sh venv.sh
RUN cd apis-service_center && sh venv.sh && sh initdb.sh
RUN cd apis-tester && sh venv.sh

# ==============================================================================
# Stage 2: Runtime - Lean image with only what's needed to run
# ==============================================================================
FROM ubuntu:20.04 AS runtime

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jre-headless \
    python3 \
    python3-venv \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /APIS

# Copy built artifacts from builder
COPY --from=builder /build/apis-main /APIS/apis-main
COPY --from=builder /build/apis-ccc /APIS/apis-ccc
COPY --from=builder /build/apis-log /APIS/apis-log
COPY --from=builder /build/apis-web /APIS/apis-web
COPY --from=builder /build/apis-emulator /APIS/apis-emulator
COPY --from=builder /build/apis-main_controller /APIS/apis-main_controller
COPY --from=builder /build/apis-service_center /APIS/apis-service_center
COPY --from=builder /build/apis-tester /APIS/apis-tester

# Copy orchestration files
COPY Makefile runner.sh mongodb/ /APIS/

# Fix MongoDB port in service_center demo settings (27018 -> 27017)
RUN for settings_file in \
        /APIS/apis-service_center/config/settings/apis_service_center_demo.py \
        /APIS/apis-service_center/config/settings/apis-service_center-demo.py; do \
    if [ -f "$settings_file" ]; then \
        sed -i 's/27018/27017/g' "$settings_file"; \
    fi; \
    done

# Expose all service ports
EXPOSE 4382 4390 8000 10000

# Health check against the main controller
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:4382/ || exit 1

# Entrypoint script to start all services
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
