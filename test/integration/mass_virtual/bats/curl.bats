@test "we do better than 404" {
  [[ `curl -o /dev/null -w %{http_code} foobar.baz` -ne 404 ]]
  [[ `curl -o /dev/null -w %{http_code} foobar.baz/index.php` -ne 404 ]]
  [[ `curl -o /dev/null -w %{http_code} foobar.baz/install.php` -ne 404 ]]
}

@test "we do better than 403" {
  [[ `curl -o /dev/null -w %{http_code} foobar.baz` -ne 403 ]]
  [[ `curl -o /dev/null -w %{http_code} foobar.baz/index.php` -ne 403 ]]
  [[ `curl -o /dev/null -w %{http_code} foobar.baz/install.php` -ne 403 ]]
}

@test "we do better than 500" {
  [[ `curl -o /dev/null -w %{http_code} foobar.baz` -ne 500 ]]
  [[ `curl -o /dev/null -w %{http_code} foobar.baz/index.php` -ne 500 ]]
  [[ `curl -o /dev/null -w %{http_code} foobar.baz/install.php` -ne 500 ]]
}
