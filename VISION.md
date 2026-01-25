# Project vision

## Introduction

This project aims to build the ultimate ephemeral event management system. I am moving away from bloated, account-based corporate software to create something lightweight, privacy-focused, and transient. The core idea is simple: you spawn an event, you manage it, you export your memories, and then the system destroys any data associated with it. Clean, fast, and secure :3

## Core philosophy

most event software tries to keep your data forever. We don't. We believe in software serving **you**, not the other way around

* **No accounts:** access is granted via magic links and QR codes
* **Isolation:** each event is its own "island" OwO
* **No footprint:** once the event is over, the server wipes the data permanently!! :3

## The lifecycle

The application flow is designed to be linear and destructive

1. An admin requests an event. The server spins up a dedicated sqlite (i love SQLite fhjdafsadjlkfasjlk) database and emails a magic link (main form of auth for now)
2. The team manages the event in real-time using the various dashboards, each dedicated to a separate task/responsibilities
3. The admin downloads a comprehensive ZIP archive containing all data, media, and reports after the event finishes
4. Event's data gets destroyed. No trace is left behind OwO

## Functional overview

The application is divided into specific views, navigated via a sidebar

### Branding view

This is where the event finds its identity. It uses a tiled interface for maximum visibility.

* **Dashboard:** Upload logos and define the color palette (main, accent, secondary, background (unless it's secondary?), font). A contrast checker ensures the text is readable against the background
* **Press kit generator:** Automatically compiles the branding assets into a downloadable HTML/CSS/ZIP package for the mediaa
* **Templates:** Auto-generates document headers and document templates so everything looks official :3

### Human management

Managing the chaos of volunteers and staff.

* **Onboarding:** New staff (like "Dave") scan a QR code to join the "unassigned" pool.
* **Roles:** Drag-and-drop users into roles like "Event manager," "Artist," or "Volunteer."
* **Details:** Manage contact info and availability hours easily. You need to know when people can work x3

### Logistics view

Tracking the physical world.

* **Inventory:** A tile-based view of what you own (computers, projectors) and the status of those items (available, broken, in use).
* **Transit:** A view to track items and people moving between locations. If a volunteer is driving equipment to the venue, you will see it here. No more lost projectors OwO

### Event planner

The central brain of the operation.

* **Timetable:** A dashboard to assign resources and people to specific time slots and rooms
* **Conflict detection:** The system should warn you if you put two talks in the same room at the same time
* **Pre/post planning:** Lists for setup and cleanup tasks to ensure the venue is returned in perfect condition!!

### Social media management

A built-in tool to handle the hype ;3

* **Content pipeline:** draft, schedule, and approve posts for different platforms
* **Media storage:** place to keep the photos and assets ready for publication :3

## Technical vision

* **Frontend:** Vue.js (I love it more than my parents love me)
* **Backend:** Rust ([AETHER](https://github.com/ENIX1701/AETHER) is written mostly in Rust, and I think it's also the most sensible here)
* **Database:** SQLite, one file per event, can't get any simpler, can it?

## Conclusion

I am building a tool that respects the user's time and privacy. It appears when needed and disappears when the job is done. Making the management easy, streamlined and hassle-free :3
