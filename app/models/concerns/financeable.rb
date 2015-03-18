module Financeable
  extend ActiveSupport::Concern

  included do
    has_one :finance, as: :financeable, autosave: true

    def finance
      finance = super
      unless finance
        self.create_finance
      end
      super
    end
  end

  module ClassMethods
  end

end
