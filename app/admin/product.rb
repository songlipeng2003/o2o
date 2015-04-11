ActiveAdmin.register Product do
  belongs_to :store, :optional => true

  permit_params :name, :price, :market_price, :description, :image, :product_type_id,
    :system_product_id, :category_id, :store_id

  index do
    id_column
    column :name
    column :store
    column :category
    column :product_type do |product|
      product.product_type_name
    end
    column :price
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

  form html: { multipart: true } do |f|
    f.inputs do
      f.input :store
      f.input :system_product
      f.input :name
      f.input :product_type, as: 'select', collection: Product::PRODUCT_TYPES.invert
      f.input :category
      f.input :image, :image_preview => true
      f.input :price
      f.input :market_price
      f.input :description
    end
    f.actions
  end

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
      row :image do
        image_tag(product.image.url)
      end
      row :price
      row :market_price
      row :description
      row :created_at
      row :updated_at
    end
  end
end
