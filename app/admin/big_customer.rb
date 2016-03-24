ActiveAdmin.register BigCustomer do
  menu parent: '用户'

  permit_params :name, :province_id, :city_id, :area_id, :contacts, :phone

  index do
    selectable_column
    id_column
    column :city
    column :contacts
    column :phone
    column :created_at
    column :updated_at
    actions defaults: true do |big_customer|
      link_to('用户管理', admin_big_customer_big_customer_users_path(big_customer))
    end
  end

  filter :name
  filter :contacts
  filter :phone
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :contacts
      f.input :phone
      f.input :province_id, :collection => Area.provinces,
        :input_html => { :class => :cascade_select, 'data-cascade-target' => 'big_customer_city_id' }
      f.input :city_id, :collection => (f.object.city ? f.object.city.parent.children : ''),
        :input_html => { :class => :cascade_select, 'data-cascade-target' => 'big_customer_area_id' }
      f.input :area_id, :collection => (f.object.area ? f.object.area.parent.children : '')
    end
    f.actions
  end
end
