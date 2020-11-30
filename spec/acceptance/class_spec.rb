# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'with default parameters ', if: ['debian', 'redhat', 'ubuntu'].include?(os[:family]) do
  pp = <<-PUPPETCODE
  class { 'example': }
PUPPETCODE

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe group('example') do
    it { is_expected.to exist }
  end

  describe user('example') do
    it { is_expected.to exist }
  end

  describe file('/opt/example') do
    it { is_expected.to be_directory }
  end

  describe file('/etc/example') do
    it { is_expected.to be_directory }
  end

  describe file('/etc/example/config') do
    it { is_expected.to be_file }
  end

  describe file('/opt/example/example') do
    it { is_expected.to be_file }
  end

  describe file('/var/example') do
    it { is_expected.to be_directory }
  end

  describe service('example') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running.under('systemd') }
  end

  describe port(9000) do
    it { is_expected.to be_listening }
  end
end
