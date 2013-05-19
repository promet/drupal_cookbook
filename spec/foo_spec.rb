require 'spec_helper'

describe 'drupal::foo' do
  let(:chef_run) {
    runner = ChefSpec::ChefRunner.new(:step_into => ['drupal_site'])
    runner.converge 'drupal::foo'
  }
  it 'templates settings.php' do
    expect(chef_run).to create_file_with_content '/var/drupals/foo/sites/default/settings.php', 'globals_import();'
    file = chef_run.template('/var/drupals/foo/sites/default/settings.php')
    expect(file).to be_owned_by('vagrant', 'www-data')
  end
  it 'creates settings.conf.d' do
    expect(chef_run).to create_directory '/var/drupals/foo/sites/default/settings.conf.d'
  end
  it 'puts databases.json in conf.d' do
    expect(chef_run).to create_directory '/var/drupals/foo/sites/default/settings.conf.d/globals.conf.d'
    expect(chef_run).to create_file_with_content '/var/drupals/foo/sites/default/settings.conf.d/globals.conf.d/databases.json', '"database": "foo.net"'
  end
end
