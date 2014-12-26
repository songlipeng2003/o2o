module V1
  class Root < Grape::API
    error_formatter :json, V1::ErrorFormatter

    mount V1::Announcements
    mount V1::Areas
    mount V1::AuthCodes
    mount V1::Banners
    mount V1::CarBrands
    mount V1::CarModels
    mount V1::Cars
    mount V1::Communities
    mount V1::Docs
    mount V1::Orders
  end
end
