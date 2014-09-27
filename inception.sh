#!/bin/bash

sudo apt-get install puppet puppet-el puppet-lint hiera bundler facter
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
