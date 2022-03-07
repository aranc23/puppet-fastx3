# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'fastx_system_bookmark',
  docs: <<-EOS,
@summary a fastx_system_bookmark type
@example
fastx_system_bookmark { 'xterm':
  ensure => 'present',
  data   => { 'command' => 'xterm -ls', name => 'xterm' },
}

This type provides Puppet with the capabilities to manage local system bookmarks stored in system-bookmark-store.db

EOS
  features: [],
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    name: {
      type: 'String',
      desc: 'The name of the resource you want to manage, used as the _id in the db.',
      behaviour: :namevar,
    },
    data: {
      type: 'Hash',
      desc: 'Place into the data portion of the json hash, see the fastx documenation for details or examples in the data directory.',
      default: nil,
    },
  },
)
