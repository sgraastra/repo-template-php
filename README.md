# Repository Template for PHP 7.2+

For use with newly created **PHP 7.2+** projects &ndash; for a good example see
[**CMS**](https://github.com/studyportals/CMS).

- [Using the Template](#using-the-template)
  - [Travis CI](#travis-ci)
  - [GitHub Super-Linter](#github-super-linter)
  - [Initialise Automatic Updates (`update.sh`)](#initialise-automatic-updates-updatesh)
  - [Dependabot](#dependabot)
- [The Coding Standard](#the-coding-standard)
- [Automatic Updates](#automatic-updates)
- [Caveats](#caveats)

## Using the Template

Create a new repository in GitHub using `repo-template-php` as your template.
Once you've checked out your new repository, make the following modifications:

1. Add proper `name`- and `description`-properties to your
   [`📄 composer.json`](./composer.json)
2. Remove [`📄 README.md`](./README.md) (and ideally replace it with your own
   `README.md`)
3. Execute `composer install` and _commit_ `composer.lock`
4. Initialise [automatic updates](#initialise-automatic-updates-updatesh)
5. Set up [Travis CI](#travis-ci) and/or the
   [GitHub Super-Linter](#github-super-linter)
6. Have a look at [`📄 .dependatbot/config.yml`](./.dependabot/config.yml) if
   you wish to [fine-tune Dependabot](#dependabot)
7. Push all your changes to GitHub

You will need to commit using `--no-verify` after you do the above &ndash; there
is a pre-commit hook in place that prevents you from accidentally committing to
either the `develop` or `master` branch directly.

### Travis CI

A default Travis CI configuration is provided in
[`📄 .travis.yml`](./.travis.yml). To activate the Travis-integration for your
repository, you need to install
[Travis CI from the GitHub Marketplace](https://github.com/marketplace/travis-ci).

Currently, Travis CI runs the following checks:

- `phpunit`
- `phpstan`
- `phpcs`
- `phpmd`

### GitHub Super-Linter

There is preliminary support for the
[GitHub Super-Linter](https://github.com/github/super-linter). Not all checks
run by Travis CI are supported yet (and the Super-Linter is still in active
development), but the basic integration is up and running.

Currently, the Super-Linter runs the following checks:

- `phpstan`
- `phpcs`

If you would like to _disable_ the Super-Linter, remove
`📄 .github/workflows/linter.yml` and `📁 .github/linters` and commit your
changes.

For additional instructions on configuration the Super-Linter, see
[`📄 .github/linters/README.md`](./.github/linters/README.md).

### Initialise Automatic Updates (`update.sh`)

Execute `sh .github/repo-template/update.sh -f` to initialise the
[automatic update functionality](#automatic-updates). A commit is automatically
created for you; its commit message should pop up.

⚠ On **Windows**, the `sh` command _might_ fail &ndash; in that case manually
execute `.\.github\repo-template\update.sh -f` using Git Bash.

### Dependabot

To prevent [Dependabot](https://dependabot.com/) from updating your libraries
too proactively (i.e. by automatically bumping them to new,
backwards-incompatible, versions), it is recommended you use
[caret version ranges](https://getcomposer.org/doc/articles/versions.md#caret-version-range-)
in your [`📄 composer.json`](./composer.json).

This instructs Dependabot to only update minor- and patch-revisions; which
_should_ not contain non-breaking changes...

If you prefer to be more restrictive, use
[tilde version ranges](https://getcomposer.org/doc/articles/versions.md#tilde-version-range-).
This instructs Dependabot to only update patch-revisions. Note that for this to
work properly, you need to specify a full semantic version (e.g. `1.2.3`). If
you specify only the major- and minor-revision (e.g. `1.2`) the tilde range is
identical to the caret range (e.g. `~1.2` is identical to `^1.2.3`).

## The Coding Standard

Uses **[PHP Code Sniffer](https://github.com/squizlabs/PHP_CodeSniffer)**
(`phpcs`) to enforce the
**[PSR-12 extended coding style](https://www.php-fig.org/psr/psr-12/)**.

Apart from PSR-12, Code Sniffer also enforces
**[strict type-checks for scalar types](https://wiki.php.net/rfc/scalar_type_hints_v5)**.
You need to manually enable these checks in _each_ PHP file as follows:

```php
<?php declare(strict_types=1);

// Code goes here...
```

Enable the full
[**PHP Mess Detector** (`phpmd`) rule-set](https://phpmd.org/rules/index.html)
with the exception of the
[controversial-rules](https://phpmd.org/rules/controversial.html), the
[naming-rules](https://phpmd.org/rules/naming.html) (which are covered by
PSR-12) and the [Unused variable rule]() (which is covered by PHPStan &ndash;
see below).

Use the **[PHP Static Analysis Tool](https://github.com/phpstan/phpstan)**
(`phpstan`) to enforce maximum type-strictness (and catch a large variety of
additional errors in the process).

Provide a skeleton for setting up
**[PHPUnit](https://github.com/sebastianbergmann/phpunit)** (including code
coverage analysis) and **[Code Climate](https://codeclimate.com/)**.

Finally, use
**[composer-git-hooks](https://github.com/BrainMaestro/composer-git-hooks)** to
run all of the above checks before allowing you to push to GitHub.

## Automatic Updates

The [`.github/repo-template/update.sh`](.github/repo-template/update.sh)
shell-script is intended to keep your repository's copy of the template
configuration up-to-date with main template on GitHub.

It is set up as a Git `post-checkout` hook using `composer-git-hooks`. Whenever
you switch to a branch that is _not_ `master` or `develop`, the script will
attempt to automatically update the template configuration.

The functionality is still somewhat experimental. If it gets on your nerve, feel
free to update [`composer.json`](composer.json) and remove the `post-checkout`
line under `extra:{hooks}`.

## Caveats

Due to limitations with regards to configuring `phpmd`, there are two separate
configuration files: One for the `src/`-folder and one for the `tests/`-folder.
When you execute `composer run phpmd`, both configurations are run in sequence;
to execute the checks individually, use `composer run phpmd:src` or
`phpmd:tests` respectively.

For PHPUnit to properly work, all your test-files should end in `*Test.php`
_and_ they need to be located in the `tests/` folder.

For code-coverage to work you need to install **[XDebug](https://xdebug.org/)**;
this is not enforced through `composer.json` as that might lead to unnecessarily
loading it on production-environments...
