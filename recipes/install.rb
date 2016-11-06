URL = "https://releases.hashicorp.com/consul/#{node['consul_minimal']['version']}".freeze
ZIP = "consul_#{node['consul_minimal']['version']}_linux_amd64.zip".freeze
ZIP_CACHE = "#{Chef::Config[:file_cache_path]}/#{ZIP}".freeze
SUM = node['consul_minimal']['sha256sum']
HOME_DIR = node['consul_minimal']['directory']
USER = node['consul_minimal']['user']
GROUP = node['consul_minimal']['user']
BIN_DIR = "#{HOME_DIR}/bin".freeze
DATA_DIR = "#{HOME_DIR}/data".freeze
CONF_DIR = "#{HOME_DIR}/etc".freeze
DEFAULT_CONFIG = "#{CONF_DIR}/#{node['consul_minimal']['default_config_file']}".freeze
SERVICE_NAME = "consul-#{node['consul_minimal']['mode']}".freeze
SERVER_MODE = if node['consul_minimal']['mode'] == 'client'
                false
              elsif node['consul_minimal']['mode'] == 'server'
                true
              else
                raise 'mode must be either "client" or "server"'
              end

include_recipe 'consul_minimal::_unzip'

remote_file ZIP_CACHE do
  action :create
  source "#{URL}/#{ZIP}"
  checksum SUM
end

group GROUP do
  action :create
end

user USER do
  action :create
  manage_home true
  home HOME_DIR
  group GROUP
end

[BIN_DIR, DATA_DIR, CONF_DIR].each do |dir|
  directory dir do
    action :create
    mode 0o755
    user USER
    group GROUP
  end
end

execute "unzip #{ZIP_CACHE} -d #{BIN_DIR}" do
  user USER
  action :run
end

include_recipe 'consul_minimal::_config'

poise_service SERVICE_NAME do
  command "#{BIN_DIR}/consul agent -ui -config-dir #{CONF_DIR} -server #{SERVER_MODE}"
  user USER
  directory HOME_DIR
  environment HOME: HOME_DIR
end
