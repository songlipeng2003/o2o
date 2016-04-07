require 'grape-swagger'

class API < Grape::API
  mount V1::Root
  mount V2::Root
end
