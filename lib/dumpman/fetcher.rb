module Dumpman
  class Fetcher < OpenStruct
    def self.fetch(connection_name)
      connection = Dumpman.connections.find do |connection|
        connection.name == connection_name
      end

      instance = self.new(attrs: connection.attrs)
      instance.fetch_remote_dump
    end

    def fetch_remote_dump
      fetcher = fetcher_class.new(attrs)
      fetcher.get_dump
    end

    private

      def fetcher_class
        case attrs[:fetch_strategy]
        when :docker then Dumpman::Fetchers::Docker
        when :direct then Dumpman::Fetchers::Direct
        else
          Dumpman::Fetchers::Direct
        end
      end
  end
end
