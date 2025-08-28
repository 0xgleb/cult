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
2. **React Frontend**: TypeScript with [Effect] library and shadcn UI components
3. **In-Browser Haskell Execution**: GHC WebAssembly backend for running Haskell in the browser

## Technology Stack (Planned)

- **Backend**: Haskell with Servant, Persistent + PostgreSQL, JWT auth
- **Frontend**: React, TypeScript, [Effect] library, Monaco Editor, shadcn UI
- **Infrastructure**: Nix Flakes for reproducible builds, Vercel for frontend deployment
- **Execution Engine**: GHC compiled to WebAssembly for in-browser Haskell execution

## Current State

The repository currently contains only documentation files:

- @README.md: Basic project description
- @ROADMAP.md: Comprehensive implementation plan with 8 epics covering execution engine, exercise system, backend API, frontend, infrastructure, analytics, advanced features, and community features
- No source code has been implemented yet

## Development Notes

- The project emphasizes type safety across the entire stack
- Security is a major consideration for the in-browser execution environment
- The platform will use property-based testing (QuickCheck) extensively
- Curriculum will be adaptive based on student performance
- Infrastructure will be managed with Nix for reproducible builds

## Development Environment

The project uses Nix Flakes with devenv for reproducible development environments. The environment is automatically activated via direnv when entering the project directory.

### Core Components

- **Nix Flakes**: Provides declarative, reproducible builds and development environments
- **devenv**: Simplifies Nix-based development environment configuration
- **direnv**: Automatic environment activation when entering project directory
- **git-hooks.nix**: Declarative pre-commit hooks integrated with the development environment

### Available Development Tools

**Haskell Toolchain:**

- `ghc` - Glasgow Haskell Compiler (latest stable)
- `stack` - Haskell project management and build tool
- `haskell-language-server` - IDE support and diagnostics
- `hlint` - Static analysis and linting for Haskell code
- `fourmolu` - Consistent code formatting for Haskell

**TypeScript/JavaScript Toolchain:**

- `node` - Node.js runtime (LTS version)
- `pnpm` - Fast, efficient package manager
- `tsc` - TypeScript compiler
- `eslint` - Code quality and linting for JS/TS
- `prettier` - Code formatting for JS/TS/JSON/YAML/MD

**Additional Tools:**

- `yamlfmt` - YAML file formatting
- `taplo` - TOML formatting and linting
- `deadnix` - Unused Nix code detection
- `statix` - Static analysis for Nix expressions
- `nixfmt-classic` - Nix code formatting
- `nil` - Nix language server for diagnostics

### Code Formatting Commands

Use these commands for consistent code formatting:

**Haskell:**

```bash
# Format single file
fourmolu --mode inplace src/MyModule.hs

# Format all Haskell files
find . -name "*.hs" -not -path "./.stack-work/*" -exec fourmolu --mode inplace {} \;
```

**TypeScript/JavaScript:**

```bash
# Format with prettier
pnpm exec prettier --write "src/**/*.{ts,tsx,js,jsx,json,yaml,yml,md}"

# Lint with eslint
pnpm exec eslint "src/**/*.{ts,tsx,js,jsx}" --fix
```

**Nix:**

```bash
# Format Nix configuration files
nixfmt-classic flake.nix devenv.nix
```

### Linting and Quality Check Commands

**Haskell:**

```bash
# Run hlint for static analysis
hlint src/

# Check with GHC
stack build --fast --ghc-options="-Wall -Wextra"
```

**TypeScript:**

```bash
# Type checking
pnpm exec tsc --noEmit

# Linting
pnpm exec eslint "src/**/*.{ts,tsx,js,jsx}"
```

**Nix:**

```bash
# Check for unused code
deadnix flake.nix

# Static analysis
statix check .

# Evaluate flake
nix flake check --impure
```

### Pre-commit Hooks Management

Pre-commit hooks are automatically installed and run on every commit. They enforce code quality and formatting standards.

**Installed Hooks:**

- **Nix**: `deadnix`, `statix`, `nixfmt-classic`, `nil`
- **Haskell**: `fourmolu` formatting enforcement
- **TypeScript/JavaScript**: `prettier` formatting, `eslint` linting
- **YAML**: `yamlfmt` formatting
- **TOML**: `taplo` formatting and linting

**Hook Commands:**

```bash
# Run all hooks manually
pre-commit run --all-files

# Run specific hook
pre-commit run fourmolu --all-files
pre-commit run prettier --all-files
pre-commit run eslint --all-files

# Install/reinstall hooks
pre-commit install --install-hooks

# Skip hooks for a commit (not recommended)
git commit --no-verify -m "message"
```

### Environment Troubleshooting

**Environment not loading:**

```bash
# Rebuild environment from scratch
nix develop --impure --refresh

# Clear direnv cache
direnv reload

# Re-allow direnv
direnv allow
```

**Tools not found:**

```bash
# Verify environment is active
echo $DEVENV_ROOT

# Check available tools
which stack
which pnpm
which fourmolu

# Exit and re-enter shell
exit
nix develop --impure
```

**Pre-commit hooks failing:**

```bash
# Format code before committing
fourmolu --mode inplace **/*.hs
pnpm exec prettier --write "**/*.{ts,tsx,js,jsx,json,yaml,yml,md}"

# Check hook status
pre-commit run --all-files

# Reinstall hooks if needed
pre-commit clean
pre-commit install --install-hooks
```

**Performance issues:**

```bash
# Clean Nix store
nix store gc

# Update flake inputs
nix flake update

# Check direnv cache
ls -la .direnv/
```

The development environment is designed to be completely reproducible across different systems and provides all necessary tools for both Haskell and TypeScript development without requiring manual installation of language-specific tools.

## Next Steps

Implementation should follow the epic structure outlined in @ROADMAP.md, starting with the foundational execution engine and basic exercise system before building out the full platform features.

- Prefer self-documenting code through clear types, names, tests, and docstrings. Use comments purposefully for complex logic, design rationale, public API examples, non-obvious decisions, and TODOs when they provide value that cannot be expressed through code alone. Avoid comments that merely restate what the code does or communicate to the user during implementation.

[Effect]: https://effect.website/
