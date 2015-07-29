module V1
  class Banners < Grape::API
    resource :banners do
      desc "Banner接口"
      get do
        present Banner.all(), with: V1::Entities::Banner
      end
    end
  end
end
