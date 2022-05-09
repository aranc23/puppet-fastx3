# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/fastx_config'

RSpec.describe 'the fastx_config type' do
  it 'loads' do
    expect(Puppet::Type.type(:fastx_config)).not_to be_nil
  end
end
