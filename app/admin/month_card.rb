ActiveAdmin.register MonthCard do
  menu parent: '促销'

  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :car
    column :license_tag
    column :name
    column :started_at
    column :expired_at
    column :use_count
    column :state do |month_card|
      month_card.aasm.human_state
    end
    column :application
    column :created_at
    actions
  end

  filter :license_tag
  filter :state
  filter :started_at
  filter :expired_at
  filter :created_at

  show do
    attributes_table do
      row :id
      row :user
      row :car
      row :license_tag
      row :started_at
      row :expired_at
      row :use_count
      row :state do |recharge|
        recharge.aasm.human_state
      end
      row :application
      row :created_at
      row :updated_at
    end
  end
end
