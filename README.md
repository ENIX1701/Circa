
Circa 2026

## Scratchpad

- folder structure is as follows:
  - main app with envs, etc
  - src/
    - main, lib, config, error, db rust files for main stuff
    - models/ for, well, shared models
    - modules/
      - per-module organization (each one features mod, routes, service and tests (optionally a repository or model))

- testing the auth flow requires receiving an email. it's not hard to see how it's a problem without an SMTP server... BUT! there's a solution! (I think...) that being: we'll mock an email inbox >:3c (it's a dumb idea but idk a better way to go about it...)

- okay so:
  - before adding anything new, the Event entity itself needs to exist
    - it will aggregate everything (users, branding, inventory, etc.)
    - this is the base for everything else - a staff member cannot exist without being a part of an event
  - auth flow is fine (at least for now), but there needs to be a way to test it
    - mock inbox will be implemented for that
  - the styling needs to be more consistent (hence no image background anymore)

### TODO
- [ ] parametrizable color theme (frontend event branding)
- [x] inbox view
- [x] event register form
- [ ] event lifecycle management (create -> edit -> destroy)
