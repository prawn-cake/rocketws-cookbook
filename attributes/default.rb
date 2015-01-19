default[:rocketws] = {
    :environment    => "production",  # could be `default`, `test`
    :home           => "/opt/rocketws",
    :user           => "rocketws",
    :group          => "rocketws",
    :logdir         => "/var/log/rocketws",
    :git_repository => "https://github.com/prawn-cake/RocketWS.git",
    :git_revision   => "develop"
}

include_attribute "supervisor"
#default[:supervisor] = {
#    :version    => "3.1.3",
#}
