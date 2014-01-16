require 'spec_helper'

describe 'drupal::node_sites' do
  let(:chef_run) do
    ChefSpec::Runner.new(:step_into => %w(drupal_site web_app)) do |node|
      node.set['drupal']['sites']['foo.net'] = {
        'doc_root' => 'www',
        'root' => '/var/drupals/foo',
        'config' => {
          'databases' => {
            'default' => {
              'default' => {
                'database' => 'fooDB',
                'username' => 'fooDBA',
                'password' => 'fooPASS',
              }
            }
          }
        }
      }
    end.converge described_recipe
  end
  it 'templates settings.php' do
    expect(chef_run).to render_file('/var/drupals/foo/www/sites/default/settings.php').with_content('globals_import($globals_conf_d);')
  end
  it 'creates settings conf dir' do
    expect(chef_run).to create_directory '/etc/drupals/foo.net'
  end
  it 'puts databases.json in conf.d' do
    expect(chef_run).to create_directory '/etc/drupals/foo.net/globals.conf.d'
    expect(chef_run).to render_file('/etc/drupals/foo.net/globals.conf.d/globals.default.json').with_content(/"database":"fooDB"/)
  end
  it 'templates a vhost' do
    expect(chef_run).to render_file('/etc/apache2/sites-available/foo.net.conf').with_content('ServerName foo.net')
  end
end
