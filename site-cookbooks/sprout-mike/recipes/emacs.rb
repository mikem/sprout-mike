package 'emacs'

git "#{Chef::Config[:file_cache_path]}/dot-emacs" do
  repository node['dot-emacs']['repository']
  revision node['dot-emacs']['version']
  enable_submodules true
  destination "#{Chef::Config[:file_cache_path]}/dot-emacs"
  action :sync
end

directory "#{node['sprout']['home']}/.emacs.d/" do
  owner node['current_user']
end

execute "Copying dot-emacs's .git to ~/.emacs.d" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/dot-emacs/ #{node['sprout']['home']}/.emacs.d/"
  user node['current_user']
end
