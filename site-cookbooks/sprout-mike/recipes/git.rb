package 'git'

template "#{node['sprout']['home']}/.gitconfig" do
  source "dot-gitignore.erb"
  owner node['current_user']
  mode "0644"
end
