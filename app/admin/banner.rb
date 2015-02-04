ActiveAdmin.register Banner do
  menu parent: '系统'

  permit_params :image, :link

  index do
    selectable_column
    id_column
    column :image, sortable: false do |banner|
      image_tag(banner.image.url)
    end
    column :link
    column :created_at
    column :updated_at
    actions
  end

  filter :link

  form html: { multipart: true } do |f|
    f.inputs do
      f.input :image, :image_preview => true
      f.input :link
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :image do
          image_tag(banner.image.url)
      end
      row :link
      row :created_at
      row :updated_at
    end
  end
end
