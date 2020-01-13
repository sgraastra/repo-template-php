# PHP Template Repository (RFC-5)

For use with newly created **PHP 7.2+** projects &ndash; for a good example see
[**PageModels**](https://github.com/studyportals/PageModels).

## Using the Template

Create a new repository in GitHub using `repo-template-php` as your template.
Once you've checked out your new repository, make the following modifications to
the template files:

1. Add proper `name`- and `description`-properties to your [`composer.json`]()
2. Update `CC_TEST_REPORTER_ID=...` in [`.travis.yml`]() with a proper Code
   Climate ID to enable code-coverage reporting &ndash; if you don't want to use
   Code Climate, remove [`.travis.yml`]() instead
3. Remove [`README.md`]() (and ideally replace it with your own read me)

When you've made the above modifications, run `composer install`. A new commit
to initialise the auto-update functionality is automatically created for you;
its commit message should pop up.

## The Coding Standard

Uses **PHP Code Sniffer** (`phpcs`) to enforce the
**[PSR-12 extended coding style](https://www.php-fig.org/psr/psr-12/)**.

Apart from PSR-12, Code Sniffer also enforces
**[strict type-checks for scalar types](https://wiki.php.net/rfc/scalar_type_hints_v5)**.
You need to manually enable these checks in _each_ PHP file as follows:

```php
<?php declare(strict_types=1);

// Code goes here...
```

It enables the full
[**PHP Mess Detector** (`phpmd`) rule-set](https://phpmd.org/rules/index.html)
with the exception of the
[controversial-rules](https://phpmd.org/rules/controversial.html), the
[naming-rules](https://phpmd.org/rules/naming.html) (which are covered by
PSR-12) and the [Unused variable rule]() (which is covered by PHPStan).

It uses the **[PHP Static Analysis Tool](https://github.com/phpstan/phpstan)**
(`phpstan`) to enforce the maximum type-strictness (and catch a large variety of
additional errors in the process).

⚠ Finally, it provides a skeleton for setting up PHPunit (including code
coverage analysis) and Code Climate. And uses the composer git-hooks package to
run all of the above checks pre-push.

## Automatic Updates

There a shell-script in `.github/repo-template/update.sh` which intents to keep
your local copy of the template up-to-date with the template on GitHub.

Whenver your run `composer install` it automatically merges changes from the
template into your repository.

## Caveats

Due to limitations with phpmd, there are two separate phpmd configurations (one
for src, one for tests).

phpunit, all files should end in `*Test.php`

For code-coverage to work you need to install XDebug; this is not enforced
through `composer.json` as that might lead to unnecesarily loading it in on
development environments...
