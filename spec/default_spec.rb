require 'chefspec'

describe 'drupal::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'drupal::default' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
