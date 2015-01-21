default[:rocketws][:nginx] = {
    :ssl    => {
        :on     => false,
        :dir    => "/etc/nginx/ssl"
    },
    :server_names => ["rocketws1.yourdomain.com", "rocketws2.yourdomain.com"],
    :proxy_read_timeout => 604800
}
