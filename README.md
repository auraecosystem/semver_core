[semver](https://semver.org)

SEMVER RUNTIME ARCHITECTURE
===========================
```bnf
semver/
├── grammar/
│   └── semver.bnf
├── include/
│   └── semver.h
├── parser/
│   ├── lexer
│   ├── parser
│   └── tokenizer
├── validator/
│   └── validator
├── compare/
│   └── comparator
├── constraint/
│   ├── parser
│   ├── evaluator
│   └── range
├── resolver/
│   └── dependency_resolver
├── runtime/
│   └── semver_runtime
├── tests/
├── docs/
└── spec/
