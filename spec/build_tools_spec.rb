require 'chefspec'

describe 'drupal::build_tools' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'drupal::build_tools' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
