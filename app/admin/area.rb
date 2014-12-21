ActiveAdmin.register Area do
  menu parent: '基础数据'

  sortable tree: true,
    sorting_attribute: :id,
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
      f.input :parent_id, :as => :select, :collection => Area.ancestry_options(Area.arrange({ order: 'id' }))
    end
    f.actions
  end
end
