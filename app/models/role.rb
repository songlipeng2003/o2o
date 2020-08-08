class Role < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :permissions, join_table: :roles_permissions
  has_and_belongs_to_many :users
end
