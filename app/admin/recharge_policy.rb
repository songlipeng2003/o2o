ActiveAdmin.register RechargePolicy do
  menu parent: '促销'

  config.sort_order = 'sort_desc, id_desc'
  config.batch_actions = false

  permit_params :amount, :present_amount, :note, :sort, :show, { recharge_policies_system_coupons_attributes: [:id, :system_coupon_id, :number, :_destroy] }

  index do
    id_column
    column :amount
    column :present_amount
    column :sort
    column :show
    column :created_at
    actions
  end

  filter :amount
  filter :present_amount
  filter :note
  filter :show
  filter :created_at

  form :partial => "form"

  show do
    attributes_table do
      row :id
      row :amount
      row :present_amount
      row :sort
      row :system_coupons do
        content = ''
        recharge_policy.recharge_policies_system_coupons.each do |recharge_policies_system_coupon|
          content << link_to("#{recharge_policies_system_coupon.system_coupon.name} #{recharge_policies_system_coupon.number}张",
              admin_system_coupon_path(recharge_policies_system_coupon.system_coupon))
          content << '<br/>'
        end
        raw(content)
      end
      row :show
      row :note
      row :created_at
      row :updated_at
    end
  end
end
