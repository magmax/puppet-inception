#!/bin/bash

TMPL_PATH=templates

puppet_args=
skip_installations=
path=puppet


function create_puppetfile {
    if [ ! -f "$path/Puppetfile" ]; then
        cp "$TMPL_PATH/Puppetfile" "$path/Puppetfile"
    fi
}

function create_node {
    dir=$path/data/node
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi

    FILE=$dir/$(facter fqdn).yaml
    if [[ ! -f "$FILE" ]]; then
/bin/cat <<EOM >"$FILE"
---
classes:
  - logrotate
EOM
    fi
}

function create_manifests {
    dir=$TMPL_PATH/manifests
    target=$path/manifests

    if [ ! -d "$target" ]; then
        mkdir -p "$target"
    fi

    for filename in $(ls $dir); do
        if [ ! -f "$target/$filename" ]; then
            cp "$dir/$filename" "$target"
        fi
    done
}

function create_profiles {
    dir=$TMPL_PATH/profiles/manifests
    target=$path/profiles/manifests

    if [ ! -d "$target" ]; then
        mkdir -p "$target"
    fi

    for filename in $(ls $dir); do
        if [ ! -f "$target/$filename" ]; then
            cp "$dir/$filename" "$target"
        fi
    done
}

function create_data {
    dir=$TMPL_PATH/data
    target=$path/data

    if [ ! -d "$target" ]; then
        mkdir -p "$target"
    fi

    for filename in $(ls $dir); do
        if [ ! -f "$target/$filename" ]; then
            cp "$dir/$filename" "$target"
        fi
    done
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
    librarian-puppet install
}

function run_puppet {
    ARGS=$1
    sudo puppet apply manifests/init.pp --config manifests/puppet.conf $ARGS
}

function migrate_file {
  file=$1

  target=${path}/$(dirname $file )

  if [ ! -f "$target" ] && [ -f "$file" ]; then
      mv "$file" "$target"
  fi
}

function migrate_dir {
  dir=$1

  target=${path}/$(dirname $dir )

  if [ ! -d "$target" ] && [ -d "$dir" ]; then
      mv "$dir" "$target"
  fi
}

function migrate_0 {
  migrate_file Puppetfile
  migrate_dir manifests
  migrate_dir profiles
}

function usage {
    /bin/cat <<EOM
This script applies puppet to current machine.

Options:
  -a puppet_args    Arguments to be sent to puppet
  -h                Show this help and exit
  -s                Skip installations
  -p <PATH>         Select the path to create the puppet structure
EOM
}


while getopts "ha:s" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         a)
             puppet_args=$OPTARG
             ;;
         s)
             skip_installations=1
             ;;
         p)
             path=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $skip_installations ]]; then
    install_required_packages
    install_optional_packages
    install_librarian
fi

if [ ! -d "$path" ]; then
   mkdir -p "$path"
fi

migrate_0

create_data
create_puppetfile
create_manifests
create_profiles
create_node

run_librarian
run_puppet "$puppet_args"
