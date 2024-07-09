# How Much Memory Do Linkers Need?

## Methodology

CMake has a feature called [linker launcher](https://cmake.org/cmake/help/latest/envvar/CMAKE_LANG_LINKER_LAUNCHER.html), which is a program to be prepended to linker invocations. We can create a specialized launcher to collect data.

## Development

### Requirements

- Zsh
- GNU time
- CMake >= 3.29 (required by `CMAKE_LINKER_TYPE`)
- Ninja (optional)

### Setup

```console
$ git submodule update --init --recursive --depth=1
```

### Collecting Data

```console
$ ./main.zsh
```

You might want to adjust CMake arguments inside the script.

## License

MIT
