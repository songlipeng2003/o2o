ActiveAdmin.register Category do
  menu parent: '店铺\商品'

  permit_params :name

  sortable tree: true,
    sorting_attribute: :sort,
    collapsible: true,
    start_collapsed: true
  permit_params :name, :parent_id

  index :as => :sortable do
    label :name
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :image, as: :file
      f.input :parent_id, :as => :select, :collection => Category.ancestry_options(Category.arrange({ order: 'id' }))
    end
    f.actions
  end
end
