ActiveAdmin.register Application do
  menu parent: '基础数据'

  permit_params :name, :app_type, { app_payments_attributes: [:id, :payment_id, :sort, :_destroy] }

  index do
    selectable_column
    id_column
    column :name
    column :app_type
    actions
  end

  filter :name

  form :partial => "form"

  show do
    attributes_table do
      row :id
      row :name
      row :app_type
      row :token
      row :app_payments do
        content = ''
        application.app_payments.each do |app_payment|
          content << link_to("#{app_payment.payment.name}",
              admin_payment_path(app_payment.payment))
          content << '<br/>'
        end
        raw(content)
      end
      row :created_at
      row :updated_at
    end
  end
end
