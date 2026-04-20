# Jumruk Project Overview

Jumruk is a high-performance, enterprise-grade **Logistics and Customs Clearance Platform** designed to digitize and automate the lifecycle of international trade. It serves as a unified "Operating System" for Shippers, Freight Forwarders, and Customs Agents.

---

## 🚀 Tech Stack

| Category | Technology |
| :--- | :--- |
| **Frontend Framework** | React 18 (Vite, SWC) |
| **Language** | TypeScript |
| **Styling** | Tailwind CSS, Shadcn UI (Radix Primitives) |
| **State & Data Fetching** | TanStack Query (React Query) |
| **Routing** | React Router DOM |
| **Backend & Database** | Supabase (PostgreSQL, Edge Functions, Auth, Realtime) |
| **Geospatial** | Mapbox GL |
| **Form Management** | React Hook Form + Zod validation |
| **Package Manager** | Bun |

---

## 🏗️ Core Architecture & Functionality

### 1. Shipment Lifecycle Management
The platform is built around a robust **State Machine** that governs the progress of every shipment:
*   **Workflow States**: `draft` → `booked` → `ready_for_customs` → `customs_submitted` → `customs_released` → `in_transit` → `arrived` → `delivered` → `closed`.
*   **Validation**: Shipments cannot advance states unless specific document requirements (Commercial Invoice, Packing List, etc.) are satisfied.
*   **Interventions**: A dedicated system to flag and resolve "blockers" that halt shipment progress.

### 2. Multi-Role Portals
The application provides tailored experiences for different stakeholders:
*   **Forwarder/Admin Dashboard**: The primary control center for managing global operations, customers, and vendors.
*   **Shipper Portal**: A simplified client-facing interface for tracking shipments, approving orders, and managing logistics costs.
*   **Customs Module**: Specialized tools for handling customs declarations, duties, and regulatory compliance.

### 3. Key Features
*   **Global Command Center**: A "CMD+K" search interface for instant navigation and data retrieval across the entire system.
*   **HS Code Search Engine**: A specialized tool to identify Harmonized System codes, ensuring accurate duty calculations and compliance.
*   **Interactive Logistics Maps**: Real-time visualization of shipment origins, destinations, and transit paths using Mapbox.
*   **Document Requirements Engine**: Automatically determines which documents are mandatory based on the shipment type and destination.

---

## 🤖 AI & Automation Strategy

The project is positioned to deploy **Autonomous AI Agents** to handle manual back-office tasks:
*   **Document Agents**: Automated OCR and data extraction from logistics paperwork.
*   **Classification Agents**: AI-driven HS Code identification.
*   **Compliance Agents**: 24/7 monitoring of shipment data against regulatory requirements.

*Note: The current codebase provides the robust ERP/Workflow foundation upon which these agents operate.*

---

## 🔒 Security & Data Integrity
*   **Row Level Security (RLS)**: Deeply integrated Supabase RLS ensures strict data isolation between organizations.
*   **Content Security Policy (CSP)**: Active monitoring and reporting of security violations.
*   **Rate Limiting & Sanitization**: Built-in protection against common web vulnerabilities.
*   **Audit Trails**: Detailed logging of state changes and document modifications.

---

## 📂 File Structure Highlights
*   `src/types/shipment.ts`: The "Source of Truth" for the shipment state machine.
*   `src/pages/ShipperPortal.tsx`: The logic for the client-facing experience.
*   `src/components/HSCodeSearch.tsx`: The specialized customs classification tool.
*   `supabase/migrations/`: The evolving database schema and security policies.
