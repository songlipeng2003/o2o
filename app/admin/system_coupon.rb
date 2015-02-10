ActiveAdmin.register SystemCoupon do
  menu parent: '代金券'

  permit_params :name, :product_id, :amount, :description, :image

  index do
    id_column
    column :name
    column :image, sortable: false do |system_coupon|
      image_tag(system_coupon.image.thumb.url)
    end
    column :product
    column :amount
    column :created_at
    actions
  end

  filter :name
  filter :amount
  filter :description
  filter :created_at

  form html: { multipart: true } do |f|
    f.inputs do
      f.input :name
      f.input :image, :image_preview => true
      f.input :amount
      f.input :product
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :image do
        image_tag(system_coupon.image.url)
      end
      row :amount
      row :product
      row :description
      row :created_at
      row :updated_at
    end
  end
end
