require 'spec_helper'

describe 'drupal::mass_virtual' do
  let(:chef_run) do
    ChefSpec::Runner.new(:step_into => %w(web_app)) do |node|
      node.set['drupal']['data_bag_items'] = %w(foo)
    end.converge described_recipe
  end
  it 'templates a vhost' do
    expect(chef_run).to render_file('/etc/apache2/sites-available/mass_virtual.conf').with_content("VirtualDocumentRoot /var/www/sites")
  end
end
