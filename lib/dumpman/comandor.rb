module Dumpman
  module Commandor
    extend self

    def dump
      Dumpman::Database.dump
    end

    def restore
      Dumpman::Database.drop
      Dumpman::Database.create
      Dumpman::Database.restore
    end

    def drop_db
      Dumpman::Database.drop
    end

    def create_db
      Dumpman::Database.create
    end
  end
end
