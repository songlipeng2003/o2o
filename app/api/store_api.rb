require 'grape-swagger'

class StoreAPI < Grape::API
  mount StoreV1::Root
end
