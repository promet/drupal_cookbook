require 'spec_helper'

describe 'drupal::foo' do
  let(:chef_run) {
    runner = ChefSpec::ChefRunner.new(:step_into => ['drupal_site', 'web_app'])
    runner.converge 'drupal::foo'
  }
  it 'templates settings.php' do
    expect(chef_run).to create_file_with_content '/var/drupals/foo/sites/default/settings.php', 'globals_import($globals_conf_d);'
  end
  it 'creates settings.conf.d' do
    expect(chef_run).to create_directory '/var/drupals/foo/sites/default/settings.conf.d'
  end
  it 'puts databases.json in conf.d' do
    expect(chef_run).to create_directory '/var/drupals/foo/sites/default/settings.conf.d/globals.conf.d'
    expect(chef_run).to create_file_with_content '/var/drupals/foo/sites/default/settings.conf.d/globals.conf.d/databases.json', '"database": "fooDB"'
  end
  it 'templates a vhost' do
    expect(chef_run).to create_file_with_content '/etc/apache2/sites-available/foo.net.conf', 'ServerName foo.net'
  end
end
