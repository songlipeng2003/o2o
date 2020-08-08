class Permission < ActiveRecord::Base
  validates :name, presence: true
  validates :subject_class, presence: true
  validates :action, presence: true

  has_and_belongs_to_many :roles

  # 参照代码 https://github.com/activeadmin-plugins/active_admin_role/blob/master/app/models/active_admin/manageable_resource.rb
  def self.import
    namespace = ::ActiveAdmin.application.default_namespace
    ::ActiveAdmin.application.namespaces[namespace].resources.inject([]) do |result, resource|
      class_name = resource.controller.resource_class.to_s
      name       = resource.resource_name.name
      actions    = self.collect_defined_actions(resource)

      permission = Permission.where(subject_class: class_name, action: 'manage').first
      if !permission
        permission = Permission.new
        permission.subject_class = class_name
        permission.action = 'manage'
        name = I18n.t('activerecord.models.' + class_name.underscore, default: class_name) + I18n.t('actions.manage', default: 'manage') + '权限'
        permission.name = name
        permission.save
      end

      result += self.eval_actions(actions).map do |action|
        permission = Permission.where(subject_class: class_name, action: action).first
        if !permission
          permission = Permission.new
          permission.subject_class = class_name
          permission.action = action
          name = I18n.t('activerecord.models.' + class_name.underscore, default: class_name) + I18n.t('actions.' + action, default: action) + '权限'
          permission.name = name
          permission.save
        end
      end
    end
  end

  private
    def self.collect_defined_actions(resource)
      if resource.respond_to?(:defined_actions)
        defined_actions    = resource.defined_actions
        member_actions     = resource.member_actions.map(&:name)
        collection_actions = resource.collection_actions.map(&:name)
        batch_actions      = resource.batch_actions_enabled? ? [:batch_action] : []

        defined_actions | member_actions | member_actions | collection_actions | batch_actions
      else
        resource.page_actions.map(&:name) | [:index]
      end
    end

    def self.eval_actions(actions)
      actions.inject(Set.new) do |result, action|
        result << (self.actions_dictionary[action] || action).to_s
      end
    end

    def self.actions_dictionary
      @_actions_dictionary ||= ::ActiveAdmin::BaseController::Authorization::ACTIONS_DICTIONARY.dup
    end
end
