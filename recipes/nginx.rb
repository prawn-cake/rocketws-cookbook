include_recipe "nginx"

template "/etc/nginx/sites-available/#{node[:rocketws][:project]}.nginx.conf" do
    source	"nginx.conf.erb"
    owner	"root"
    mode	644
end

# Enable config, create symlink
link "/etc/nginx/sites-enabled/#{node[:rocketws][:project]}.nginx.conf" do
    to "/etc/nginx/sites-available/#{node[:rocketws][:project]}.nginx.conf"
end

# Create ssl directory if not
directory "/etc/nginx/ssl" do
    owner	"root"
    group   "root"
    mode	'0644'
    action  :create
    not_if  { File.exist?("/etc/nginx/ssl") }
end


service "nginx" do
    action :restart
end
