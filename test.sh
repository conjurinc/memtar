#!/bin/bash -eu

echo "==> Starting test.sh"

echo "==> Removing Gemfile.lock"
rm -f Gemfile.lock

echo "==> Docker Run"
docker run --rm \
    --volume $PWD:/src \
    --workdir /src cyberark/ubuntu-ruby-builder \
    bash -c 'git config --global --add safe.directory /src && gem install spec && bundle install && bundle && bundle exec rspec' 

echo "==> End of test.sh"

