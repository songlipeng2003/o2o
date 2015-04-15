ActiveAdmin.register Finance do
  menu parent: '财务'

  actions :index, :show

  config.batch_actions = false

  index do
    id_column
    column :financeable
    column :balance
    column :freeze_balance
    column :created_at
    column :updated_at
    actions
  end

  filter :balance
  filter :freeze_balance
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :financeable
      row :balance
      row :freeze_balance
      row :created_at
      row :updated_at
    end

    panel "交易历史" do
      paginated_collection(finance.trading_records.page(params[:page]).per(10), entry_name: 'TradingRecord') do
        table_for(collection) do |trading_record|
          column(I18n.t('activerecord.attributes.trading_record.id')) { |trading_record| trading_record.id }
          column(I18n.t('activerecord.attributes.trading_record.name')) { |trading_record| trading_record.name }
          column(I18n.t('activerecord.attributes.trading_record.trading_type')) do |trading_record|
            trading_record.trading_type_name
          end
          column(I18n.t('activerecord.attributes.trading_record.amount')) { |trading_record| trading_record.amount }
          column(I18n.t('activerecord.attributes.trading_record.object')) { |trading_record| trading_record.object }
          column(I18n.t('activerecord.attributes.trading_record.created_at')) { |trading_record| I18n.l trading_record.created_at, :format => :long  }
        end
      end
    end
  end
end
