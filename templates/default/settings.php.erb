<?php
function globals_import($globals_conf_d) {
  $flags = \FilesystemIterator::SKIP_DOTS | \FilesystemIterator::FOLLOW_SYMLINKS;
  $iterator = new \RecursiveDirectoryIterator($globals_conf_d, $flags);
  $it = new \RecursiveIteratorIterator($iterator, \RecursiveIteratorIterator::SELF_FIRST);

  $depth_matrix = array();

  foreach ($it as $file) {
    $path = $it->getSubPathname();
    $depth = count(explode('/', $path));
    $info = load_file_by_type($globals_conf_d . '/' . $path);
    $depth_matrix[$depth][] = _array_path_depth_set($path, $info);
  }

  foreach ($depth_matrix as $depth => $configs) {
    $depth_matrix[$depth] = call_user_func_array('array_merge_recursive', $configs);
  }

  // Ensure that the deepest configs override others.
  krsort($depth_matrix);
  $config = call_user_func_array('array_merge_recursive', $depth_matrix);
  $stupid_globals = $config['globals'];
  unset($config['globals']);

  global $databases, $cookie_domain, $conf, $installed_profile, $update_free_access, $db_url, $db_prefix, $drupal_hash_salt, $is_https, $base_secure_url, $base_insecure_url;
  extract($config);
  extract($stupid_globals);
}

function ini_import($ini_conf_d) {
  $files = glob($ini_conf_d . '/*.ini');
  $inis = array();
  foreach ($files as $file) {
    $inis += parse_ini_file($file);
  }
  foreach ($inis as $directive => $value) {
    ini_set($directive, $value);
  }
}

function _array_path_depth_set($path, $info) {
  $path_parts = explode('/', $path);
  $filename = array_pop($path_parts);
  $base = current(explode('.', $filename, -1));
  $info = array($base => $info);
  while($key = array_pop($path_parts)) {
    $info = array($key => $info);
  }
  return $info;
}

function load_file_by_type($file) {
  // Forgive me for what I am about to do.
  $parts = explode('.', $file);
  $extension = end($parts);
  switch($extension) {
  case 'yml':
  case 'yaml':
    //TODO: add something here.
  case 'json':
    $info = json_decode(file_get_contents($file), TRUE);
    break;
  case 'ini':
    $info = parse_ini_file($file);
  }
  return $info;
}

$settings_conf_d = __DIR__ . '/settings.conf.d';
$globals_conf_d = $settings_conf_d . '/globals.conf.d';
$ini_conf_d = $settings_conf_d . '/ini.conf.d';

globals_import($globals_conf_d);
ini_import($ini_conf_d);
