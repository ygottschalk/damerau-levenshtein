#!/usr/bin/env bash
#
# set -x;
set -e;
set -o pipefail;
#
thisFile="$(readlink -f ${0})";
thisFilePath="$(dirname ${thisFile})";
#
composer self-update;
composer install --no-ansi --no-progress --no-interaction --prefer-source;

if [ "${PHPCS}" = '1' ]; then
  composer require --dev 'cakephp/cakephp-codesniffer=1.*';

  composer config repositories.Oefenweb/cakephp-codesniffer vcs https://github.com/Oefenweb/cakephp-codesniffer;
  composer require --dev 'oefenweb/cakephp-codesniffer:dev-master';
else
  composer require --dev 'phpunit/phpunit=4.*';
  if [ "${COVERALLS}" = '1' ]; then
    composer require --dev 'satooshi/php-coveralls:dev-master';
  fi
fi
