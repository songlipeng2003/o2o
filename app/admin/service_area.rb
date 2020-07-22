ActiveAdmin.register ServiceArea do
  belongs_to :product
  navigation_menu :product

  permit_params :name, :areas

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form :partial => "form"
end
