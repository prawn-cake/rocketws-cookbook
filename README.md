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
RocketWS configuration parameters

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
		:ms_port    => 59999,
		:ws_port    => 58000
	}
```


Deployment recommendations
--------------------------
Better to use separat role with following run_list:

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


License and Authors
-------------------
License: MIT

Authors: Maksim Ekimovskiy
