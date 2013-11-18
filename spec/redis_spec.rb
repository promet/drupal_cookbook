require 'spec_helper'

describe 'drupal::redis' do
  let(:chef_run) {
    runner = ChefSpec::Runner.new(:step_into => ['drupal_shared_module', 'drupal_drush'])
    runner.converge described_recipe
  }

  it 'creates the shared modules dir' do
    expect(chef_run).to create_directory(chef_run.node.drupal.shared_dir)
  end

  it 'installs the pecl redis extension' do
    expect(chef_run).to install_php_pear('redis')
  end

  it 'executes drush dl' do
    expect(chef_run).to run_execute("drush dl -y --destination=#{chef_run.node.drupal.shared_dir} redis").with(user: 'root')
  end
end
