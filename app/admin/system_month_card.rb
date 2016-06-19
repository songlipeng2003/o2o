ActiveAdmin.register SystemMonthCard do
  menu parent: '促销'

  config.sort_order = 'sort_desc, id_desc'
  config.batch_actions = false

  permit_params :province_id, :city_id, :name, :month, :price, :sort, :is_show, :product_id

  index do
    id_column
    column :city
    column :product
    column :name
    column :month
    column :price
    column :is_show
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :product
      f.input :name
      f.input :month
      f.input :price
      f.input :province, :collection => Area.provinces,
        :input_html => { :class => :cascade_select, 'data-cascade-target' => 'system_month_card_city_id' }
      f.input :city, :collection => (f.object.city ? f.object.city.parent.children : '')
      f.input :is_show
    end
    f.actions
  end

  filter :name
  filter :month
  filter :price
  filter :created_at
end
