# @summary reset the local admins list on changes and manage the service
#
# Internal, not used directly.
class fastx3::service {
  service { $fastx3::services:
    ensure => $fastx3::service_ensure,
    enable => $fastx3::service_enabled,
  }
}
