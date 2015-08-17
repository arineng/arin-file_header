# file_header

#### Table of Contents

1. [Overview](#overview)
1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with file_header](#setup)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module grants the ability to easily manage and set a consistent header across
multiple types for files managed via Puppet

## Module Description

This module grants the ability to set a file header from default parameter(s)
set in the module, additionally you can set custom or overridge values in hiera.

## Setup

````
puppet module install arineng-file_header -i /path/to/modules
````

## Usage

This module can be used both with the default [file type](http://docs.puppetlabs.com/references/stable/type.html#file)

```puppet
define my_define {

    require file_header
    file {'/some/configuration/with/pound/comments':
        ensure => 'present',
        ...
        content => template("$file_header::pound_header", "other file contents")
    }
}
```

and with the [PuppetLabs Concat](https://github.com/puppetlabs/puppetlabs-concat) module

```puppet
define my_define {

  require file_header
  $concat_target_somefile_conf = "${somefile_destination}/conf/somefile.conf"

  concat { $concat_target_somefile_conf:
    ensure => present,
    owner  => 'root',
    group  => 'wheel',
    mode   => '0755',
  }

  include ::file_header
  concat::fragment { 'puppet_header':
    target  => $concat_target_somefile_conf,
    content => template("$::file_header::pound_header"),
    order   => '00',
  }

  concat::fragment { 'somefile.conf_main':
    target  => $concat_target_somefile_conf,
    content => template('somefile/somefile.conf.erb'),
    order   => '01',
  }

}
```

## Reference

The idea for this module spawned from [boundedinfinity/bi-puppet-banner](https://github.com/boundedinfinity/bi-puppet-banner),
but without the need for the [ripienaar/puppet-module-data](https://github.com/ripienaar/puppet-module-data) dependency.

## Limitations

This module was test with CentOS 6.x, current no limitations that that should prevent it from being used with other versions or OS's.
