# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'fastx_config',
  docs: <<-EOS,
@summary a fastx_config type
@example
fastx_config { 'motd':
  ensure => 'present',
  data   => { 'motd' => "no service available" },
}

This type provides Puppet with the capabilities to manage ...

If your type uses autorequires, please document as shown below, else delete
these lines.
**Autorequires**:
* `Package[foo]`
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
