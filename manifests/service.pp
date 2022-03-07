# @summary reset the local admins list on changes and manage the service
#
# Internal, not used directly.
class fastx3::service {
  $admins = join($::fastx3::admin_groups, ' ')
  exec { "/usr/lib/fastx/3/tools/reset-admin ${admins}":
    user        => 'root',
    refreshonly => true,
  }
  service { $fastx3::services:
    ensure => $fastx3::service_ensure,
    enable => $fastx3::service_enabled,
  }
}
