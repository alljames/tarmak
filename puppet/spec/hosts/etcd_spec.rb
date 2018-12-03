require 'spec_helper'

describe 'role: etcd' do
  let(:facts) do
    {
      :tarmak_role               => 'etcd',
      :tarmak_hostname           => 'etcd-1',
      :tarmak_volume_id          => 'vol-XX',
      :etcd_backup_bucket_prefix => 'my-etcd-backup-bucket/prefix',
    }
  end

  it 'sets up docker' do
    is_expected.to contain_package('docker')
    is_expected.to contain_class('site_module::docker')
    is_expected.to contain_class('site_module::docker_config')
  end

  it 'sets up etcd tarmak' do
    is_expected.to contain_class('tarmak::etcd')
  end

  it 'sets up vault_client' do
    is_expected.to contain_class('vault_client').with_init_token('init-token1')
    is_expected.to contain_class('vault_client').with_init_role('cluster1-etcd')
    is_expected.to contain_class('vault_client').with_server_url('https://vault.domain-zone.root:8200')
    is_expected.to contain_class('vault_client').with_ca_cert_path('/etc/vault/ca.pem')
  end
end
