default[:rocketws][:nginx] = {
    :ssl    => {
        :on     => false,
        :dir    => "/etc/nginx/ssl"
    },
    :server_names => [],
    :proxy_read_timeout => 604800,
    :proxy_shell    => true
}
