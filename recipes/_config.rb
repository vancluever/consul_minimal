require 'json'

HOME_DIR = node['consul_minimal']['directory']
USER = node['consul_minimal']['user']
GROUP = node['consul_minimal']['user']
DATA_DIR = "#{HOME_DIR}/data".freeze
CONF_DIR = "#{HOME_DIR}/etc".freeze
DEFAULT_CONFIG = "#{CONF_DIR}/#{node['consul_minimal']['default_config_file']}".freeze
SERVICE_NAME = "consul-#{node['consul_minimal']['mode']}".freeze

# build a config hash to build the JSON doc off of.
config = {
  datacenter: node['consul_minimal']['datacenter'],
  data_dir: DATA_DIR,
  log_level: node['consul_minimal']['log_level'],
  client_addr: '0.0.0.0'
}

config[:telemetry] = node['consul_minimal']['telemetry'] unless node['consul_minimal']['telemetry'].nil?

service SERVICE_NAME do
  action :nothing
end

file DEFAULT_CONFIG do
  action :create
  mode 0o644
  user USER
  group GROUP
  content JSON.pretty_generate(config)
  lazy { notifies :restart, "service[#{SERVICE_NAME}]" }
end
