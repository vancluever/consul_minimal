# The Consul version to install.
default['consul_minimal']['version'] = '0.7.0'

# The SHA256 checksum of the Consul version archive referenced.
#
# When updating or specifying defaults, the SHA256SUMS file should be checked
# against the GPG signature supplied by HashiCorp.
default['consul_minimal']['sha256sum'] = 'b350591af10d7d23514ebaa0565638539900cdb3aaa048f077217c4c46653dd8'

# The datacenter to configure this node for. Nodes in the same datacenter
# should be on a single LAN.
default['consul_minimal']['datacenter'] = 'default'

# The data directory. The directory should be durable across reboots.
# This is especially critical for agents that are running in server mode as
# they must be able to persist cluster state.
default['consul_minimal']['data_dir'] = '/opt/consul'

# The mode to run Consul in. Must be one of 'client' or 'server'.
default['consul_minimal']['mode'] = 'client'

# The user to create for Consul. This user should not exist.
# A group will also be created with this user name.
default['consul_minimal']['user'] = 'consul'

# The home directory Consul will reside in.
default['consul_minimal']['directory'] = '/opt/consul'

# The number of servers we want available before bootstrapping a new cluster.
# For server testing, it's best to set this to 1, so that you can get up and
# running quickly.
#
# The default is to not define this setting, expecting default bootstrap
# behaviour (3 joined servers).
default['consul_minimal']['bootstrap_expect'] = nil

# The name of the default config file. Any other configurations (ie: watchers)
# should be added with a different priority. This is achieved by prefixing
# with a number higher than 00.
default['consul_minimal']['default_config_file'] = '00-default.json'

# The log level that should be used. Needs to be one of
# "TRACE", "DEBUG", "INFO", "WARN", and "ERR".
default['consul_minimal']['log_level'] = 'INFO'

# Define this as a hash to send telemetry metrics where. This is a simple
# 'key' => value pair hash. See
# https://www.consul.io/docs/agent/options.html#telemetry for information
# on the structure of this hash.
#
# Example:
# default['consul_minimal']['telemetry'] = {
#   'dogstatsd_addr' => '172.16.0.10:8125'
#   'dogstatsd_tags' => 'project:vancluever/consul_cookbook_minimal'
# }
default['consul_minimal']['telemetry'] = nil
