# GitHub Super-Linter configuration files

The configuration files in this folder are used by the GitHub
[Super-Linter](https://github.com/github/super-linter) when validating the
codebase as part of the GitHub Action specified in
`📄 ./.github/workflows/linter.yml`.

Do _not_ copy additional linter configuration files to this folder; create a
**symbolic link** instead. That way, changes you make to your linter's
configuration are automatically reflected in the GitHub Action.

To create a symbolic link, execute one of the below commands from the root of
the repository (note that this needs an _elevated_ command-prompt on Windows).

```bash
# Bash
ln -s ../../[config-file] .github/linters/[config-file]

# Windows – the arguments are reversed
mklink .github/linters/[config-file] ../../[config-file]
```

If you specifically need/want a different linter configuration to be applied
during the GitHub Action, it is of course very much possible to create a
configuration file with a modified configuration in this folder. In such a case,
it is recommended to see if the linter in question supports extending upon the
repository's main configuration (e.g. the
[`extends`-property](https://eslint.org/docs/user-guide/configuring#extending-configuration-files)
in ESLint).
