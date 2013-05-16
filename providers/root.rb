action :create do
  directory new_resource.path do
    recursive true
    owner     new_resource.owner
    group     new_resource.group
  end
end
