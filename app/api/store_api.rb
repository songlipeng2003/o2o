require 'grape-swagger'

class StoreAPI < Grape::API
  use ActionDispatch::RemoteIp

  mount StoreV1::Root
end
