ActiveAdmin.register Product do
  permit_params :name, :price, :market_price, :description

  index do
    id_column
    column :name
    column :price
    column :market_price
    column :created_at
    actions
  end

  filter :name
  filter :price
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :market_price
      f.input :description
    end
    f.actions
  end
end
