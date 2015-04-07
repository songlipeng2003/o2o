ActiveAdmin.register Recharge do
  menu parent: '财务'

  actions :index, :show, :new

  scope :all, :default => true

  scope :unpayed do |scope|
    scope.where(state: :unpayed)
  end

  scope :payed do |scope|
    scope.where(state: :payed)
  end

  scope :closed do |scope|
    scope.where(state: :closed)
  end

  index do
    selectable_column
    id_column
    column :user
    column :amount
    column :recharge_policy
    column :state do |recharge|
      recharge.aasm.human_state
    end
    column :created_at
    column :payed_at
    actions
  end

  filter :amount
  filter :state
  filter :created_at
  filter :payed_at

  show do
    attributes_table do
      row :id
      row :user
      row :amount
      row :recharge_policy
      row :state do |recharge|
        recharge.aasm.human_state
      end
      row :created_at
      row :payed_at
      row :closed_at
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :amount
      f.input :recharge_policy
    end
    f.actions
  end

  controller do
    def create
      @recharge = Recharge.new(params[:recharge].permit(:user_id, :amount, :recharge_policy_id))
      if @recharge.save
        @payment_log = @recharge.payment_logs.new
        @payment_log.payment = Payment.find_by code: :offline
        @payment_log.application = Application.find_by name: '后台'
        @payment_log.name = "充值#{@recharge.amount}元"
        @payment_log.amount = @recharge.amount
        @payment_log.save
        @payment_log.pay!

        redirect_to admin_recharge_path(@recharge)
      else
        render :new
      end
    end
  end
end
