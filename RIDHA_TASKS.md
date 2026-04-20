# Backend Setup Tasks — Ridha

## Goal
Build a NestJS backend that connects to the existing Supabase PostgreSQL database.
The frontend currently talks directly to Supabase — your job is to build the API layer that will replace that.

---

## Phase 1 — Project Setup

- [ ] Install Node.js (v20+) and npm if not already installed
- [ ] Install the NestJS CLI globally: `npm install -g @nestjs/cli`
- [ ] Scaffold a new NestJS project inside this repo: `nest new backend`
  - Choose `npm` as the package manager
- [ ] Verify it runs: `cd backend && npm run start:dev`
  - You should see: `Application is running on: http://localhost:3000`

---

## Phase 2 — Database Connection with Prisma

- [ ] Install Prisma inside the `backend/` folder:
  ```bash
  npm install prisma @prisma/client
  npx prisma init
  ```
- [ ] Create a `.env` file in `backend/` (copy from `.env.example` when Yousef provides it)
  - Fill in `DATABASE_URL` with the Supabase PostgreSQL connection string
- [ ] Define your first two models in `prisma/schema.prisma`:
  - `User` — with fields: `id`, `email`, `password`, `name`, `role` (FORWARDER or SHIPPER), `createdAt`, `updatedAt`
  - `Shipment` — with fields: `id`, `trackingNo`, `status`, `origin`, `destination`, `description`, `weight`, `userId`, `createdAt`, `updatedAt`
- [ ] Run `npx prisma db push` to sync the schema to the database
- [ ] Run `npx prisma generate` to generate the TypeScript client
- [ ] Create a `PrismaService` that wraps `PrismaClient` and inject it globally
  - Research: "NestJS Prisma service" — the official Prisma docs have a NestJS guide

---

## Phase 3 — Shipments Module

- [ ] Generate the shipments module using the CLI:
  ```bash
  nest generate module shipments
  nest generate controller shipments
  nest generate service shipments
  ```
- [ ] Implement these endpoints in the controller:
  | Method | Route | Description |
  |--------|-------|-------------|
  | POST | /api/shipments | Create a new shipment |
  | GET | /api/shipments | List all shipments |
  | GET | /api/shipments/:id | Get one shipment |
  | PATCH | /api/shipments/:id | Update a shipment |
  | DELETE | /api/shipments/:id | Delete a shipment |
- [ ] Create DTOs (Data Transfer Objects) for create and update — use `class-validator` decorators
- [ ] Test all endpoints using Postman or curl before moving on

---

## Phase 4 — Auth Module (JWT)

- [ ] Install auth dependencies:
  ```bash
  npm install @nestjs/jwt @nestjs/passport passport passport-jwt bcryptjs
  npm install -D @types/passport-jwt @types/bcryptjs
  ```
- [ ] Generate the auth module:
  ```bash
  nest generate module auth
  nest generate controller auth
  nest generate service auth
  ```
- [ ] Implement these endpoints:
  | Method | Route | Description |
  |--------|-------|-------------|
  | POST | /api/auth/register | Create a new user (hash the password with bcrypt) |
  | POST | /api/auth/login | Validate credentials, return a JWT token |
- [ ] Create a `JwtStrategy` (extends `PassportStrategy`) that validates the token on protected routes
- [ ] Create a `JwtAuthGuard` and apply it to the shipments controller
- [ ] Test: register a user → login → use the returned token to call GET /api/shipments

---

## Phase 5 — Business Rules

- [ ] Forwarders (`role: FORWARDER`) can see ALL shipments
- [ ] Shippers (`role: SHIPPER`) can only see **their own** shipments
- [ ] Only forwarders can change shipment `status`
- [ ] Only forwarders can delete shipments
- [ ] Add these checks inside `ShipmentsService` (not the controller)

---

## Phase 6 — Deployment

- [ ] Set `app.setGlobalPrefix('api')` in `main.ts` so all routes start with `/api`
- [ ] Set `app.enableCors()` in `main.ts` to allow the frontend to call the API
- [ ] Make sure all config (ports, secrets) come from `.env` — no hardcoded values
- [ ] Ask Yousef to set up the VPS deployment pipeline

---

## Resources

- NestJS Docs: https://docs.nestjs.com
- Prisma + NestJS Guide: https://docs.nestjs.com/recipes/prisma
- JWT Auth in NestJS: https://docs.nestjs.com/security/authentication
- class-validator: https://github.com/typestack/class-validator

---

## When You're Stuck

1. Read the error message carefully before asking
2. Google the exact error + "NestJS"
3. Check the NestJS docs
4. Then ask Yousef
