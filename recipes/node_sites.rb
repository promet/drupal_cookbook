node['drupal']['sites'].to_hash.each do |uri, info|
  site = drupal_site uri do
    db_init true
  end
  info.each do |parameter, value|
    site.send(parameter, value)
  end
end
