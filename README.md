# opencode-flake

Nix flake for [OpenCode](https://opencode.ai) AI coding assistant.

## Usage

```bash
# Run directly
nix run github:crimera/opencode-flake

# With dev tools (ktlint, ruff, pyright, nixd)
nix run github:crimera/opencode-flake#opencode-full

# Install to profile
nix profile install github:crimera/opencode-flake
nix profile install github:crimera/opencode-flake#opencode-full
```

## Packages

| Package | Description |
|---------|-------------|
| `opencode` | CLI binary only |
| `opencode-full` | CLI + ktlint, ruff, pyright, nixd |

## Integration

Add to your `flake.nix`:

```nix
inputs.opencode.url = "github:crimera/opencode-flake";

# Then in your module:
# environment.systemPackages = [ inputs.opencode.packages.aarch64-darwin.opencode-full ];
```
