#!/bin/bash

# required packages
sudo apt-get install -y puppet puppet-lint facter
# best efford packages
sudo apt-get install -y hiera
sudo apt-get install -y bundler
sudo apt-get install -y facter
sudo apt-get install -y puppet-el

# install and exec librarian-puppet
bundle install --path vendor/bundle
bundle exec librarian-puppet install

sudo puppet apply manifests/init.pp --config manifests/puppet.conf $@

FILE=data/node/$(facter fqdn).yaml
if [[ ! -f "$FILE" ]]; then
/bin/cat <<EOM >$FILE
---
classes:
  - logrotate
EOM
fi
