module V1
  class Banners < Grape::API
    resource :banners do
      desc "Banner接口"
      get do
        present Banner.all(), with: Entities::Banner
      end
    end
  end
end
