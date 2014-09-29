#!/bin/bash

function create_puppetfile_if_not_exist {
    if [[ ! -f Puppetfile ]]; then
        cp Puppetfile.template Puppetfile
    fi
}

function create_node_if_not_exist {
    FILE=data/node/$(facter fqdn).yaml
    if [[ ! -f "$FILE" ]]; then
/bin/cat <<EOM >$FILE
---
classes:
  - logrotate
EOM
    fi
}

function install_required_packages {
    sudo apt-get install -y puppet puppet-lint facter
}

function install_optional_packages {
    sudo apt-get install -y hiera
    sudo apt-get install -y bundler
    sudo apt-get install -y facter
    sudo apt-get install -y puppet-el
}

function install_librarian {
    bundle install --path vendor/bundle
}

function run_librarian {
    bundle exec librarian-puppet install
}

function run_puppet {
    ARGS=$1
    sudo puppet apply manifests/init.pp --config manifests/puppet.conf $1
}

function usage {
    /bin/cat <<EOM
This script applies puppet to current machine.

Options:
  -a PUPPET_ARGS    Arguments to be sent to puppet
  -h                Show this help and exit
  -s                Skip installations
EOM
}


PUPPET_ARGS=
SKIP_INSTALLATIONS=
while getopts “ha:s” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         a)
             PUPPET_ARGS=$OPTARG
             ;;
         s)
             SKIP_INSTALLATIONS=1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $SKIP_INSTALLATIONS ]]; then
    install_required_packages
    install_optional_packages
    install_librarian
fi

create_puppetfile_if_not_exist
create_node_if_not_exist

run_librarian
run_puppet "$PUPPET_ARGS"
