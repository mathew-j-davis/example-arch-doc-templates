# Example Concept Pack
slide-type:: title-slide
title:: Example Enterprise Architecture Concept Pack
subtitle:: Demonstrating the Concept Pack System
description:: Automated generation from YAML + Markdown
author:: Concept Pack System
version:: 1.0
date:: 2024-11-25

---

# Introduction
slide-type:: text-slide
title:: What is this?
category:: Overview

text::
This is an example **concept pack** demonstrating:

- Table-based architecture diagrams
- Automated diagram generation
- PNG export for presentations
- PowerPoint generation from markdown

The system automatically generates professional diagrams and presentation slides from simple YAML and markdown files.
::end

---

# Executive Summary

slide-type:: executive-summary

opportunity-name:: Cloud Migration Phase 1
opportunity-number:: OD-2024-105

opportunity-recommendation::
Migrate core services to cloud infrastructure using a phased approach. Begin with non-critical services to validate the migration pattern before moving production workloads.
::end

roadmap-fit:: On-roadmap
roadmap-fit-topbar-color:: 00B050

design-effort:: Moderate
design-effort-topbar-color:: FFC000

tech-identified:: All identified
tech-identified-topbar-color:: 00B050

governance:: Light-touch TDA
governance-topbar-color:: 00B050

decision-requested:: Endorse
decision-requested-fill:: 00A79D
decision-requested-text-color:: FFFFFF

---

# System Architecture
slide-type:: image-slide
title:: Conceptual Architecture
category:: Architecture
image:: output/architecture.png
image-width:: 9.5

---

# Key Components
slide-type:: text-slide
title:: Architecture Layers
category:: Technical

text::
## Presentation Layer
- Web UI for browser access
- Mobile App for iOS/Android
- API Gateway for integrations

## Business Logic
- Order Service for transaction processing
- User Service for account management
- Payment Service for financial operations

## Data Layer
- Database for persistent storage
- Cache for performance
- Object Storage for files
::end

---

# External Integrations
slide-type:: text-slide
title:: Third-Party Services
category:: Integration

text::
The system integrates with:

1. **Payment Gateway** - Secure payment processing
2. **Email Service** - Transactional emails
3. **SMS Provider** - Notifications and alerts
4. **Analytics** - Usage tracking and insights
::end

---

# Security & Compliance
slide-type:: text-slide
title:: Cross-Cutting Concerns
category:: Security

text::
Security is built into every layer:

- **Authentication** - OAuth 2.0 / SAML
- **Authorization** - Role-based access control
- **Encryption** - Data at rest and in transit
- **Audit Logging** - Complete audit trail
- **GDPR** - Privacy by design
::end

---

# Infrastructure
slide-type:: text-slide
title:: Platform Foundation
category:: Operations

text::
Built on modern cloud infrastructure:

- **Kubernetes** for container orchestration
- **Load Balancer** for high availability
- **Monitoring** for observability
- **Logging** for troubleshooting

Fully automated deployment pipeline with CI/CD.
::end

---

# Next Steps
slide-type:: text-slide
title:: Getting Started
category:: Action Items

text::
To use this system in your project:

1. Copy the example files
2. Customize the architecture YAML
3. Update the markdown content
4. Run the build scripts
5. Generate your presentation

See the README for detailed instructions.
::end

---

# Technology Stack

slide-type:: table
table-style:: technology-stack

| Capability | Layer | Technology | Status | Notes |
|------------|-------|------------|--------|-------|
| Container Platform | Infrastructure | AWS ECS | Reuse | Standard platform |
| Load Balancing | Integration | ALB | Reuse | Existing |
| Database | Data & storage | RDS PostgreSQL | Reuse | Managed service |
| Cache | Data & storage | ElastiCache | New | Performance layer |
| Monitoring | Observability | CloudWatch | Reuse | Standard tooling |

---

# Thank You
slide-type:: section-slide
title:: Questions?
subtitle:: Example Concept Pack System
category:: Closing

---