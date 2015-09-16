class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.id == 1
      can :manage, :all
    elsif user.id ==5
      can :read, ActiveAdmin::Page, :name => "Dashboard"
      can :manage, Order
    else
      can :manage, Address
      can :manage, Announcement
      can :manage, AppVersion
      can :manage, Banner
      can :manage, BigCustomer
      can :manage, BigCustomerUser
      can :manage, Car
      can :manage, CarBrand
      can :manage, CarModel
      can :manage, Coupon
      can :manage, Doc
      can :manage, Evaluation
      can :manage, Finance
      can :manage, LoginHistory
      can :manage, MonthCard
      can :manage, MonthCardOrder
      can :manage, Order
      can :manage, PaymentLog
      can :manage, PaymentRefundLog
      can :manage, Product
      can :manage, ProductType
      can :manage, Recharge
      can :manage, RechargePolicy
      can :manage, RefundBatch
      can :manage, ServiceTicket
      can :manage, ServiceTicketBatch
      can :manage, Store
      can :manage, StoreUser
      can :manage, SystemCoupon
      can :manage, SystemMonthCard
      can :manage, TradingRecord
      can :manage, User
      can :manage, AuthCode

      can :read, ActiveAdmin::Page, :name => "Dashboard"
      can :read, ActiveAdmin::Page, :name => "User Report"
      can :read, ActiveAdmin::Page, :name => "Order Report"
      can :read, ActiveAdmin::Page, :name => "Recharge Report"
    end
  end
end
