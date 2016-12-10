# Apply some security
include_recipe 'ssh-hardening'
include_recipe 'os-hardening'

# Configure Users
include_recipe 'wordpress::accounts'

# Install MySQL
mysql_service 'wordpress' do
  port '3306'
  version '5.5'
  initial_root_password data_bag_item('credentials', 'mysql')['password']
  action [:create, :start]
end

# Create wordpress db and users
mysql2_chef_gem 'default' do
  action :install
end

mysql_connection_info = {
  host: '127.0.0.1',
  username: 'root',
  password: data_bag_item('credentials', 'mysql')['password']
}

mysql_database 'wordpress' do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'wordpress' do
  connection mysql_connection_info
  password data_bag_item('credentials', 'mysql')['password']
  database_name 'wordpress'
  host 'localhost'
  privileges [:select, :update, :insert, :create, :delete]
  action :grant
end

# Install HHVM
include_recipe 'hhvm'

# Setup wordpress
directory '/var/www' do
  recursive true
  owner 'www-data'
  group 'www-data'
  mode 0755
end

bash 'Extract' do
  cwd '/var/www'
  code <<-'EOH'
    tar -xzf latest.tar.gz
    chown -R www-data:www-data wordpress
  EOH
  action :nothing
end

remote_file '/var/www/latest.tar.gz' do
  source 'https://wordpress.org/latest.tar.gz'
  checksum '7eae27ff70716dae2d2ba58280f2832fd70a208c9cdaf29ab36ac789c14d6977'
  notifies :run, 'bash[Extract]', :immediately
end

# Setup PHP
package 'php5-fpm'

# Setup NginX
include_recipe 'nginx'

nginx_site 'default' do
  enable false
  notifies :reload, 'service[nginx]'
end

template File.join(node['nginx']['dir'], 'sites-available', 'wordpress.conf') do
  source 'wordpress.conf.erb'
  mode 00644
end

nginx_site 'wordpress.conf'
