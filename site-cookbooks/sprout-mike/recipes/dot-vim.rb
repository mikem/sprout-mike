git "#{Chef::Config[:file_cache_path]}/dot-vim" do
  repository node['dot-vim']['repository']
  revision node['dot-vim']['version']
  enable_submodules true
  destination "#{Chef::Config[:file_cache_path]}/dot-vim"
  action :sync
end

execute "Copying dot-vim's .git to ~/.vim" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/dot-vim/ #{node['sprout']['home']}/.vim/"
  user node['current_user']
end

link "~/.vimrc" do
  target_file "#{node['sprout']['home']}/.vimrc"
  to "#{node['sprout']['home']}/.vim/vimrc"
  link_type :symbolic
  owner node['current_user']
end
