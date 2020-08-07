ActiveAdmin.register Evaluation do
  menu parent: '订单'

  actions :index, :show

  config.batch_actions = false

  index do
    id_column
    column :order
    column :user
    column :store
    column :score
    column :note
    column :created_at
    actions
  end

  filter :score

  show do
    attributes_table do
      row :id
      row :user
      row :store
      row :order
      row :score
      row :note
      row :images do
        content = ''
        evaluation.images.each do |image|
          content << image_tag(image.file.url)
          content << '<br/>'
        end
        raw content
      end
      row :application
      row :created_at
    end
  end
end
