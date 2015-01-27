project = "rocketws"

default[project] = {
    :project        => "#{project}",
    :environment    => "production",  # could be `default`, `test`
    :home           => "/opt/#{project}",
    :user           => "#{project}",
    :group          => "#{project}",
    :logdir         => "/var/log/#{project}",
    :git_repository => "https://github.com/prawn-cake/RocketWS.git",
    :git_revision   => "master"
}

default[project][:app] = {
    :ms_port    => 59999,
    :ws_port    => 58000
}
