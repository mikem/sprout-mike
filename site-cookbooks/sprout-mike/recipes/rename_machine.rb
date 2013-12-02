hostname = node['desired_hostname']
raise "The hostname '#{hostname}' is not valid" if hostname.empty?

# The scutil commands need to run as root, unless
# you're logged into the console, but we can't be sure of that.

["scutil --set ComputerName #{hostname}",
 "scutil --set LocalHostName #{hostname}",
 "scutil --set HostName #{hostname}",
 "hostname #{hostname}",
 "diskutil rename / #{hostname}" ].each do |host_cmd|
  execute host_cmd
end

ruby_block "test to see if hostname was set" do
  block do
    raise "Setting of hostname failed" unless hostname == `scutil --get ComputerName`.chop
  end
end
