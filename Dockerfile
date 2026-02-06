# Stage 1: Build All Java Components
FROM maven:3.9-eclipse-temurin-11 AS builder
WORKDIR /build

# Copy and install BOM
COPY apis-bom /build/apis-bom
# APPLY PATCH: Fix dependency versions
COPY patches/apis-bom-pom.xml /build/apis-bom/pom.xml
WORKDIR /build/apis-bom
RUN mvn install -DskipTests

# Copy and install Common
COPY apis-common /build/apis-common
# APPLY PATCH: Fix dependency versions
COPY patches/apis-common-pom.xml /build/apis-common/pom.xml
WORKDIR /build/apis-common
RUN mvn install -DskipTests

# Build apis-main
COPY apis-main /build/apis-main
WORKDIR /build/apis-main
RUN mvn package -DskipTests

# Build apis-web
COPY apis-web /build/apis-web
WORKDIR /build/apis-web
RUN mvn package -DskipTests

# Stage 2: APIS Main Runtime
FROM eclipse-temurin:11-jre AS apis-main
WORKDIR /app
COPY --from=builder /build/apis-main/target/apis-main-*-fat.jar /app/apis-main.jar
# Default config files will be mounted via Volume or use defaults
COPY apis-main/exe/logging.properties /app/
COPY apis-main/exe/config.json /app/
COPY apis-main/exe/cluster.xml /app/
ENV CLUSTER_HOST_IP=127.0.0.1
# Entrypoint to dynamically set cluster host IP
CMD ["sh", "-c", "java -Djava.net.preferIPv4Stack=true -Djava.util.logging.config.file=./logging.properties -Dvertx.hazelcast.config=./cluster.xml -jar apis-main.jar -conf ./config.json -cluster -cluster-host $(hostname -i)"]

# Stage 3: APIS Web Runtime
FROM eclipse-temurin:11-jre AS apis-web
WORKDIR /app
COPY --from=builder /build/apis-web/target/apis-web-*-fat.jar /app/apis-web.jar
COPY apis-web/exe/logging.properties /app/
COPY apis-web/exe/config.json /app/
COPY apis-web/exe/cluster.xml /app/
ENV CLUSTER_HOST_IP=127.0.0.1
CMD ["sh", "-c", "java -Djava.net.preferIPv4Stack=true -Djava.util.logging.config.file=./logging.properties -jar apis-web.jar -conf ./config.json -cp ./ -cluster -cluster-host $(hostname -i)"]
