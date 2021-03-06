RocketWS Cookbook
==================
Chef cookbook for [RocketWS](https://github.com/prawn-cake/RocketWS) websockets push server.


Requirements
------------
* [Python cookbook](https://github.com/poise/python.git)
* [Supervisor cookbook](https://github.com/poise/supervisor.git)
* Nginx cookbook (if nginx recipe will be applied)


Attributes
----------
RocketWS configuration parameters:

```ruby
	project = "rocketws"

	default[project] = {
		:project        => "#{project}",
		:environment    => "production",  # could be `default`, `test`
		:home           => "/opt/#{project}",
		:user           => "#{project}",
		:group          => "#{project}",
		:logdir         => "/var/log/#{project}",
		:git_repository => "https://github.com/prawn-cake/RocketWS.git",
		:git_revision   => "develop"
	}

	default[project][:app] = {
		:transport_port    => 59999,
		:ws_port           => 58000
	}
```

RocketWS nginx configuration parameters:

```ruby
	default[:rocketws][:nginx] = {
		:ssl    => {
		    :on     => false,
		    :dir    => "/etc/nginx/ssl"
		},
		:server_names => ["rocketws.yourdomain.com"],
		:proxy_read_timeout => 604800,
		:proxy_shell	=> {
			:enable		=> true,
			:allow_for	=> []
		}
	}
```

**NOTE**: To enable ssl turn on `rocketws.nginx.ssl.on` option and put `rocketws.crt` and `rocketws.key` files to `rocketws.nginx.ssl.dir` directory on a server.

**NOTE:** If you use `https` with **self-signatured** certificate you must use `wss://` schema firstly and before connect you must first visit a regular html page with that certificate so you can accept it.

`proxy_shell` - enable shell proxying `/shell --> http://localhost:{transport_port}`, `allow_for` - list of trusted ip addresses or subnets.


Deployment recommendations
--------------------------

* Better to use separate role with following run_list:

```json
    "run_list": [
        "role[base]",
        "recipe[supervisor]",
        "recipe[git]",
        "recipe[nginx]",
        "recipe[rocketws]",
        "recipe[rocketws::nginx]"
    ]
```

* Use nginx for proxying websockets connections;
* Use iptables (or ferm) for restrics port access in production;
* Use MessagesSource connector only for internal clients (application backends);
* Use shell proxying for dev puproses or use `allow_for` for trusted only addresses;


License and Authors
-------------------
License: MIT

Authors: Maksim Ekimovskiy
