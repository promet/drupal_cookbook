@test "can install website" {
  cd /var/www/sites/foo.net/www && drush si -y
}
@test "can haz website" {
  cd /var/www/sites/foo.net/www && drush cc all
}
