class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.id == 1
      can :manage, :all
    else
      can :read, ActiveAdmin::Page, :name => "Dashboard"

      user.roles.each do |role|
        role.permissions.each do |p|
          action = p.action.to_sym
          subject_class = p.subject_class

          begin
            if p.subject_id.nil?
              can action, subject_class.constantize
            else
              can action, subject_class.constantize, :id => p.subject_id
            end
          rescue => e
            Rails.logger.info "#{action}"
            Rails.logger.info "#{subject_class}"
          end
        end
      end
    end
  end
end
