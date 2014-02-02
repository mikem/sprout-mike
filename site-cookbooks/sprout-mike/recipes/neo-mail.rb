# inspired by
# http://lifehacker.com/5611711/create-application-shortcuts-in-google-chrome-for-mac-with-a-shell-script
# https://gist.github.com/522871

name = node['neo-mail']['name']
url = node['neo-mail']['url']
icon = "#{node['neo-mail']['icon-dir']}/#{node['neo-mail']['icon-filename']}"

chrome_path = "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
app_root = "/Applications"
resource_path="#{app_root}/#{name}.app/Contents/Resources"
exec_path="#{app_root}/#{name}.app/Contents/MacOS"
profile_path="#{app_root}/#{name}.app/Contents/Profile"
plist_path="#{app_root}/#{name}.app/Contents/Info.plist"

unless File.exists? "#{app_root}/#{name}.app"
  ["#{app_root}/#{name}.app",
   "#{app_root}/#{name}.app/Contents",
   resource_path,
   exec_path,
   profile_path].each do |dir|
    directory dir do
      action :create
      owner node['current_user']
      group 'staff'
    end
  end

  directory node['neo-mail']['icon-dir'] do
    owner node['current_user']
  end

  cookbook_file node['neo-mail']['icon-filename'] do
    path icon
    owner node['current_user']
    mode '0644'
  end

  bash 'convert icon' do
    user node['current_user']
    code <<-BASH
      if [ -f #{icon} ] ; then
        sips -s format tiff #{icon} --out #{resource_path}/icon.tiff --resampleWidth 128 >& /dev/null
        tiff2icns -noLarge #{resource_path}/icon.tiff >& /dev/null
      fi
    BASH
  end

  bash 'create executable' do
    user node['current_user']
    code <<-BASH
cat >#{exec_path}/#{name} <<EOF
#!/bin/sh
exec "#{chrome_path}" --app="#{url}" --user-data-dir="#{profile_path}" "\\$@"
EOF
chmod +x #{exec_path}/#{name}
    BASH
  end

  bash 'create Info.plist' do
    user node['current_user']
    code <<-BASH
cat > #{plist_path} <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" “http://www.apple.com/DTDs/PropertyList-1.0.dtd”>
<plist version=”1.0″>
<dict>
<key>CFBundleExecutable</key>
<string>#{name}</string>
<key>CFBundleIconFile</key>
<string>icon</string>
</dict>
</plist>
EOF
    BASH
  end
end
