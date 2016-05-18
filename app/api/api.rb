require 'grape-swagger'

class API < Grape::API
  use ActionDispatch::RemoteIp

  mount V1::Root
end
