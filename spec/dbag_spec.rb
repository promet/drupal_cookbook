require 'spec_helper'

describe 'drupal::dbag' do
  let(:chef_run) do
    ChefSpec::Runner.new(:step_into => %w(drupal_site drupal_settings web_app)) do |node|
      node.set['drupal']['data_bag_items'] = %w(foo)
    end.converge described_recipe
  end
  before do
    stub_data_bag_item('drupal', 'foo').and_return(
      id: 'foo',
      doc_root: 'www',
      uri: 'foo.net',
      group: 'www-data',
      user: 'www-data',
      config: {
        databases: {
          default: {
            default: {
              database: 'fooDB',
              username: 'fooDBA',
              password: 'fooPASS',
            }
          }
        }
      }
    )
  end
  it 'creates settings conf dir' do
    expect(chef_run).to create_directory('/etc/drupals/foo.net').with(
      user: 'www-data',
      group: 'www-data',
      mode: 0750
    )
  end
  it 'puts globals.default.json in conf.d' do
    expect(chef_run).to create_directory '/etc/drupals/foo.net/globals.conf.d'
    expect(chef_run).to render_file('/etc/drupals/foo.net/globals.conf.d/globals.default.json').with_content(/"database": "fooDB"/)
  end
  it 'templates a vhost' do
    expect(chef_run).to render_file('/etc/apache2/sites-available/foo.net.conf').with_content('ServerName foo.net')
  end
end
