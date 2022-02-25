# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fastx3
class fastx3::users {
  group { $fastx3::service_group: ensure => present }
  -> user { $fastx3::service_user:
    system  => true,
    shell   => '/sbin/nologin',
    gid     => $fastx3::service_group,
    home    => $fastx3::vardir,
  }
}
