# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/fastx_motd'

RSpec.describe 'the fastx_motd type' do
  it 'loads' do
    expect(Puppet::Type.type(:fastx_motd)).not_to be_nil
  end
end
