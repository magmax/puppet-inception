**Project status**: Under development, but it is already usable. Structure may change, but it should be quite easy to addapt it to the new one.

# Puppet quick start project

The idea is to start using [Puppet] in 2 minutes.

## Quick start

1. Download this repository
1. Run `./inception.sh`

Boom! That's it.


## After the quick start

1. Edit the `Puppetfile` file to add those modules you want to download.
1. The `inception.sh` script should have created the file `data/[HOSTNAME].yaml`. Edit it to add more packages to your host or configure them.
1. Run `./inception.sh` again
1. Repeat this recipe as many times you want.

From now on, you should be able to manage everything just editing [yaml] files.

Optionally, you can group several classes into profiles and just use the profiles in your node. This practice is highly recommended. Some examples are provided.


### Where can I find puppet modules to be added into Puppetfile?

The easiest way to find them is by using `puppet module search`. I hightly recommend to use those in the [Example42 project], but you can add yor own ones.


## Puppet options

Any option you pass to `./inception.sh` will be passed to `puppet apply`. The most important ones:

- `-v`: Verbose mode
- `--noop`: Do not apply puppet (be careful, because `apt` and `gem` will apply their changes)


## Changelog

- Profiles included, based on [Craig Dunn presentation].


[yaml]: http://www.yaml.org/
[Puppet]: http://puppetlabs.com/
[Craig Dunn presentation]: http://puppetlabs.com/presentations/designing-puppet-rolesprofiles-pattern
[Example42 project]: https://github.com/example42
