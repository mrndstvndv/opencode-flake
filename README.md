# opencode-flake

Nix flake for [OpenCode](https://opencode.ai) AI coding assistant.

## Usage

```bash
# Run directly
nix run github:mrndstvndv/opencode-flake

# Install to profile
nix profile install github:mrndstvndv/opencode-flake
```

## Supported Platforms

| Platform | Architecture |
|----------|--------------|
| aarch64-darwin | Apple Silicon |
| aarch64-linux | Linux ARM64 |

## Packages

| Package | Description |
|---------|-------------|
| `opencode` | CLI binary |

## Integration

Add to your `flake.nix`:

```nix
inputs.opencode.url = "github:mrndstvndv/opencode-flake";

# Then in your module:
# environment.systemPackages = [ inputs.opencode.packages.aarch64-darwin.opencode ];
```

## Binary Distribution

This flake provides binary distributions from official releases at https://github.com/anomalyco/opencode/releases

## Links

- [OpenCode Website](https://opencode.ai)
- [OpenCode Documentation](https://opencode.ai/docs)
- [Upstream Repository](https://github.com/anomalyco/opencode)

## License

MIT
