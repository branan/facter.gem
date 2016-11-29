# Installation

On a modern linux distro with a new enough GCC, boost, etc you can
simply install Facter's dependencies and then run the following:

    rake gem
    gem install pkg/facter-3.5.gem

This is only confirmed to work on Ubuntu Xenial so far.

# Precompilation

If you do not have new enough dependencies on your platform, you'll
need to precompile Facter in a statically-linked form. This can be
done by installing pl-build-tools packages.

    yum install puppet-agent pl-gcc pl-binutils pl-boost pl-cmake pl-yaml-cpp
    export PATH=/opt/pl-build-tools/bin:/opt/puppetlabs/puppet/bin:$PATH
    gem install gem-compiler
    FACTER_CMAKE_OPTS='-DBOOST_STATIC=ON -DYAMLCPP_STATIC=ON -DLEATHERMAN_USE_CURL=FALSE -DWITHOUT_CURL=TRUE -DWITHOUT_OPENSSL=TRUE -DWITHOUT_BLKID=TRUE' gem compile facter-3.5.gem --verbose --no-abi-lock

This will create a `facter-3.5-<arch>-<os>.gem` file, which can then
be installed on other machines. You must still respect Facter's
minimum Ruby dependency of 1.9.3 when you install the gem.

# Bugs

* Precompilation does not bring along `facter.rb`, so facter cannot be
  required normally. You can get around this with `require
  'libfacter'`.
* Statically linking against curl requires zlib also be linked, but
  Facter has no facility to do this. Thus, when precompiling you must
  disable curl support. Curl is used for EC2 facts.
* We should not have copies of other codebases in this repo. Ideally,
  we can source our version numbers from the puppet-agent vanagon
  project.