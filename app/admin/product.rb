ActiveAdmin.register Product do
  belongs_to :store, :optional => true

  permit_params :name, :price, :suv_price, :market_price, :description,
    :image, :product_type_id, :province_id, :city_id, :category_id, :system_product_id, :store_id

  index do
    id_column
    column :name
    column :store
    column :category
    column :product_type do |product|
      product.product_type_name
    end
    column :city
    column :price
    column :suv_price
    column :market_price
    column :created_at
    actions defaults: true do |product|
      link_to '服务区域管理', admin_product_service_areas_path(product)
    end
  end

  filter :product_type, as: 'select', collection: Product::PRODUCT_TYPES
  filter :name
  filter :price
  filter :created_at

  form :partial => "form"

  show do
    attributes_table do
      row :id
      # row :store
      row :system_product
      row :name
      row :product_type do
        product.product_type_name
      end
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
