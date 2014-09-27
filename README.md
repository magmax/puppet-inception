# Puppet quick start project

The idea is to start using [Puppet] in 2 minutes.

## Quick start

1. Download this repository
1. Run `./inception.sh`

Boom! That's it.


## After the quick start

1. Edit the `Puppetfile` file to add those modules you want to download
1. The `inception.sh` script should have created the file `data/[HOSTNAME].yaml`. Edit it to add more packages to your host or configure them.
1. Run `./inception.sh` again
1. Repeat this recipe as many times you want.

From now on, you should be able to manage everything just editing [yaml] files.


## Why?

Imagine you have your host perfectly puppetized but it gets broken and you need a replacement... But it is necessary to install all the base system to be able to run [Puppet].

This small script and structure will allow you to set up your machine with just one command.

## Puppet options

Any option you pass to `./inception.sh` will be passed to `puppet apply`. The most important ones:

- `-v`: Verbose mode
- `--noop`: Do not apply puppet (be careful, because `apt` and `gem` will apply their changes)



[yaml]: http://www.yaml.org/
[Puppet]: http://puppetlabs.com/
