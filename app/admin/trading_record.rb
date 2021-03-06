ActiveAdmin.register TradingRecord do
  menu parent: '财务'

  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :name
    column :trading_type do |trading_record|
      trading_record.trading_type_name
    end
    column :amount
    column :object
    column :created_at
    actions
  end

  filter :trading_type, as: :select, collection: TradingRecord::TRADING_TYPES
  filter :amount
  filter :created_at
end
