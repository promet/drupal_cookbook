Vagrant.configure("2") do |config|
  config.omnibus.chef_version = :latest
  config.vm.box = "wheezy"

  config.vm.network :private_network, ip: "10.33.33.10"
  config.vm.hostname = 'foo.dev'

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      }
    }

    chef.run_list = [
        "recipe[drupal]",
        "recipe[drupal::drush]",
        "recipe[drupal::foo]",
    ]
  end
end
