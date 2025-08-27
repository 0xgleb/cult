# Nix Development Environment Setup - 2025-08-27

## Overview

Set up a comprehensive Nix flake with devenv.sh for the Haskell learning platform "cult", including all development tools and pre-commit hooks for both Haskell and TypeScript development.

## Design Decisions

### Why devenv.sh over plain Nix flake?
- Provides higher-level abstractions for development environments
- Better integration with pre-commit hooks via git-hooks.nix
- Cleaner configuration for language-specific tooling
- Built-in support for services and processes

### Tool Selection Rationale
- **Stack**: Industry standard for Haskell project management, better than cabal for complex projects
- **fourmolu**: Maintained fork of ormolu with better configuration options
- **pnpm**: Faster and more efficient than npm/yarn for TypeScript projects
- **git-hooks.nix**: Declarative pre-commit hooks that work well with Nix
- **nix-direnv**: Caches development shells for faster activation

## Implementation Plan

### Section 1: Core Nix Flake Setup
- [ ] Create `flake.nix` with devenv.sh input
- [ ] Configure nixpkgs and devenv inputs with latest stable versions
- [ ] Set up basic devShell output structure
- [ ] Test basic flake evaluation with `nix flake check`

### Section 2: Haskell Development Environment
- [ ] Add Stack package manager (latest LTS resolver)
- [ ] Configure GHC compiler with common language extensions
- [ ] Add Haskell Language Server (HLS) for IDE support
- [ ] Include hlint for static analysis and linting
- [ ] Add fourmolu for consistent code formatting
- [ ] Configure PATH and environment variables for Haskell tools

### Section 3: TypeScript Development Environment  
- [ ] Add Node.js LTS version (latest stable)
- [ ] Include pnpm package manager for dependency management
- [ ] Add TypeScript compiler for type checking
- [ ] Configure eslint for JavaScript/TypeScript linting
- [ ] Add prettier for code formatting
- [ ] Set up proper NODE_PATH and npm global directories

### Section 4: Pre-commit Hooks Configuration
- [ ] Integrate git-hooks.nix for declarative pre-commit setup
- [ ] Configure Nix-specific hooks:
  - [ ] deadnix - detect unused Nix code
  - [ ] statix - static analysis for Nix expressions
  - [ ] nixfmt-classic - format Nix code consistently
  - [ ] nil - Nix language server diagnostics
- [ ] Configure Haskell hooks:
  - [ ] fourmolu formatting enforcement
- [ ] Configure TypeScript/JavaScript hooks:
  - [ ] prettier formatting for JS/TS/JSON/YAML
  - [ ] eslint for code quality checks
- [ ] Add yamlfmt for YAML file formatting
- [ ] Test pre-commit hook installation and execution

### Section 5: Direnv Integration
- [ ] Create `.envrc` file with `use flake` directive
- [ ] Configure nix-direnv for shell caching
- [ ] Add `.direnv/` to `.gitignore`
- [ ] Test automatic environment activation

### Section 6: Git Configuration
- [ ] Update `.gitignore` with comprehensive development artifacts:
  - [ ] Nix build outputs (`result`, `result-*`)
  - [ ] Direnv cache (`.direnv/`)
  - [ ] Haskell build artifacts (`.stack-work/`, `dist-newstyle/`)
  - [ ] TypeScript/Node artifacts (`node_modules/`, `.pnpm-store/`, `.next/`)
  - [ ] Editor temporary files

### Section 7: Documentation Updates
- [ ] Update `README.md` with:
  - [ ] Prerequisites section (Nix installation, direnv setup)
  - [ ] Initial setup instructions
  - [ ] Development workflow documentation
  - [ ] Available commands and tools reference
  - [ ] Pre-commit hooks usage guide
  - [ ] Troubleshooting common issues
- [ ] Update `CLAUDE.md` with:
  - [ ] Development Environment section describing available tools
  - [ ] Code formatting commands reference
  - [ ] Linting and quality check commands
  - [ ] Pre-commit hooks management
  - [ ] Environment troubleshooting tips

### Section 8: Testing and Validation
- [ ] Test complete environment setup from scratch
- [ ] Verify all tools are accessible and working
- [ ] Test pre-commit hooks trigger correctly
- [ ] Validate direnv automatic activation
- [ ] Ensure reproducibility across different systems

## Success Criteria

1. **Functional Development Environment**: All specified tools (Stack, hlint, fourmolu, pnpm, eslint, prettier) are available and working
2. **Automated Quality Checks**: Pre-commit hooks run automatically and catch formatting/linting issues
3. **Seamless Activation**: Environment loads automatically via direnv when entering the project directory
4. **Comprehensive Documentation**: Both README.md and CLAUDE.md contain clear setup and usage instructions
5. **Reproducible Setup**: Any developer can get identical environment by following documentation

## Expected File Structure

```
cult/
├── flake.nix           # Main Nix flake with devenv configuration
├── .envrc              # Direnv configuration for automatic activation
├── .gitignore          # Updated with all development artifacts
├── README.md           # Updated with setup and usage instructions  
├── CLAUDE.md           # Updated with development tools reference
└── .claude/
    └── tasks/
        └── 2025-08-27-nix-devenv-setup.md  # This planning document
```

Note: `flake.lock` will be automatically generated during first use.