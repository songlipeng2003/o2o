module V2
  module Entities
    module ErrorFormatter
      def self.call message, backtrace, options, env
        { message: message }.to_json
      end
    end
  end
end
