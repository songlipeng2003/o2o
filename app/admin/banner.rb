ActiveAdmin.register Banner do
  menu parent: '系统'

  permit_params :banner_group_id, :image, :link

  index do
    selectable_column
    id_column
    column :banner_group
    column :image, sortable: false do |banner|
      if banner.image.attached?
        link_to image_tag(banner.image, width: 300), banner.link, target: '_blank'
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :link
  filter :banner_group

  form html: { multipart: true } do |f|
    f.inputs do
      f.input :banner_group
      f.input :image, as: :file, image_preview: true
      f.input :link
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :banner_group
      row :image do
        if banner.image.attached?
          link_to image_tag(banner.image, width: 300), banner.link, target: '_blank'
        end
      end
      row :created_at
      row :updated_at
    end
  end
end
