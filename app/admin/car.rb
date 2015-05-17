ActiveAdmin.register Car do
  menu parent: '汽车'

  scope :all, default: true do |scope|
    scope.where("deleted_at IS NULL")
  end

  scope :deleted do |scope|
    scope.only_deleted
  end

  index do
    selectable_column
    id_column
    column :user
    column :car_model
    column :license_tag
    column :color
    column :application
    column :created_at
    column :updated_at
    actions defaults: false do |car|
      content = link_to '查看', admin_car_path(car)
      content << ' '
      content << link_to('编辑', edit_admin_car_path(car)) if car.deleted?
      content << ' '
      if car.deleted?
        content << link_to('恢复', restore_admin_car_path(car), method: :put)
      else
        content << link_to('删除', admin_car_path(car), method: :delete)
      end
      raw content
    end
  end

  filter :user_phone, as: :string
  filter :license_tag
  filter :color
  filter :car_model_name, as: :string
  filter :created_at
  filter :updated_at

  member_action :restore, method: :put do
    Car.with_deleted.find(params[:id]).restore
    redirect_to :back, notice: "恢复成功"
  end

  controller do
    def show
      @car = Store.with_deleted.find(params[:id])
    end

    # def scoped_collection
    #   Store.with_deleted
    # end
  end
end
