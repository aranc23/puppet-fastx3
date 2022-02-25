# @summary create directories for use later
#
# A description of what this class does
#
# @example
#   include fastx3::configure
class fastx3::directories {
  # directories:
  file { "${fastx3::installdir}/latest":
    ensure => link,
    target => "3",
  }
  file { [$fastx3::vardir,$fastx3::certsdir,$fastx3::licensedir,$fastx3::localdir,$fastx3::configdir]:
    ensure => directory,
    owner  => $fastx3::service_user,
    group  => $fastx3::service_group,
    mode   => '0755',
  }
}
