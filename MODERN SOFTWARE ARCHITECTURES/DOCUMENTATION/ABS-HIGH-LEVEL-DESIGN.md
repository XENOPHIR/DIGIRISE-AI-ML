# High-Level Architecture

![High-Level Architecture](../DIAGRAMS/PNG/High-Level%20Components%20Architecture.png)

## Ingress & API Management

- **IoT Sensors:** Deployed in various locations to collect water quality metrics.
- **DNS Load Balancers:** Distributes incoming requests from sensors.
- **Load Balancers:** Ensures efficient request distribution among backend servers.
- **API Gateway:** Manages external and internal API requests.
  - **Public API:** For external integrations (municipalities, industrial clients).
  - **Private API:** For internal services and secure data access.

## Core Services

- **App Server:** Manages authentication, API requests, and data ingestion.
- **Authentication & Role Management:** OAuth2-based user authentication with roles: `Operator`, `Scientist`, and `Admin`.
- **Write API:** Handles data ingestion from sensors and services.
- **Read API:** Fetches processed or raw data for users and external integrations.

## Message-Driven Processing

- **RabbitMQ Message Broker:** Ensures asynchronous task execution for background processing.
- **Worker Services:**
  - **Contamination Detection Service:** Analyzes incoming sensor data for contaminants.
  - **AI Model Inference Service:** Runs ML-based contamination prediction.
  - **Predictive Analytics Service:** Generates insights on water trends and maintenance.
  - **Notification Service:** Sends alerts for contamination and system failures.
  - **Report Generation Service:** Aggregates data and generates reports.
  - **Monitoring Service:** Tracks system health and resource utilization.

## Storage & Data Management

- **PostgreSQL Cluster:** Stores structured data (sensor readings, user activity logs).
- **Redis Cache:** Caches frequently accessed data for fast retrieval.
- **Object Storage (S3):** Stores historical sensor data and generated reports.

## User Access & Dashboards

- **CDN:** Distributes frontend assets and reduces latency.
- **Load Balancer:** Manages user requests to backend servers.
- **User Dashboard:** Provides real-time data visualization and alerts.

---
