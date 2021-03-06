ActiveAdmin.register Store do
  menu parent: '店铺\商品'

  permit_params :name, :address, :phone, :description, :lon, :lat, :area_id, :province_id, :city_id


  scope :all, default: true do |scope|
    scope.where("deleted_at IS NULL")
  end

  scope :deleted do |scope|
    scope.only_deleted
  end

  index do
    selectable_column
    id_column
    column :name
    column :store_type do |store|
      store.store_type_name
    end
    column :address
    column :phone
    actions  defaults: false do |store|
      content = link_to '查看', admin_store_path(store)
      content << ' '
      content << link_to('编辑', edit_admin_store_path(store)) unless store.deleted?
      content << ' '
      if store.deleted?
        content << link_to('恢复', restore_admin_store_path(store), method: :put)
      else
        content << link_to('删除', admin_store_path(store), method: :delete)
      end

      content << ' '
      content << link_to('用户管理', admin_store_store_users_path(store))

      content << ' '
      content << (link_to '商品管理', admin_store_products_path(store))
      raw content
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
      paginated_collection(store.orders.reorder('booked_at DESC').page(params[:page]).per(20), entry_name: 'Order') do
        table_for collection do |order|
          column(I18n.t('activerecord.attributes.order.id')) { |order| order.id }
          column(I18n.t('activerecord.attributes.order.sn')) { |order| order.sn }
          column(I18n.t('activerecord.attributes.order.user')) do |order|
            link_to order.user.phone, admin_user_path(order.user)
          end
          column(I18n.t('activerecord.attributes.order.store_user')) do |order|
            link_to order.store_user.phone, admin_store_store_user_path(order.store, order.store_user)
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

  member_action :restore, method: :put do
    Store.with_deleted.find(params[:id]).restore
    redirect_to :back, notice: "恢复成功"
  end

  controller do
    def show
      @store = Store.with_deleted.find(params[:id])
    end

    # def scoped_collection
    #   Store.with_deleted
    # end
  end


  action_item :map, :only => :index do
    link_to('区域地图', map_admin_stores_path)
  end

  collection_action :map do
    @stores = Store.where(city_id: 917).all
    @page_title = '区域地图'
  end
end
