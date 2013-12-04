template "#{node['sprout']['home']}/.vimperatorrc" do
  source "dot-vimperatorrc.erb"
  owner node['current_user']
  mode "0644"
end
