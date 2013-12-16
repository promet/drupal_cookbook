@test "install drupal" {
  cd /var/www/sites/foobar.baz && drush si -y
  cd /var/www/sites/foobar.baz && drush cc all
  cd /var/www/sites/foobar.baz && drush dl views
  cd /var/www/sites/foobar.baz && drush en -y views
}
