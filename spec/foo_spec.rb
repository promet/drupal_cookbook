require 'chefspec'

describe 'drupal::foo' do
  let(:chef_run) {
    runner = ChefSpec::ChefRunner.new()
    runner.converge 'drupal::foo'
  }
  it 'templates settings.php' do
    # expect(chef_run).to create_file_with_content '/var/drupals/foo/sites/default/settings.php', 'Drupal site-specific configuration file.'
    # expect(chef_run).to create_file '/var/drupals/foo/sites/default/settings.php'
    file = chef_run.template('/var/drupals/foo/sites/default/settings.php')
    expect(file).to be_owned_by('vagrant', 'www-data')
  end
end
