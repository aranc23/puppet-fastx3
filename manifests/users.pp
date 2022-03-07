# @summary manage fastx3 service user and group
#
# Internal, not used directly.
class fastx3::users {
  group { $fastx3::service_group: ensure => present }
  -> user { $fastx3::service_user:
    system  => true,
    shell   => '/sbin/nologin',
    gid     => $fastx3::service_group,
    home    => $fastx3::vardir,
  }
}
