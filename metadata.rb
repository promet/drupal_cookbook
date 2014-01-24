name             'drupal'
maintainer       'Will Milton'
maintainer_email 'wa.milton@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures some drupal projects'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.2'

depends 'ark'
depends 'hostsfile'
depends 'php'
depends 'apache2'
