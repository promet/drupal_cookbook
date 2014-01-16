@test "install drupal" {
  cd /var/www/sites/foobar.baz/www && drush si -y
  cd /var/www/sites/foobar.baz/www && drush cc all
  cd /var/www/sites/foobar.baz/www && drush dl views
  cd /var/www/sites/foobar.baz/www && drush en -y views
}
