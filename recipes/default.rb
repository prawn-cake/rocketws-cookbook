#
# Cookbook Name:: rocketws
# Recipe:: default
#
# Copyright 2015, Maksim Ekimovskii
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

include_recipe 'python'
include_recipe 'supervisor'


# Install package dependencies
package 'libev4'

# Create system user
user "#{node[:rocketws][:user]}" do
    home    node[:rocketws][:home]
    shell   '/bin/bash'
    action  :create
end

# Create home directory
directory "#{node[:rocketws][:home]}" do
    owner   node[:rocketws][:user]
    group   node[:rocketws][:group]
    mode    '0750'
    action  :create
end

# Clone project
git "#{node[:rocketws][:home]}" do
    repository  node[:rocketws][:git_repository]
    revision    node[:rocketws][:git_revision]
    action      :sync
end

# Setup virtualenv
execute "setup-virtualenv" do
    user    node[:rocketws][:user]
    cwd     node[:rocketws][:home]
    command "make env && touch #{node[:rocketws][:home]}/chef_virtualenv_setup_done"
    not_if  { ::File.exists?("#{node[:rocketws][:home]}/chef_virtualenv_setup_done")}
end
virtualenv_path = "#{node[:rocketws][:home]}/.env"
#python_virtualenv virtualenv_path do
#    owner   node[:rocketws][:user]
#    group   node[:rocketws][:group]
#    action  :create
#end

# Create log directory
directory "#{node[:rocketws][:logdir]}" do
    owner   node[:rocketws][:user]
    group   node[:rocketws][:group]
    mode    '0750'
    action  :create
end

# Setup supervisor config
supervisor_service "rocketws" do
    action      :enable
    user        node[:rocketws][:user]
    autostart   false
    autorestart true
    command     "#{virtualenv_path}/bin/python #{node[:rocketws][:home]}/manage.py runserver \
                    --ws-conn :#{node[:rocketws][:app][:ws_port]} \
                    --ms-conn :#{node[:rocketws][:app][:ms_port]} \
                    --settings=rocketws.settings.#{node[:rocketws][:environment]}"
end
