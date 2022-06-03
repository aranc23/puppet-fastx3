# @summary install and configure the fastx3.2 server package
#
# Install and configure the fastx3.2 server package along with
# required certs and firewall configuration as needed
#
# @param packages
#   list of packages to install
# @param services
#   list of services to start after installation and configuration
# @param service_ensure
#   ensure named services are running or stopped
# @param service_enabled
#   enable services or not
# @param www_port
#   listen on this port (https only)
# @param www_host
#   bind to this ip/hostname
# @param www_require_web_server
#   require the web server to be running to allow ssh logins
# @param installdir
#   main installation directory
# @param vardir
#   fastx3 /var directory
# @param configdir
#   fastx3 /etc directory
# @param licensedir
#   directory in which to place license file
# @param license_file
#   full path to license file
# @param localdir
#   locaal dir is used for local configuration
# @param certsdir
#   directory in which to place certs
# @param json_mode
#   use this mode for json config files
# @param www_json
#   full path to www.json config file
# @param settings_json
#   full path to settings.json file
# @param broker_json
#   full path to broker.json file used to configure cluster membership
# @param db_json
#   full path to db.json file used to configure cluster database
# @param service_user
#   user services run as, used to create/modify directory permissions
# @param service_group
#   group of service user, used to create/modify directory permissions
# @param admin_groups
#   list of groups to grant admin access to
# @param license_server
#   hostname of license server, used to create license file, if set
# @param fqdn
#   fqdn of service, used to configure services and certs
# @param cert_file
#   name of cert file to create
# @param ca_file
#   name of key file to create
# @param key_file
#   name of key file to create
# @param pfx_file
#   name of the pfx file to configure in www.json
# @param broker_json_ensure
#   create or remove the broker configuration
# @param broker_configuration
#   write this data structure to broker_json
# @param db_configuration
#   write this data structure to db_json
# @param manage_debug_options
#   should this module manage the debug.json file
# @param debug_json
#   path to debug.json file
# @param debug_options
#   hash of string => boolean mappings for setting debug options in debug.json
# @param override_hostname
#   referred to as "Override Hostname" in settings tab but actually
#   sets the hostname param in settings.json
# @param allow_logins
#   called "Enable logins on this server" in settings tab, but
#   actually adds "logins" to the disable section of settings.json
#   when unchecked
# @param allow_start
#   called Start new sessions on this server" in settings tab, but
#   actually adds "start" to the disable section of settings.json when
#   unchecked
# @param enable_server_reservations
#   from the hover text:
#   Enforces a one user per server policy. When a user begins the
#   authentication process, a server is selected. The user is added to
#   the authenticating list. Once the user has logged in, the user
#   checks if he is in the authenticating list. Then the list is
#   cleared. Authentication will fail for all other users.
# @param sshport
#   which port to connect to for logins
# @param force_indirect
#   called "Disable Direct Cluster Connections" in settings
# @param require_valid_certificates
#   called "Require Valid Cluster Certificates" in settings
# @param sudo_user_options
#   hover text from settings page: "Choose how the server will use sudo users"
# @param storedir
#   directory containing json database files
# @param system_bookmark_store
#   file to store system wide bookmarks in
# @param config_store
#   file to store configuration parameters created with fastx_config resources
# @param system_bookmarks
#   create these bookmarks
# @param manage_repos
#   manage repos as specified in yum_repos
# @param yumrepos
#   hash of yumrepo resources for creating/deleting/modifiying, if manage_repos is true
# @example
#   include fastx3
class fastx3
(
  Array[String] $packages,
  Array[String] $services,
  Variant[Enum['running','stopped'],Undef] $service_ensure = running,
  Boolean $service_enabled = true,
  Integer $www_port = 3300,
  Variant[Stdlib::Fqdn,Stdlib::Host,Enum['']] $www_host = '',
  Boolean $www_require_web_server = true,
  Stdlib::Absolutepath $installdir,
  # the following are all based on installdir above
  Stdlib::Absolutepath $vardir,
  Stdlib::Absolutepath $configdir,
  Stdlib::Absolutepath $licensedir   = "${fastx3::vardir}/license",
  Stdlib::Absolutepath $license_file = "${fastx3::licensedir}/license_server.lic",
  Stdlib::Absolutepath $localdir     = "${fastx3::vardir}/local",
  Stdlib::Absolutepath $certsdir     = "${fastx3::localdir}/certs",
  Stdlib::Filemode $json_mode = '0644',
  Stdlib::Absolutepath $www_json     = "${fastx3::configdir}/www.json",
  Stdlib::Absolutepath $settings_json = "${fastx3::configdir}/settings.json",
  Stdlib::Absolutepath $broker_json = "${fastx3::configdir}/broker.json",
  Stdlib::Absolutepath $db_json = "${fastx3::configdir}/db.json",
  String $service_user = 'fastx',
  String $service_group = 'fastx',
  Array[String] $admin_groups = ['root'],
  # license server
  Optional[Stdlib::Fqdn] $license_server = undef,
  # options related to the certificates used
  Stdlib::Fqdn $fqdn = $::fqdn,
  String $cert_file = '',
  String $ca_file = '',
  String $key_file = '',
  String $pfx_file = '',
  Enum['present','absent'] $broker_json_ensure = 'absent',
  Enum['present','absent'] $db_json_ensure = 'absent',
  Hash $broker_configuration = {},
  Hash $db_configuration = {},
  Boolean $manage_debug_options = false,
  Stdlib::Absolutepath $debug_json = "${fastx3::configdir}/debug.json",
  Optional[Hash[String,Boolean]] $debug_options = {},
  Variant[Stdlib::Fqdn,Enum['']] $override_hostname = '',
  Boolean $allow_logins = true,
  Boolean $allow_start = true,
  Boolean $enable_server_reservations = false,
  Integer $sshport = 22,
  Boolean $force_indirect = false,
  Boolean $require_valid_certificates = false,
  Enum['Advertise','Enable','Disable'] $sudo_user_options = 'Disable',
  Stdlib::AbsolutePath $storedir = "${fastx3::localdir}/store",
  Stdlib::AbsolutePath $system_bookmark_store = "${fastx3::storedir}/system-bookmark-store.db",
  Stdlib::AbsolutePath $config_store = "${fastx3::storedir}/config-store.db",
  Hash $system_bookmarks = {},
  Boolean $manage_repos = true,
  Hash $yumrepos = {},
)
{
  include ::stdlib
  contain fastx3::repos
  contain fastx3::install
  contain fastx3::users
  contain fastx3::directories
  contain fastx3::configure
  contain fastx3::service
  Class['::fastx3::repos']
  -> Class['::fastx3::install']
  -> Class['::fastx3::users']
  -> Class['::fastx3::directories']
  -> Class['::fastx3::configure']
  ~> Class['::fastx3::service']
}
