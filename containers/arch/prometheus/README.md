# prometheus

An image with [prometheus-lua](https://github.com/prometheus-lua/Prometheus) preinstalled.

## Usage

One-liner with default cmd:

```sh
podman run -it --rm -v "$(pwd)/input.lua":/scripts/script.lua -v "$(pwd)/output.lua":/scripts/script.obfuscated.lua docker.io/3xpo/prometheus
```

With custom cmd:

```sh
podman run -it --rm -v "$(pwd)/input.lua":/scripts/script.lua -v "$(pwd)/output.lua":/scripts/script.obfuscated.lua docker.io/3xpo/prometheus prometheus --preset Medium /scripts/script.lua
```

### Notes

Prometheus' installation lives at `$PROMETHEUS_INSTALL`; currently equivalent to `$HOME/Prometheus`.<br/>
It's executed using LuaJIT. The Prometheus binary is installed in `/bin/prometheus`.
