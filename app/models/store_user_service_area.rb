class StoreUserServiceArea < ActiveRecord::Base
  belongs_to :store_user
  belongs_to :service_area
end
