## Alpine Linux Vagrant Box ala Packer

Use `packer build ...` to create vagrant box to run Alpine Linux 3.6.x.

Installing from an ISO can be a little tricky, and sensitive to load on the host,
so we separate that into its own build:

```
ᐅ cd 00-iso-install
ᐅ packer build alpine-iso-install.json
```

That will use the official ISO from upstream, to install Alpine Linux in
VirtualBox, exporting the result to a box that can be imported into Vagrant.
The install is bare-minimum, and simply provides for a way for `root` to
login over SSH.

We can then take the OVF that results from the initial build, and we can run
some additional provisioning to create our concept of a "base host" with Alpine
Linux:

```
ᐅ cd ../01-alpine-base
ᐅ packer build alpine-base.json
```

This build will configure `apk`, add a user for `vagrant`, disable root logins
over SSH, cleanup SSH keys and apk cache, etc.


Thanks to [maier](https://github.com/maier/), and
[higebu](https://github.com/higebu/packer-alpine) for prior art to base this
work on.
