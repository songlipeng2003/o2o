ActiveAdmin.register CarBrand do
  permit_params :name, :first_letter

  index do
    selectable_column
    id_column
    column :name
    column :first_letter
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :first_letter, :collection => ('A'..'Z')
    end
    f.actions
  end
end
