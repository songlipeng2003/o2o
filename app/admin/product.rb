ActiveAdmin.register Product do
  menu parent: '商品'

  permit_params :name, :price, :suv_price, :market_price, :description, :image, :product_type_id

  index do
    id_column
    column :name
    column :category
    column :product_type
    column :image, sortable: false do |product|
      image_tag(product.image.thumb.url)
    end
    column :price
    column :suv_price
    column :market_price
    column :created_at
    actions
  end

  filter :name
  filter :price
  filter :created_at

  form html: { multipart: true } do |f|
    f.inputs do
      f.input :name
      f.input :category
      f.input :product_type
      f.input :image, :image_preview => true
      f.input :price
      f.input :suv_price
      f.input :market_price
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :category
      row :product_type
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
