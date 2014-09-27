# Puppet quick start project

The idea is to start using [Puppet] in 2 minutes.

## Quick start

1. Download this repository
2. Run `./inception.sh`

Boom! That's it.


## Next steps

3. Edit the `Puppetfile` file to add those modules you want to download
4. The `inception.sh` script should have created the file `data/[HOSTNAME].yaml`. Edit it to add more packages to your host or configure them.
5. Repeat from step 2.

From now on, you should be able to manage everything just editing [yaml] files.


## Why?

Imagine you have your host perfectly puppetized but it gets broken and you need a replacement... But it is necessary to install all the base system to be able to run [Puppet].

This small script and structure will allow you to set up your machine with just one command.


[yaml]: http://www.yaml.org/
[Puppet]: http://puppetlabs.com/
