# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plan & Review

### Before starting work

- Write a comprehensive step-by-step plan to
  .claude/tasks/YYYY-MM-DD-TASK_NAME.md with each task having a corresponding
  section and a list of subtasks as checkboxes inside of it
- The plan should be a detailed implementation plan and the reasoning behind the
  design decisions
- Remain focused on the task at hand, do not include unrelated improvements or
  premature optimizations
- Once you write the plan, ask me to review it. Do not continue until I approve
  the plan.

### While implementing

- You should update .claude/tasks/YYYY-MM-DD-TASK_NAME.md every time you
  complete a section
- Upon completing a planned task, add detailed descriptions of the changes you
  made to ease the review process

## Project Overview

This is "cult" - a Haskell learning platform designed to help Rust developers transition to Haskell. The project is currently in the planning phase with a detailed implementation roadmap.

## Project Architecture (Planned)

Based on the roadmap, the system will have three main components:

1. **Haskell Backend**: Servant-based API with three-layer architecture (domain, application, infrastructure)
2. **React Frontend**: TypeScript with Effect library and shadcn UI components  
3. **In-Browser Haskell Execution**: GHC WebAssembly backend for running Haskell in the browser

## Technology Stack (Planned)

- **Backend**: Haskell with Servant, Persistent + PostgreSQL, JWT auth
- **Frontend**: React, TypeScript, Effect library, Monaco Editor, shadcn UI
- **Infrastructure**: Nix Flakes for reproducible builds, Vercel for frontend deployment
- **Execution Engine**: GHC compiled to WebAssembly for in-browser Haskell execution

## Current State

The repository currently contains only documentation files:
- `README.md`: Basic project description
- `ROADMAP.md`: Comprehensive implementation plan with 8 epics covering execution engine, exercise system, backend API, frontend, infrastructure, analytics, advanced features, and community features
- No source code has been implemented yet

## Development Notes

- The project emphasizes type safety across the entire stack
- Security is a major consideration for the in-browser execution environment
- The platform will use property-based testing (QuickCheck) extensively
- Curriculum will be adaptive based on student performance
- Infrastructure will be managed with Nix for reproducible builds

## Next Steps

Implementation should follow the epic structure outlined in ROADMAP.md, starting with the foundational execution engine and basic exercise system before building out the full platform features.
