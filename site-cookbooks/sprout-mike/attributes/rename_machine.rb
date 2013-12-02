raise "Set the MACHINE_HOSTNAME environment variable first!" unless ENV.has_key? 'MACHINE_HOSTNAME'
node.default['desired_hostname'] = ENV['MACHINE_HOSTNAME']
