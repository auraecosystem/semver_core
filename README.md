# SemVer Runtime Architecture Core

[![License: CC BY 4.0](https://shields.io)](https://creativecommons.org/licenses/by/4.0/)

A high-performance, production-grade [Semantic Versioning (SemVer)](https://semver.org) runtime engine written in C, Yacc, and Lex. Provides fast, reliable version parsing, constraint evaluation, and dependency resolution.

## 🚀 Features

- **High-Performance Tokenizer** — Lex-based lexical analyzer for efficient version constraint parsing
- **Strict Grammar-Based Parsing** — Yacc parser with Backus-Naur Form grammar for secure semantic expression handling
- **Flexible Range Evaluation** — Supports caret (`^`), tilde (`~`), wildcards, and compound constraints (e.g., `>=1.2.0 <2.0.0`)
- **Dependency Resolution** — Graph-based resolver for handling overlapping version constraints across nested dependencies

## 📁 Project Structure

```
semver_core/
├── compare/              # Version comparison logic
│   └── comparator.c      # Core comparison utilities
├── constraint/           # Range constraint handling
│   ├── evaluator.c       # Range validation
│   ├── parser.c          # Constraint parsing
│   └── range.c           # Range boundary management
├── docs/                 # Documentation and specifications
├── grammar/              # Parser grammar definitions
│   └── semver.bnf        # Backus-Naur Form grammar
├── include/              # Header files
│   └── semver.h          # Core runtime definitions
├── parser/               # Parsing engines
│   ├── lexer.c           # Tokenizer
│   ├── parser.c          # Parser implementation
│   └── tokenizer.c       # Token processing
├── resolver/             # Dependency resolution
│   └── dependency_resolver.c
├── runtime/              # Core execution
│   └── semver_runtime.c  # Runtime environment
├── spec/                 # Specifications
├── tests/                # Test suites
└── validator/            # Version format validation
```

## 🛠️ Installation & Build

### Prerequisites

- C compiler (`gcc` or `clang`)
- `flex` (Lexical Analyzer Generator)
- `bison` (Parser Generator)

### Compilation

```bash
# Generate lexer and parser from definitions
flex standard.lex
yacc -d semver.bnf

# Compile the runtime
gcc -O3 \
  -Iinclude \
  runtime/*.c \
  parser/*.c \
  validator/*.c \
  compare/*.c \
  constraint/*.c \
  resolver/*.c \
  lex.yy.c \
  semver.tab.c \
  -o bin/semver_core
```

## 📖 Usage

### Version Comparison

Compare two versions against a constraint:

```bash
./bin/semver_core --compare "2.1.3" "^1.2.0"
```

### Dependency Resolution

Create a `Package.toml` manifest:

```toml
[package]
name = "my_app"
version = "1.0.0"

[dependencies]
core_lib = "^2.4.0"
utils = ">=1.0.2 <1.5.0"
```

Resolve dependencies:

```bash
./bin/semver_core --resolve Package.toml
```

This generates a `Lockfile.mkdn` with resolved versions.

## 🧪 Testing

### Memory Leak Detection

Enable memory tracking in `semver.h` and call:

```c
report_memory_leaks();
```

### Valgrind Verification

```bash
valgrind --leak-check=full --show-leak-kinds=all ./bin/semver_core
```

## 📋 SemVer Format

This engine supports the standard SemVer format:

```
MAJOR.MINOR.PATCH[-PRERELEASE][+BUILD]
```

Example: `1.2.3-alpha.1+build.123`

## 📜 License

Licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

© 2025 [Seriki Walter Yakub](https://github.com/auraecosystem)
