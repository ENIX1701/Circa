# Circa

Circa is an ephemeral event management system for teams that need to coordinate an event without creating a thousand accounts.

Create an event, invite the people who need access, run the operation, export what matters, then destroy the event data when it is no longer needed.

Clean, focused, and temporary by design.

> [!IMPORTANT]
> Demo accounts:  
> `maya.chen@circa.demo` **[owner]** - best all around :3  
> `oliver.grant@circa.demo` **[organizer]**  
> `sofia.marin@circa.demo` **[staff]**  
> `grace.kim@circa.demo` **[volunteer]**  

## Components

Circa is split into two layers, wired together by the root deployment image.

### [Backend](backend)

Rust API built with Actix Web, SeaORM, SQLite, JWT auth, and magic-link login. It owns users, events, memberships, branding, planner items, social posts, and lifecycle actions.

### [Frontend](frontend)

Vue 3 application built with Vite and Tailwind CSS. It provides the event hub, magic-link login, event overview, planner, branding, socials, collaborators, staff, and test inbox views.

## Features

- Magic-link authentication
- Role-aware access model
- Event creation and lifecycle management
- Event branding dashboard
- Planner checklist and timeline items
- Social post planning
- Collaborator and staff management
- Test inbox for local/demo magic-link flows
- Single-container production deployment
- Seeded demo database reset on startup and hourly

## Prerequisites

For local development:
- `Rust` with `Cargo`
- `Node.js` `24.15+`
- `npm`
- SQLite-compatible SeaORM runtime dependencies

For container deployment:
- `Docker`

## Setup

Clone with submodules:
```bash
git clone --recurse-submodules https://github.com/ENIX1701/Circa
cd Circa
```

Create backend environment:
```bash
cd backend
```

Minimum backend environment:
```env
JWT_SECRET=change-me
DATABASE_URL=sqlite://data.db?mode=rwc
FRONTEND_URL=http://localhost:5173
AUTH_DELIVERY_MODE=outbox
APP_ENV=development
PORT=8080
```

Create frontend environment:
```env
VITE_AUTH_DELIVERY_MODE=outbox
```

## Run locally

Run the backend:
```bash
cd backend
cargo run
```

Run the frontend in another terminal:
```bash
cd frontend
npm ci
npm run dev
```

The frontend runs through Vite and proxies `/api` to `http://localhost:8080`.

## Docker

The root `Dockerfile` builds the frontend, builds the Rust backend, copies the frontend `dist` into the backend image, and serves the whole app from one container. At first it was just a cost-saving measure (heroku billing by dyno...), but the performance is insane. At least for now...

```bash
docker build -t circa .
docker run -p 8080:8080 -e JWT_SECRET="change-me" circa
```

Open:
```text
http://localhost:8080
```

In production mode the backend serves the Vue SPA from `/app/public` and exposes the API under `/api`.

## Project layout

```text
.
├── backend/        # Rust Actix API
├── frontend/       # Vue/Vite client
├── Dockerfile      # single-container production build
├── heroku.yml      # Heroku deployment config
└── VISION.md       # project philosophy and product direction; may be a bit outdated, but it's what shaped Circa
```

## Data model

Circa currently stores data in SQLite.

Core entities:
- users
- magic tokens
- magic-link outbox entries
- events
- event memberships
- event branding
- planner checklist items
- planner timeline items
- social posts

The current backend resets the database from `backend/seed.sql` on startup and then once per hour. Treat this build as demo-oriented unless that behavior is changed.

## Auth

Circa uses email-based magic links.

In `outbox` delivery mode, magic links are written to the local test inbox instead of being sent through SMTP. SMTP support would be amazing, but I had no time to try that route.

JWTs are issued after a magic token is verified and are stored by the frontend for authenticated API calls.

## Roles

Circa currently models four roles:
- `admin`
- `organizer`
- `staff`
- `volunteer`

Role details live in `backend/docs/ROLES.md`.

## Quality checks

Backend:
```bash
cd backend
cargo fmt --all
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-features
```

Frontend:
```bash
cd frontend
npm run format
npm run lint
npm run type-check
npm run test:unit -- --run
npm run build
```

## Deployment

Heroku deployment is configured through `heroku.yml` and the root `Dockerfile`.

The image uses:
- `node:24-bookworm-slim` for frontend build
- `rust:1-bookworm` for backend build
- `debian:bookworm-slim` for runtime

Required runtime environment:
```env
JWT_SECRET=change-me
FRONTEND_URL=deploy.url
```

Optional runtime environment:
```env
DATABASE_URL=sqlite:///tmp/circa.db?mode=rwc
AUTH_DELIVERY_MODE=outbox
APP_ENV=production
PORT=8080
```

## Philosophy

Most event tools try to become a permanent system of record. Circa is meant to appear when an event needs structure, help the team run it, and disappear when the job is done.

The goal is lightweight coordination, minimal account overhead, and controlled data lifetime.
