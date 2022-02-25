# frozen_string_literal: true

require 'spec_helper'

describe 'fastx3::directories' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) { 'include fastx3' }

      it { is_expected.to compile }
    end
  end
end
