ActiveAdmin.register Address do

  actions :index, :show, :edit, :destroy

  permit_params :name, :address, :area_id, :lon, :lat

  index do
    selectable_column
    id_column
    column :user
    column :name
    column :place
    column :application
    column :created_at
    column :updated_at
    actions
  end

  filter :user_phone, :as => :string
  filter :name
  filter :place
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :place
      f.input :lon
      f.input :lat
    end
    f.actions
  end
end
