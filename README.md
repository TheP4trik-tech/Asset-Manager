# Asset Manager

School project given by Railsformers — a Ruby on Rails application for managing building assets, with role-based access, audit logging, QR code generation, alongside the web UI.


## Features

- **Authentication** — Devise for the web UI
- **Role-based authorization** — CanCanCan abilities for three roles:
  - `reader` — regular user, read-only access to everything, can edit own profile.
  - `admin` — manager of their own buildings: can create/manage rooms, assets and attachments within buildings they own, update their buildings.
  - `super_admin` — full access to manage everything.
- **Buildings, rooms & assets** — hierarchical structure (`Building` → `Room` → `Asset`).
- **Search** — Ransack-powered search/filtering on assets, rooms, buildings, users and audit logs, with pagination.
- **Audit log** — every create/update/destroy on an asset is automatically recorded with the acting user, action, and changed fields.
- **QR codes** — each asset has a QR code (generated via `rqrcode`) that encodes its ID, viewable or downloadable as SVG.
- **CSV export** — background job (Solid Queue) exports the current (filtered) asset list to CSV for download.
- **File attachments** — assets can have file attachments (Active Storage).

## Tech stack

- Ruby 3.3.11, Rails 8.1
- SQLite (dev/test), Solid Queue / Solid Cache / Solid Cable
- Devise (auth), CanCanCan (authorization), Ransack (search), Pagy (pagination)
- rqrcode (QR codes), Active Storage (attachments)
- Tailwind CSS, Turbo/Stimulus (Hotwire) for the UI
- RSpec + FactoryBot + Faker for testing

## Running the project

### With Docker 

```bash
docker compose up --build
```

The app will be available at localhost, with given seeding data (rails db:seed)

### Locally

```bash
bundle install
bin/rails db:setup   # creates db, loads schema, runs db/seeds.rb
bin/dev               # runs Rails server + Tailwind
```

## Testing

```bash
bundle exec rspec
```
