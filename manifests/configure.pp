# @summary configures various fastx3 config files including license file
#
# Internal, not used directly.
class fastx3::configure {
  # configure the web server portion:
  file { $fastx3::www_json:
    owner   => $fastx3::service_user,
    group   => $fastx3::service_group,
    mode    => $fastx3::json_mode,
    content => '{}',
    replace => false,
  }
  -> augeas { 'fastx-www':
    lens    => 'Json.lns',
    incl    => $fastx3::www_json,
    changes => [
      "set dict/entry[.= 'required'] 'required'",
      "set dict/entry[.= 'required']/const ${fastx3::www_require_web_server}",
      "set dict/entry[.= 'host'] 'host'",
      "set dict/entry[.= 'host']/string '${fastx3::www_host}'",
      "set dict/entry[.= 'port'] 'port'",
      "set dict/entry[.= 'port']/number ${fastx3::www_port}",
      "set dict/entry[.= 'cert_file'] 'cert_file'",
      "set dict/entry[.= 'cert_file']/string '${fastx3::cert_file}'",
      "set dict/entry[.= 'ca_file'] 'ca_file'",
      "set dict/entry[.= 'ca_file']/string '${fastx3::ca_file}'",
      "set dict/entry[.= 'key_file'] 'key_file'",
      "set dict/entry[.= 'key_file']/string '${fastx3::key_file}'",
      "set dict/entry[.= 'pfx_file'] 'pfx_file'",
      "set dict/entry[.= 'pfx_file']/string '${fastx3::pfx_file}'",
    ],
  }
  file { $fastx3::broker_json:
    ensure  => $fastx3::broker_json_ensure,
    owner   => $fastx3::service_user,
    group   => $fastx3::service_group,
    mode    => $fastx3::json_mode,
    content => '{}',
    replace => $fastx3::broker_json_ensure ? {
      'present' => false,
      'absent'  => true,
    },
  }
  # only manage the contents if we are managing the file
  if $fastx3::broker_json_ensure == 'present' {
    augeas { 'fastx-broker':
      require => File[$fastx3::broker_json],
      lens    => 'Json.lns',
      incl    => $fastx3::broker_json,
      changes => [
        "set dict/entry[.= 'namespace'] 'namespace'",
        "set dict/entry[.= 'namespace']/string ${fastx3::broker_namespace}",
        "set dict/entry[.= 'transporterType'] 'transporterType'",
        "set dict/entry[.= 'transporterType']/string '${fastx3::broker_transporter_type}'",
        "set dict/entry[.= 'password'] 'password'",
        "set dict/entry[.= 'password']/string '${fastx3::broker_password}'",
        "set dict/entry[.= 'host'] 'host'",
        "set dict/entry[.= 'host']/string '${fastx3::broker_host}'",
        "set dict/entry[.= 'port'] 'port'",
        "set dict/entry[.= 'port']/number ${fastx3::broker_port}",
        "set dict/entry[.= 'rejectUnauthorized'] 'rejectUnauthorized'",
        "set dict/entry[.= 'rejectUnauthorized']/const ${fastx3::broker_reject_unauthorized}",
      ],
    }
  }
  if $fastx3::manage_debug_options {
    file { $fastx3::debug_json:
      owner   => $fastx3::service_user,
      group   => $fastx3::service_group,
      mode    => $fastx3::json_mode,
      content => '{}',
      replace => false,
    }
    $fastx3::debug_options.each |String $opt, Boolean $val| {
      augeas { "fastx-debug-${opt}":
      require   => File[$fastx3::debug_json],
        lens    => 'Json.lns',
        incl    => $fastx3::debug_json,
        changes => [
          "set dict/entry[.= '${opt}'] '${opt}'",
          "set dict/entry[.= '${opt}']/const ${val}",
        ],
      }
    }
  }
  if $fastx3::allow_logins and $fastx3::allow_start {
    $settings_disable = ['logins','start']
  }
  elsif ! $fastx3::allow_logins and $fastx3::allow_start {
    $settings_disable = ['start']
  }
  elsif $fastx3::allow_logins and ! $fastx3::allow_start {
    $settings_disable = ['logins']
  }
  else {
    $settings_disable = []
  }

  case $fastx3::sudo_user_options {
    'Disable': {
      $enable_remote_sudo = false
      $disable_sudo = true
    }
    'Enable': {
      $enable_remote_sudo = false
      $disable_sudo = false
    }
    'Advertise': {
      $enable_remote_sudo = true
      $disable_sudo = false
    }
  }
  file { $fastx3::settings_json:
    owner   => $fastx3::service_user,
    group   => $fastx3::service_group,
    mode    => $fastx3::json_mode,
    content => '{}',
    replace => false,
  }
  -> augeas { 'fastx-settings':
    lens    => 'Json.lns',
    incl    => $fastx3::settings_json,
    changes => [
      "set dict/entry[.= 'hostname'] 'hostname'",
      "set dict/entry[.= 'hostname']/string '${fastx3::override_hostname}'",
      "set dict/entry[.= 'enableReservations'] 'enableReservations'",
      "set dict/entry[.= 'enableReservations']/const ${fastx3::enable_server_reservations}",
      "set dict/entry[.= 'sshport'] 'sshport'",
      "set dict/entry[.= 'sshport']/number ${fastx3::sshport}",
      "set dict/entry[.= 'forceIndirect'] 'forceIndirect'",
      "set dict/entry[.= 'forceIndirect']/const ${fastx3::force_indirect}",
      "set dict/entry[.= 'requireValidCertificates'] 'requireValidCertificates'",
      "set dict/entry[.= 'requireValidCertificates']/const ${fastx3::require_valid_certificates}",
      "set dict/entry[.= 'enableRemoteSudo'] 'enableRemoteSudo'",
      "set dict/entry[.= 'enableRemoteSudo']/const ${enable_remote_sudo}",
      "set dict/entry[.= 'disableSudo'] 'disableSudo'",
      "set dict/entry[.= 'disableSudo']/const ${disable_sudo}",
    ],
  }
  if $fastx3::allow_logins {
    augeas { 'fastx-settings-allow-logins':
      lens    => 'Json.lns',
      incl    => $fastx3::settings_json,
      changes => [
        "rm dict/entry[.= 'disable']/array/string[.= 'login']",
      ],
    }
  }
  else {
    # disable logins
    augeas { 'fastx-settings-allow-logins':
      lens    => 'Json.lns',
      incl    => $fastx3::settings_json,
      changes => [
        "set dict/entry[.= 'disable'] 'disable'",
        "set dict/entry[.= 'disable']/array/string[last()+1] 'login'",
      ],
      onlyif  => "match dict/entry[.= 'disable']/array/string[.= 'login'] size == 0",
    }
  }
  if $fastx3::allow_start {
    augeas { 'fastx-settings-allow-start':
      lens    => 'Json.lns',
      incl    => $fastx3::settings_json,
      changes => [
        "rm dict/entry[.= 'disable']/array/string[.= 'start']",
      ],
    }
  }
  else {
    # disable start
    augeas { 'fastx-settings-allow-start':
      lens    => 'Json.lns',
      incl    => $fastx3::settings_json,
      changes => [
        "set dict/entry[.= 'disable'] 'disable'",
        "set dict/entry[.= 'disable']/array/string[last()+1] 'start'",
      ],
      onlyif  => "match dict/entry[.= 'disable']/array/string[.= 'start'] size == 0",
    }
  }

  # install license file:
  if $fastx3::license_server =~ Stdlib::Fqdn {
    file { $fastx3::license_file:
      owner   => $fastx3::service_user,
      group   => $fastx3::service_group,
      mode    => '0644',
      content => "HOST ${fastx3::license_server} 00000000 5053\n",
    }
  }
  file { $fastx3::storedir:
    ensure => 'directory',
    owner  => $fastx3::service_user,
    group  => $fastx3::service_group,
    mode   => '0755',
  }
  file { [$fastx3::system_bookmark_store,$fastx3::config_store]:
    owner   => $fastx3::service_user,
    group   => $fastx3::service_group,
    mode    => $fastx3::json_mode,
    content => '',
    replace => false,
  }
  create_resources(
    'fastx_system_bookmark',
    $fastx3::system_bookmarks,
    { require => File[$fastx3::system_bookmark_store] }
  )
}
