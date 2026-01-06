# opencode-flake

Nix flake for [OpenCode](https://opencode.ai) AI coding assistant.

## Usage

```bash
# Run directly
nix run github:crimera/opencode-flake

# Install to profile
nix profile install github:crimera/opencode-flake
```

## Packages

| Package | Description |
|---------|-------------|
| `opencode` | CLI binary |

## Integration

Add to your `flake.nix`:

```nix
inputs.opencode.url = "github:crimera/opencode-flake";

# Then in your module:
# environment.systemPackages = [ inputs.opencode.packages.aarch64-darwin.opencode ];
```
