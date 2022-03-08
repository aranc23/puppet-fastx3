# fastx3

Install fastx3 (presumed to be available via an external repo, already
configured or previously installed) and configure the service.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with fastx3](#setup)
    * [What fastx3 affects](#what-fastx3-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with fastx3](#beginning-with-fastx3)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

If you need to configure www, broker, or system bookmarks settings for
fastx3 this module will do that.

## Setup

### What fastx3 affects

Installing the fastx-server package may cause other packages to be
installed.  This module will not adjust the firewall or install
certificates for the service.  It will enable and start the service
(by default.)

### Setup Requirements

None.

### Beginning with fastx3

It should install and start fastx, provided the package is available
using self-signed certs and creating some common system bookmarks
which may or may not work on any given system.  The module does not
try to determine which desktop environments are installed to create
bookmarks for.

## Usage

Since the module exposes most/all of the parameters in the www.json
and broker.json file in addition to debug options and system bookmarks
via class parameters it should be fairly obvious how to configure the
module to configure fastx.  System bookmarks are managed using a
custom type (fastx_system_bookmark) but there is a class parameter for
creating system bookmarks witih default values for common desktop
environments.

```
class { '::fastx3':
  admin_groups => ['root','unix-admins'],
}
```

## Reference

See [REFERENCE.md](REFERENCE.md]

## Limitations

There are a variety of configuration options stored in the JSONL
"database" format that this module does not know how to configure.
There are also some undocumented paramaters in the json configuration
files that will appear when editing options via the web interface.

This module will likely conflict with installs of FastX2 especially if
the same user name is used.  The service_user and service_group are
class parameters but changing them might not actually work.

## Development

Submit a pull request if you have useful changes.

