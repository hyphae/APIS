# APIS Development Environment Setup

## Prerequisites
*   Docker & Docker Compose
*   Git

## Setup Steps

1.  **Clone Dependencies**
    Ensure all sub-repositories are cloned into the root structure:
    *   apis-bom
    *   apis-common
    *   apis-main
    *   apis-web
    *   apis-emulator

2.  **Start Sandbox Environment**
    ```bash
    docker-compose up --build
    ```

3.  **Services**
    *   **Dashboard (Web)**: Endpoints available at `localhost:43900` and `localhost:9999`.
    *   **Grid Master (Main)**: Running autonomously.
    *   **Hardware (Emulator)**: Simulating 4 battery units.

## Testing APIs
See `validate_env.py` for automated testing.

*   **Energy Balance Check**: `GET http://localhost:43900/get/log`
*   **Power Allocation**: `POST http://localhost:9999/deal`

## Troubleshooting
*   **Build Fails**: Ensure `apis-bom` and `apis-common` are using version 3.0.0 in `pom.xml`.
*   **Ports in Use**: Stop native services if running (`make stop`).
*   **Hazelcast Errors**: Docker Compose uses `hostname -i` to discover peers. Ensure firewall allows port 5701.
