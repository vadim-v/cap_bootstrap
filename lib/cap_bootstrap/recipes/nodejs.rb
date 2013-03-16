Capistrano::Configuration.instance(:must_exist).load do
  namespace :nodejs do
    desc "Install the latest relase of Node.js"
    task :install, roles: :app do
      sudo sudo"add-apt-repository ppa:chris-lea/node.js --yes"
      sudo "apt-get -y update"
      sudo "apt-get -y install nodejs"
    end
    after "deploy:install", "nodejs:install"
  end
end
