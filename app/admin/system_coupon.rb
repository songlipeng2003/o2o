ActiveAdmin.register SystemCoupon do
  menu parent: '促销'

  permit_params :name, :product_id, :amount, :description, :image

  index do
    id_column
    column :name
    column :amount
    column :image, sortable: false do |system_coupon|
      if system_coupon.image.attached?
        image_tag(system_coupon.image, width: 300)
      end
    end
    column :product
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
      f.input :amount
      f.input :image, as: :file
      f.input :product
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :amount
      row :image do
        if system_coupon.image.attached?
          image_tag(system_coupon.image, width: 400)
        end
      end
      row :product
      row :description
      row :created_at
      row :updated_at
    end
  end
end
