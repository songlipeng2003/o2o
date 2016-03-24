ActiveAdmin.register Product do
  menu parent: '商品'

  permit_params :name, :price, :suv_price, :market_price, :description,
    :image, :product_type_id, :province_id, :city_id, :category_id

  index do
    id_column
    column :name
    column :category
    column :product_type
    column :city
    column :price
    column :suv_price
    column :market_price
    column :created_at
    actions
  end

  filter :name
  filter :price
  filter :created_at

  form :partial => "form"

  show do
    attributes_table do
      row :id
      row :name
      row :category
      row :product_type
      row :province
      row :city
      row :image do
        image_tag(product.image.url)
      end
      row :price
      row :suv_price
      row :market_price
      row :description
      row :created_at
      row :updated_at
    end
  end
end
