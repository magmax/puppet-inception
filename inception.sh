#!/bin/bash

sudo apt-get install puppet puppet-el puppet-lint hiera bundler facter
bundle install --path vendor/bundle
bundle exec librarian-puppet install