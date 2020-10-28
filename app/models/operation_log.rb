class OperationLog < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :application
end
