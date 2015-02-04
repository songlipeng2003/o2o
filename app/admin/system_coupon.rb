ActiveAdmin.register SystemCoupon do
  permit_params :name, :product_id, :amount, :description

  index do
    id_column
    column :name
    column :product
    column :amount
    column :created_at
    actions
  end

  filter :name
  filter :amount
  filter :description
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :amount
      f.input :product
      f.input :description
    end
    f.actions
  end
end
