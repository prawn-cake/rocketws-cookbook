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

service "nginx" do
    action :restart
end
