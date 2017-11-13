module Dumpman
  class Connection
    attr_accessor :name, :env, :server, :path

    def initialize(name)
      @name = name
    end

    def env(val)
      self.env = val
    end

    def server(val)
      self.server = val
    end

    def path(val)
      self.path = val
    end
  end
end
