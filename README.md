RocketWS Cookbook
==================
Chef cookbook for [RocketWS](https://github.com/prawn-cake/RocketWS) websockets push server.


Requirements
------------
* [Python cookbook](https://github.com/poise/python.git)
* [Supervisor cookbook](https://github.com/poise/supervisor.git)


Attributes
----------
RocketWS configuration parameters

```ruby
	default[:rocketws] = {
		:environment    => "production",  # could be `default`, `test`
		:home           => "/opt/rocketws",
		:user           => "rocketws",
		:group          => "rocketws",
		:logdir         => "/var/log/rocketws",
		:git_repository => "https://github.com/prawn-cake/RocketWS.git",
		:git_revision   => "develop"
	]
```


Deployment recommendations
--------------------------
Better to use separat role something like this

```json
    "run_list": [
        "role[base]",
        "recipe[supervisor]",
        "recipe[git]",
        "recipe[rocketws]"
    ]
```


License and Authors
-------------------
License: MIT

Authors: Maksim Ekimovskiy
