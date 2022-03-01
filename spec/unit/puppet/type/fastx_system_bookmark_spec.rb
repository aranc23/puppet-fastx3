# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/fastx_system_bookmark'

RSpec.describe 'the fastx_system_bookmark type' do
  it 'loads' do
    expect(Puppet::Type.type(:fastx_system_bookmark)).not_to be_nil
  end
end
