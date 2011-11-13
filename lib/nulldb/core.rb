require 'active_record/connection_adapters/nulldb_adapter'

module NullDB
  class Config < Struct.new(:project_root); end

  class << self
    def configure
      @@config = Config.new.tap {|c| yield c}
    end

    def config
      if !defined?(@@config)
        raise "NullDB not configured. Require a framework, ex 'nulldb/rails'"
      end

      @@config
    end

    def nullify(options={})
      @prev_connection = ActiveRecord::Base.connection_pool.try(:spec)
      ActiveRecord::Base.establish_connection(options.merge(:adapter => :nulldb))
    end

    def restore
      if @prev_connection
        ActiveRecord::Base.establish_connection(@prev_connection)
      end
    end

    def checkpoint
      ActiveRecord::Base.connection.checkpoint!
    end
  end
end
