require 'spec_helper'
describe 'example' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('example') }
        it { is_expected.to contain_class('example::install').that_comes_before('Class[example::Config]') }
        it { is_expected.to contain_class('example::config').that_notifies('Class[example::Service]') }
        it { is_expected.to contain_class('example::service') }
        it { is_expected.to contain_group('example') }
        it { is_expected.to contain_package('example') }
        it { is_expected.to contain_service('example') }
        it { is_expected.to contain_user('example') }
      end
    end
  end
end
