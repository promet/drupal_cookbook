action :run do
  @bin = new_resource.executable || 'drush'
  command = [
    @bin << (new_resource.alias ? " @#{new_resource.alias}": ''),
    new_resource.command,
    new_resource.flags.collect{|flag| "-#{flag}"}.join(' '),
    new_resource.options.collect{|opt, val|
      "--#{opt}" << "=#{val}" unless val == true
    },
    new_resource.args.join(' ')
  ].join(' ')
  execute command do
    user new_resource.user ? new_resource.user : 'root'
  end
  new_resource.updated_by_last_action(true)
end
