default[:rocketws][:nginx] = {
    :ssl    => {
        :on     => false,
        :dir    => "/etc/nginx/ssl"
    },
    :server_names => ["rocketws.yourdomain.com"],
    :proxy_read_timeout => 604800
}
