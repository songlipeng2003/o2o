ActiveAdmin.register User do
  menu parent: '用户'

  actions :index, :show, :edit, :update

  permit_params :phone, :nickname, :gender

  index do
    id_column
    column :phone
    column :nickname
    column :balance
    column :score
    column "代金券数量", :coupons do |user|
      user.coupons.count
    end
    column "订单数", :orders do |user|
      user.orders.count
    end
    column :application
    column :current_sign_in_at
    column :created_at
    actions defaults: true do |user|
      link = ''
      link << link_to('修改支付密码', change_pay_password_admin_user_path(user))
      link << '&nbsp;&nbsp;'
      link << link_to('修改余额', set_balance_admin_user_path(user))

      raw link
    end
  end

  filter :phone
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :phone
      f.input :nickname
      f.input :gender
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :phone
      row :score
      row :gender
      row :nickname
      row :avatar do
        if user.avatar.attached?
          image_tag(user.avatar, width: 300)
        end
      end
      row :application
      row :created_at
      row :updated_at
    end

    panel "订单历史" do
      paginated_collection(user.orders.page(params[:page]).per(20), entry_name: 'Order') do
        table_for(collection) do |order|
          column(I18n.t('activerecord.attributes.order.id')) { |order| order.id }
          column(I18n.t('activerecord.attributes.order.sn')) { |order| order.sn }
          column(I18n.t('activerecord.attributes.order.car')) do |order|
            order.car_model.name + '-' + order.license_tag + '-' + order.car_color if order.car
          end
          column(I18n.t('activerecord.attributes.order.product')) do |order|
            link_to order.product.name, admin_product_path(order.product)
          end
          column(I18n.t('activerecord.attributes.order.total_amount')) { |order| order.total_amount }
          column(I18n.t('activerecord.attributes.order.booked_at')) { |order| I18n.l order.booked_at, :format => :long if order.booked_at }
          column(I18n.t('activerecord.attributes.order.state')) { |order| order.aasm.human_state }
        end
      end
    end

    panel "地址列表" do
      table_for user.addresses.order('id DESC') do |address|
        column(I18n.t('activerecord.attributes.address.id')) { |address| address.id }
        column(I18n.t('activerecord.attributes.address.name')) { |address| address.name }
        column(I18n.t('activerecord.attributes.address.place')) { |address| address.place }
        column(I18n.t('activerecord.attributes.address.place')) { |address| address.place }
        column('操作') { |address| link_to '查看', admin_address_path(address) }
      end
    end

    panel "汽车列表" do
      table_for user.cars.order('id DESC') do |car|
        column(I18n.t('activerecord.attributes.car.id')) { |car| car.id }
        column(I18n.t('activerecord.attributes.car.car_model')) { |car| car.car_model.name }
        column(I18n.t('activerecord.attributes.car.license_tag')) { |car| car.license_tag }
        column(I18n.t('activerecord.attributes.car.color')) { |car| car.color }
        column('操作') { |car| link_to '查看', admin_car_path(car) }
      end
    end
  end

  member_action :change_pay_password, method: [:get, :put, :patch] do
    @user = User::find(params[:id])

    if request.put? || request.patch?
      @user.pay_password = params[:user][:pay_password]
      if @user.save
        redirect_to admin_user_path, notice: "修改支付密码成功"
      end
    end

    @page_title = "修改支付密码"
  end

  member_action :set_balance, method: [:get, :put, :patch] do
    @user = User::find(params[:id])

    if request.put? || request.patch?
      trading_record = TradingRecord.new
      trading_record.user = @user
      trading_record.object = @user

      if @user.balance > params[:user][:balance].to_f
        amount = @user.balance - params[:user][:balance].to_f
        trading_record.amount = - amount
        trading_record.trading_type = TradingRecord::TRADING_TYPE_OUT_BY_PLATFORM
        trading_record.name = "后台减少#{amount}"
      elsif @user.balance < params[:user][:balance].to_f
        amount = params[:user][:balance].to_f - @user.balance
        trading_record.amount = amount
        trading_record.trading_type = TradingRecord::TRADING_TYPE_IN_BY_PLATFORM
        trading_record.name = "后台增加#{amount}"
      end

      if trading_record.save
        redirect_to admin_user_path, notice: "修改余额成功"
      end
    end

    @page_title = "修改余额"
  end
end
