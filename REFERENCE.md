# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`fastx3`](#fastx3): install and configure the fastx3.2 server package
* [`fastx3::configure`](#fastx3configure): configures various fastx3 config files including license file
* [`fastx3::directories`](#fastx3directories): manage directory permissions, fix version link if needed
* [`fastx3::install`](#fastx3install): install fastx3 packages
* [`fastx3::repos`](#fastx3repos): create yum repositories, if configured
* [`fastx3::service`](#fastx3service): reset the local admins list on changes and manage the service
* [`fastx3::users`](#fastx3users): manage fastx3 service user and group

### Resource types

* [`fastx_config`](#fastx_config): a fastx_config type
* [`fastx_system_bookmark`](#fastx_system_bookmark): a fastx_system_bookmark type

## Classes

### <a name="fastx3"></a>`fastx3`

Install and configure the fastx3.2 server package along with
required certs and firewall configuration as needed

#### Examples

##### 

```puppet
include fastx3
```

#### Parameters

The following parameters are available in the `fastx3` class:

* [`packages`](#packages)
* [`services`](#services)
* [`service_ensure`](#service_ensure)
* [`service_enabled`](#service_enabled)
* [`www_port`](#www_port)
* [`www_host`](#www_host)
* [`www_require_web_server`](#www_require_web_server)
* [`installdir`](#installdir)
* [`vardir`](#vardir)
* [`configdir`](#configdir)
* [`licensedir`](#licensedir)
* [`license_file`](#license_file)
* [`localdir`](#localdir)
* [`certsdir`](#certsdir)
* [`json_mode`](#json_mode)
* [`www_json`](#www_json)
* [`settings_json`](#settings_json)
* [`broker_json`](#broker_json)
* [`db_json`](#db_json)
* [`service_user`](#service_user)
* [`service_group`](#service_group)
* [`admin_groups`](#admin_groups)
* [`license_server`](#license_server)
* [`fqdn`](#fqdn)
* [`cert_file`](#cert_file)
* [`ca_file`](#ca_file)
* [`key_file`](#key_file)
* [`pfx_file`](#pfx_file)
* [`broker_json_ensure`](#broker_json_ensure)
* [`broker_configuration`](#broker_configuration)
* [`db_configuration`](#db_configuration)
* [`manage_debug_options`](#manage_debug_options)
* [`debug_json`](#debug_json)
* [`debug_options`](#debug_options)
* [`override_hostname`](#override_hostname)
* [`allow_logins`](#allow_logins)
* [`allow_start`](#allow_start)
* [`enable_server_reservations`](#enable_server_reservations)
* [`sshport`](#sshport)
* [`force_indirect`](#force_indirect)
* [`require_valid_certificates`](#require_valid_certificates)
* [`sudo_user_options`](#sudo_user_options)
* [`storedir`](#storedir)
* [`system_bookmark_store`](#system_bookmark_store)
* [`config_store`](#config_store)
* [`system_bookmarks`](#system_bookmarks)
* [`manage_repos`](#manage_repos)
* [`yumrepos`](#yumrepos)
* [`db_json_ensure`](#db_json_ensure)

##### <a name="packages"></a>`packages`

Data type: `Array[String]`

list of packages to install

##### <a name="services"></a>`services`

Data type: `Array[String]`

list of services to start after installation and configuration

##### <a name="service_ensure"></a>`service_ensure`

Data type: `Variant[Enum['running','stopped'],Undef]`

ensure named services are running or stopped

Default value: `running`

##### <a name="service_enabled"></a>`service_enabled`

Data type: `Boolean`

enable services or not

Default value: ``true``

##### <a name="www_port"></a>`www_port`

Data type: `Integer`

listen on this port (https only)

Default value: `3300`

##### <a name="www_host"></a>`www_host`

Data type: `Variant[Stdlib::Fqdn,Stdlib::Host,Enum['']]`

bind to this ip/hostname

Default value: `''`

##### <a name="www_require_web_server"></a>`www_require_web_server`

Data type: `Boolean`

require the web server to be running to allow ssh logins

Default value: ``true``

##### <a name="installdir"></a>`installdir`

Data type: `Stdlib::Absolutepath`

main installation directory

##### <a name="vardir"></a>`vardir`

Data type: `Stdlib::Absolutepath`

fastx3 /var directory

##### <a name="configdir"></a>`configdir`

Data type: `Stdlib::Absolutepath`

fastx3 /etc directory

##### <a name="licensedir"></a>`licensedir`

Data type: `Stdlib::Absolutepath`

directory in which to place license file

Default value: `"${fastx3::vardir}/license"`

##### <a name="license_file"></a>`license_file`

Data type: `Stdlib::Absolutepath`

full path to license file

Default value: `"${fastx3::licensedir}/license_server.lic"`

##### <a name="localdir"></a>`localdir`

Data type: `Stdlib::Absolutepath`

locaal dir is used for local configuration

Default value: `"${fastx3::vardir}/local"`

##### <a name="certsdir"></a>`certsdir`

Data type: `Stdlib::Absolutepath`

directory in which to place certs

Default value: `"${fastx3::localdir}/certs"`

##### <a name="json_mode"></a>`json_mode`

Data type: `Stdlib::Filemode`

use this mode for json config files

Default value: `'0644'`

##### <a name="www_json"></a>`www_json`

Data type: `Stdlib::Absolutepath`

full path to www.json config file

Default value: `"${fastx3::configdir}/www.json"`

##### <a name="settings_json"></a>`settings_json`

Data type: `Stdlib::Absolutepath`

full path to settings.json file

Default value: `"${fastx3::configdir}/settings.json"`

##### <a name="broker_json"></a>`broker_json`

Data type: `Stdlib::Absolutepath`

full path to broker.json file used to configure cluster membership

Default value: `"${fastx3::configdir}/broker.json"`

##### <a name="db_json"></a>`db_json`

Data type: `Stdlib::Absolutepath`

full path to db.json file used to configure cluster database

Default value: `"${fastx3::configdir}/db.json"`

##### <a name="service_user"></a>`service_user`

Data type: `String`

user services run as, used to create/modify directory permissions

Default value: `'fastx'`

##### <a name="service_group"></a>`service_group`

Data type: `String`

group of service user, used to create/modify directory permissions

Default value: `'fastx'`

##### <a name="admin_groups"></a>`admin_groups`

Data type: `Array[String]`

list of groups to grant admin access to

Default value: `['root']`

##### <a name="license_server"></a>`license_server`

Data type: `Optional[Stdlib::Fqdn]`

hostname of license server, used to create license file, if set

Default value: ``undef``

##### <a name="fqdn"></a>`fqdn`

Data type: `Stdlib::Fqdn`

fqdn of service, used to configure services and certs

Default value: `$::fqdn`

##### <a name="cert_file"></a>`cert_file`

Data type: `String`

name of cert file to create

Default value: `''`

##### <a name="ca_file"></a>`ca_file`

Data type: `String`

name of key file to create

Default value: `''`

##### <a name="key_file"></a>`key_file`

Data type: `String`

name of key file to create

Default value: `''`

##### <a name="pfx_file"></a>`pfx_file`

Data type: `String`

name of the pfx file to configure in www.json

Default value: `''`

##### <a name="broker_json_ensure"></a>`broker_json_ensure`

Data type: `Enum['present','absent']`

create or remove the broker configuration

Default value: `'absent'`

##### <a name="broker_configuration"></a>`broker_configuration`

Data type: `Hash`

write this data structure to broker_json

Default value: `{}`

##### <a name="db_configuration"></a>`db_configuration`

Data type: `Hash`

write this data structure to db_json

Default value: `{}`

##### <a name="manage_debug_options"></a>`manage_debug_options`

Data type: `Boolean`

should this module manage the debug.json file

Default value: ``false``

##### <a name="debug_json"></a>`debug_json`

Data type: `Stdlib::Absolutepath`

path to debug.json file

Default value: `"${fastx3::configdir}/debug.json"`

##### <a name="debug_options"></a>`debug_options`

Data type: `Optional[Hash[String,Boolean]]`

hash of string => boolean mappings for setting debug options in debug.json

Default value: `{}`

##### <a name="override_hostname"></a>`override_hostname`

Data type: `Variant[Stdlib::Fqdn,Enum['']]`

referred to as "Override Hostname" in settings tab but actually
sets the hostname param in settings.json

Default value: `''`

##### <a name="allow_logins"></a>`allow_logins`

Data type: `Boolean`

called "Enable logins on this server" in settings tab, but
actually adds "logins" to the disable section of settings.json
when unchecked

Default value: ``true``

##### <a name="allow_start"></a>`allow_start`

Data type: `Boolean`

called Start new sessions on this server" in settings tab, but
actually adds "start" to the disable section of settings.json when
unchecked

Default value: ``true``

##### <a name="enable_server_reservations"></a>`enable_server_reservations`

Data type: `Boolean`

from the hover text:
Enforces a one user per server policy. When a user begins the
authentication process, a server is selected. The user is added to
the authenticating list. Once the user has logged in, the user
checks if he is in the authenticating list. Then the list is
cleared. Authentication will fail for all other users.

Default value: ``false``

##### <a name="sshport"></a>`sshport`

Data type: `Integer`

which port to connect to for logins

Default value: `22`

##### <a name="force_indirect"></a>`force_indirect`

Data type: `Boolean`

called "Disable Direct Cluster Connections" in settings

Default value: ``false``

##### <a name="require_valid_certificates"></a>`require_valid_certificates`

Data type: `Boolean`

called "Require Valid Cluster Certificates" in settings

Default value: ``false``

##### <a name="sudo_user_options"></a>`sudo_user_options`

Data type: `Enum['Advertise','Enable','Disable']`

hover text from settings page: "Choose how the server will use sudo users"

Default value: `'Disable'`

##### <a name="storedir"></a>`storedir`

Data type: `Stdlib::AbsolutePath`

directory containing json database files

Default value: `"${fastx3::localdir}/store"`

##### <a name="system_bookmark_store"></a>`system_bookmark_store`

Data type: `Stdlib::AbsolutePath`

file to store system wide bookmarks in

Default value: `"${fastx3::storedir}/system-bookmark-store.db"`

##### <a name="config_store"></a>`config_store`

Data type: `Stdlib::AbsolutePath`

file to store configuration parameters created with fastx_config resources

Default value: `"${fastx3::storedir}/config-store.db"`

##### <a name="system_bookmarks"></a>`system_bookmarks`

Data type: `Hash`

create these bookmarks

Default value: `{}`

##### <a name="manage_repos"></a>`manage_repos`

Data type: `Boolean`

manage repos as specified in yum_repos

Default value: ``true``

##### <a name="yumrepos"></a>`yumrepos`

Data type: `Hash`

hash of yumrepo resources for creating/deleting/modifiying, if manage_repos is true

Default value: `{}`

##### <a name="db_json_ensure"></a>`db_json_ensure`

Data type: `Enum['present','absent']`



Default value: `'absent'`

### <a name="fastx3configure"></a>`fastx3::configure`

Internal, not used directly.

### <a name="fastx3directories"></a>`fastx3::directories`

Internal, not used directly.

### <a name="fastx3install"></a>`fastx3::install`

Internal, not used directly.

### <a name="fastx3repos"></a>`fastx3::repos`

Internal, not used directly.

### <a name="fastx3service"></a>`fastx3::service`

Internal, not used directly.

### <a name="fastx3users"></a>`fastx3::users`

Internal, not used directly.

## Resource types

### <a name="fastx_config"></a>`fastx_config`

fastx_config { 'motd':
  ensure => 'present',
  data   => { 'motd' => "no service available" },
}

This type provides Puppet with the capabilities to manage ...

If your type uses autorequires, please document as shown below, else delete
these lines.
**Autorequires**:
* `Package[foo]`

#### Properties

The following properties are available in the `fastx_config` type.

##### `data`

Data type: `Hash`

Place into the data portion of the json hash, see the fastx documenation for details or examples in the data directory.

##### `ensure`

Data type: `Enum[present, absent]`

Whether this resource should be present or absent on the target system.

Default value: `present`

#### Parameters

The following parameters are available in the `fastx_config` type.

* [`name`](#name)

##### <a name="name"></a>`name`

namevar

Data type: `String`

The name of the resource you want to manage, used as the _id in the db.

### <a name="fastx_system_bookmark"></a>`fastx_system_bookmark`

fastx_system_bookmark { 'xterm':
  ensure => 'present',
  data   => { 'command' => 'xterm -ls', name => 'xterm' },
}

This type provides Puppet with the capabilities to manage local system bookmarks stored in system-bookmark-store.db

#### Properties

The following properties are available in the `fastx_system_bookmark` type.

##### `data`

Data type: `Hash`

Place into the data portion of the json hash, see the fastx documenation for details or examples in the data directory.

##### `ensure`

Data type: `Enum[present, absent]`

Whether this resource should be present or absent on the target system.

Default value: `present`

#### Parameters

The following parameters are available in the `fastx_system_bookmark` type.

* [`name`](#name)

##### <a name="name"></a>`name`

namevar

Data type: `String`

The name of the resource you want to manage, used as the _id in the db.

