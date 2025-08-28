# cult

Haskell learning platform designed to help Rust developers transition to Haskell.

## Prerequisites

Before getting started, you'll need:

1. **Nix package manager** (recommended installation via [Determinate Systems installer](https://install.determinate.systems/)):

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. **direnv** for automatic environment activation:

   ```bash
   # On macOS (via Homebrew)
   brew install direnv

   # On Linux (via package manager)
   # Ubuntu/Debian: apt install direnv
   # Arch: pacman -S direnv
   # Fedora: dnf install direnv
   ```

3. **Configure direnv** in your shell (add to `~/.bashrc`, `~/.zshrc`, etc.):
   ```bash
   eval "$(direnv hook bash)"  # for bash
   eval "$(direnv hook zsh)"   # for zsh
   ```

## Initial Setup

1. **Clone the repository**:

   ```bash
   git clone <repository-url>
   cd cult
   ```

2. **Allow direnv** (first time only):

   ```bash
   direnv allow
   ```

   This will automatically download and build the development environment.

3. **Enter the development shell** (if direnv didn't activate automatically):
   ```bash
   nix develop --impure
   ```

## Development Workflow

The development environment includes all necessary tools and will activate automatically when you enter the project directory (via direnv).

### Available Tools

**Haskell Development:**

- `ghc` - Glasgow Haskell Compiler
- `stack` - Haskell project management
- `haskell-language-server` - IDE support
- `hlint` - Static analysis and linting
- `fourmolu` - Code formatting

**TypeScript Development:**

- `node` - Node.js runtime (LTS)
- `pnpm` - Package manager
- `tsc` - TypeScript compiler
- `eslint` - Linting
- `prettier` - Code formatting

**General Tools:**

- `yamlfmt` - YAML formatting
- `taplo` - TOML formatting and linting
- Various Nix tools for development environment management

### Code Formatting Commands

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
# Format Nix files
nixfmt-classic flake.nix
```

### Pre-commit Hooks

Pre-commit hooks are automatically installed and will run on every commit to ensure code quality:

- **Nix**: `deadnix`, `statix`, `nixfmt-classic`, `nil`
- **Haskell**: `fourmolu` formatting
- **TypeScript/JavaScript**: `prettier` formatting, `eslint` linting
- **YAML**: `yamlfmt` formatting
- **TOML**: `taplo` formatting and linting

To run hooks manually:

```bash
# Run all pre-commit hooks
pre-commit run --all-files

# Run specific hook
pre-commit run fourmolu --all-files
```

### Building and Testing

**Haskell:**

```bash
# Build project
stack build

# Run tests
stack test

# Start REPL
stack ghci
```

**TypeScript:**

```bash
# Install dependencies
pnpm install

# Build project
pnpm build

# Run tests
pnpm test

# Start development server
pnpm dev
```

## Troubleshooting

### Environment Issues

**Development environment not loading:**

```bash
# Rebuild the environment
nix develop --impure --refresh

# Clear direnv cache
direnv reload
```

**Tools not found in PATH:**

```bash
# Verify environment is active
echo $DEVENV_ROOT

# Re-enter the development shell
exit
nix develop --impure
```

### Pre-commit Hook Issues

**Hooks not running:**

```bash
# Reinstall pre-commit hooks
pre-commit install --install-hooks

# Test hooks manually
pre-commit run --all-files
```

**Hook failures:**

- Check that all tools are available in the development environment
- Format code manually before committing
- Use `--no-verify` flag to skip hooks temporarily (not recommended for regular use)

### Nix-specific Issues

**Flake evaluation errors:**

```bash
# Check flake syntax
nix flake check --impure

# Update flake inputs
nix flake update

# Clean build cache
nix store gc
```

**Permission issues:**

- Ensure Nix daemon is running
- Check that your user is in the `nixbld` group
- Restart the Nix daemon: `sudo systemctl restart nix-daemon`

For more help, consult the [Nix manual](https://nixos.org/manual/nix/stable/) or [devenv documentation](https://devenv.sh/).
