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

    def trading_records
      finance.trading_records
    end

    def balance
      finance.balance
    end

    def balance=(balance)
      finance.balance = balance
    end

    def freeze_balance
      finance.freeze_balance
    end

    def freeze_balance=(freeze_balance)
      finance.freeze_balance = freeze_balance
    end
  end

  module ClassMethods
  end

end
