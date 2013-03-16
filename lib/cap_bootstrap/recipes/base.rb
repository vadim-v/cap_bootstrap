Capistrano::Configuration.instance(:must_exist).load do
  def template(from, to)
    erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
    put ERB.new(erb).result(binding), to
  end

  def set_default(name, *args, &block)
    set(name, *args, &block) unless exists?(name)
  end

  namespace :deploy do
    desc "Install everything onto the server"
    task :install do
      sudo "bash -c 'echo UTC > /etc/timezone'"
      sudo "cp /usr/share/zoneinfo/UTC /etc/localtime"
      sudo "dpkg-reconfigure -f noninteractive tzdata"
      sudo "apt-get -y update"
      sudo "apt-get -y install software-properties-common"
    end
  end
end
