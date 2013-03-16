Capistrano::Configuration.instance(:must_exist).load do
  namespace :security do
    desc "Setup a firewall with UFW"
    task :setup_firewall, roles: :web do
      sudo "apt-get -y install ufw"
      sudo "ufw default deny"
      sudo "ufw allow 22/tcp"
      sudo "ufw allow 80/tcp"
      sudo "ufw allow 443/tcp"
      sudo "ufw --force enable"
    end
    after "deploy:install", "security:setup_firewall"
  end
end
