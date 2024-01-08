#!/bin/bash -e

set -e
echo "==> Starting publish.sh"

#echo "==> Removing Gemfile.lock"
#rm -f Gemfile.lock

echo "==> Cloning Release-tools"
git clone git@github.com:conjurinc/release-tools.git

export PATH=$PWD/release-tools/bin/:$PATH

echo "==> Running publish-rubygem"
summon --yaml "RUBYGEMS_API_KEY: !var rubygems/api-key" \
  publish-rubygem memtar

echo "==> Finished publish.sh"
