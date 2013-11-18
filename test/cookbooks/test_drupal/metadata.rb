name             'test_drupal'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures test_drupal'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "build-essential"
depends "drupal"
depends "database"
depends "ark"
depends "chef-solo-search"
