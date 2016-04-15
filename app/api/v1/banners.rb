module V1
  class Banners < Grape::API
    resource :banners do
      desc "Banner接口", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        is_array: true,
        entity: V1::Entities::Banner
      }
      get do
        present Banner.all(), with: V1::Entities::Banner
      end
    end
  end
end
