ActiveAdmin.register SystemProduct do
  menu parent: '商品'

  permit_params :name, :description, :image

  index do
    id_column
    column :name
    column :category
    column :image, sortable: false do |product|
      image_tag(product.image.thumb.url)
    end
    column :created_at
    actions
  end

  filter :name

  form html: { multipart: true } do |f|
    f.inputs do
      f.input :name
      f.input :category
      f.input :image, :image_preview => true
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :category
      row :image do
        image_tag(system_product.image.url)
      end
      row :description
      row :created_at
      row :updated_at
    end
  end
end
