module Dumpman
  class Connection
    attr_accessor :name, :app_env, :ssh_cmd, :app_path, :ssh_opts, :fetch_strategy, :docker_image

    def initialize(name)
      @name = name
    end

    def attrs
      {
        app_env: @app_env,
        ssh_cmd: @ssh_cmd,
        ssh_opts: @ssh_opts,
        app_path: @app_path,
        fetch_strategy: @fetch_strategy,
        docker_image: @docker_image,
      }
    end

    def app_env(val)
      self.app_env = val
    end

    def ssh_cmd(val)
      self.ssh_cmd = val
    end

    def app_path(val)
      self.app_path = val
    end

    def ssh_opts(val)
      self.ssh_opts = val
    end

    def fetch_strategy(val)
      self.fetch_strategy = val
    end

    def docker_image(val)
      self.docker_image = val
    end
  end
end
