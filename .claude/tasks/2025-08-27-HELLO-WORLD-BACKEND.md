# Task: Setup Haskell Backend with Stack and Servant

**Date**: 2025-08-27
**Goal**: Create a minimal Haskell backend using Stack and Servant that serves a "Hello World" endpoint with unit tests

## Design Decisions

### Technology Choices

- **Stack**: For reproducible builds and dependency management
- **Servant**: Type-safe web API framework (latest version)
- **Protolude**: Alternative prelude for better defaults
- **Hspec**: For unit testing with automatic test discovery
- **Warp**: Web server for running the Servant application

### Project Structure

```
cult/
├── app/
│   └── Main.hs           # Application entry point
├── src/
│   └── Server.hs        # API definitions and server implementation (colocated)
├── test/
│   ├── Spec.hs          # Auto-discovery entry point
│   └── ServerSpec.hs    # Server endpoint tests
├── stack.yaml            # Stack configuration
├── package.yaml          # Package configuration with language extensions
├── cult.cabal           # Generated Cabal file
├── README.md            # Updated with backend instructions
└── CLAUDE.md            # Updated with testing guidelines
```

### Language Extensions

Will be configured at project level in package.yaml:

- `NoImplicitPrelude` - Disable default Prelude to use Protolude
- `DataKinds` - Required for Servant type-level API specification
- `TypeOperators` - For Servant's `:>` operator
- `OverloadedStrings` - For string literals
- `DeriveGeneric` - For JSON serialization (if needed)

## Implementation Tasks

## Task 1. Initialize Stack Project

- [x] Initialize Stack project in root directory
- [x] Create package.yaml with proper configuration
- [x] Set up stack.yaml with LTS resolver
- [x] Create directory structure (app/, src/, test/)

### Details:

- Use latest LTS resolver (lts-24.7)
- Configure package name as "cult"
- Add protolude, servant, servant-server, warp as dependencies
- Add hspec, hspec-discover, hspec-wai, servant-client for testing
- Configure language extensions at package level including NoImplicitPrelude
- Set hspec-discover as test build tool

## Task 2. Implement Server Module

- [ ] Create src/Server.hs with API and implementation colocated
- [ ] Define API type using Servant DSL
- [ ] Create simple "Hello World" endpoint at GET /hello
- [ ] Implement handler for Hello World endpoint
- [ ] Create server function combining API and handler
- [ ] Export server, app, and API type for testing

### Details:

```haskell
module Server where

import Protolude
import Servant
import Network.Wai (Application)

-- API Definition
type HelloAPI = "hello" :> Get '[PlainText] Text

helloAPI :: Proxy HelloAPI
helloAPI = Proxy

-- Handler Implementation
helloHandler :: Handler Text
helloHandler = return "Hello World"

-- Server
server :: Server HelloAPI
server = helloHandler

-- WAI Application
app :: Application
app = serve helloAPI server
```

## Task 3. Create Application Entry Point

- [ ] Set up app/Main.hs
- [ ] Configure port (default 8080)
- [ ] Run Warp server with the application
- [ ] Add startup message

### Details:

```haskell
module Main where

import Protolude
import Network.Wai.Handler.Warp (run)
import Server (app)

main :: IO ()
main = do
  putStrLn ("Starting server on http://localhost:8080" :: Text)
  run 8080 app
```

## Task 4. Write Unit Tests with Auto-Discovery

- [ ] Create test/Spec.hs for hspec-discover auto-discovery
- [ ] Create test/ServerSpec.hs with actual tests
- [ ] Test correct response status (200)
- [ ] Test response body contains "Hello World"

### Details:

**test/Spec.hs** (auto-discovery entry point):

```haskell
-- This file is auto-discovered by hspec-discover
{-# OPTIONS_GHC -F -pgmF hspec-discover #-}
```

**test/ServerSpec.hs** (actual tests):

```haskell
module ServerSpec where

import Protolude
import Test.Hspec
import Test.Hspec.Wai
import Server (app)

spec :: Spec
spec = with (return app) $ do
  describe "GET /hello" $ do
    it "responds with 200" $ do
      get "/hello" `shouldRespondWith` 200

    it "responds with 'Hello World'" $ do
      get "/hello" `shouldRespondWith` "Hello World" {matchStatus = 200}
```

## Task 6. Update README.md

- [ ] Add section for backend development
- [ ] Document how to build the project
- [ ] Document how to run the server
- [ ] Document how to run tests
- [ ] Include testing philosophy

### Details to add:

```markdown
## Backend Development

### Building the Project

`stack build`

### Running the Server

`stack run`
Server will start on http://localhost:8080

### Running Tests

`stack test`

### Testing Guidelines

- All API endpoints must have corresponding unit tests
- Tests should verify both response status and content
- Run tests before committing changes
```

## Task 7. Update CLAUDE.md

- [ ] Add backend-specific development commands
- [ ] Document strict testing requirements
- [ ] Add Stack commands reference
- [ ] Include formatting/linting instructions for Haskell

### Details to add:

- Testing requirement: All endpoints MUST have unit tests
- Formatting: Use `fourmolu --mode inplace` on all Haskell files
- Linting: Use `hlint src/ app/ test/` before commits
- Stack commands: build, test, run, ghci

## Testing Strategy

### Unit Testing Guidelines

1. **Coverage Requirement**: Every endpoint MUST have at least one test
2. **Test Categories**:
   - Happy path tests (expected behavior)
   - Status code verification
   - Response body verification
3. **Test Organization**: Group tests by endpoint
4. **Pre-commit**: Tests must pass before committing

### Verification Commands

```bash
# Build the project
stack build

# Run tests
stack test

# Run the server
stack run

# Format code
fourmolu --mode inplace src/**/*.hs app/**/*.hs test/**/*.hs

# Lint code
hlint src/ app/ test/
```

## Success Criteria

- [ ] Stack project builds successfully without errors
- [ ] Server starts and responds on http://localhost:8080/hello
- [ ] GET /hello returns "Hello World" with 200 status
- [ ] All unit tests pass
- [ ] Code is formatted with fourmolu
- [ ] Code passes hlint checks
- [ ] README.md updated with backend instructions
- [ ] CLAUDE.md updated with testing requirements

## Notes

- The project remains at the repository root rather than in a subdirectory
- This aligns with the monorepo structure where backend and frontend will coexist
- Language extensions are configured at project level in package.yaml, not file level
