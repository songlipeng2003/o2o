ActiveAdmin.register RechargePolicy do
  menu parent: '促销'

  permit_params :amount, :present_amount, :note, { system_coupon_ids: [] }

  index do
    selectable_column
    id_column
    column :amount
    column :present_amount
    column :created_at
    actions
  end

  filter :amount
  filter :present_amount
  filter :note
  filter :created_at

  form do |f|
    f.inputs do
      f.input :amount
      f.input :present_amount
      f.input :system_coupons, as: :check_boxes
      f.input :note
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :amount
      row :present_amount
      row :system_coupons do
        content = ''
        recharge_policy.system_coupons.each do |system_coupon|
          content << link_to(system_coupon.name, admin_system_coupon_path(system_coupon))
        end
        raw(content)
      end
      row :note
      row :created_at
      row :updated_at
    end
  end
end
