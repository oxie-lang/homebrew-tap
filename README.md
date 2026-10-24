# Homebrew tap for Oxie

[Oxie](https://github.com/oxie-lang/oxie) is a programming language for the Rust ecosystem: a
concise syntax that Kotlin and TypeScript developers already know, compiled to plain Rust.

```bash
brew install oxie-lang/tap/oxie
```

`brew upgrade oxie` updates it. The formula in `Formula/oxie.rb` installs the prebuilt `oxie`
from the [releases](https://github.com/oxie-lang/oxie/releases) of the main repository, on macOS
and Linux. Each release commits it here; edit it through `dist-workspace.toml` in
[oxie-lang/oxie](https://github.com/oxie-lang/oxie), not in this repository.
