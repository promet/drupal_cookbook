define :drush, :drush_bin => '/usr/local/bin' do

  drush_version   = params[:version] ? params[:version] : nil
  drush_version   ||= params[:name]

  # allow both stupid drupal version numbers and good semver numbers
  version_parts = drush_version.split('-').pop.split('.')
  version_parts += [0] * (3 - version_parts.size) if version_parts.size < 3
  drush_version = version_parts.join('.')
  drush_uri     = 'https://github.com/drush-ops/drush/archive'
  include_recipe 'ark'
  ark 'drush' do
    action :install
    url "#{drush_uri}/#{drush_version}.tar.gz"
    has_binaries ['drush']
    version drush_version
  end

  # This is a stupid kludge for drush 'just failing' the first time.
  execute 'drush'
end
