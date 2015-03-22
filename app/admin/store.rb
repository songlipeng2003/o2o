ActiveAdmin.register Store do
  permit_params :name, :address, :phone, :description, :lon, :lat, :area_id, :province_id, :city_id

  index do
    selectable_column
    id_column
    column :name
    column :store_type do |store|
      store.store_type_name
    end
    column :address
    column :phone
    actions defaults: true do |store|
      link_to '用户管理', admin_store_store_users_path(store)
    end
  end

  filter :name
  filter :address
  filter :phone

  form :partial => "form"

  show do
    attributes_table do
      row :id
      row :name
      row :store_type_name
      row :phone
      row :address
      row :description
      row :province
      row :city
      row :area
      row :created_at
      row :created_at
      row :updated_at
    end

    panel "订单历史" do
      paginated_collection(store.orders.page(params[:page]).per(10), entry_name: 'Order') do
        table_for(collection) do |order|
          column(I18n.t('activerecord.attributes.order.id')) { |order| order.id }
          column(I18n.t('activerecord.attributes.order.sn')) { |order| order.sn }
          column(I18n.t('activerecord.attributes.order.user')) do |order|
            link_to order.user.phone, admin_user_path(order.user)
          end
          column(I18n.t('activerecord.attributes.order.car')) do |order|
            order.car_model.name + '-' + order.license_tag + '-' + order.car_color
          end
          column(I18n.t('activerecord.attributes.order.product')) do |order|
            link_to order.product.name, admin_product_path(order.product)
          end
          column(I18n.t('activerecord.attributes.order.total_amount')) { |order| order.total_amount }
          column(I18n.t('activerecord.attributes.order.booked_at')) { |order| I18n.l order.booked_at, :format => :long }
          column(I18n.t('activerecord.attributes.order.state')) { |order| order.aasm.human_state }
        end
      end
    end
  end
end
