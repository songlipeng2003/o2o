module V1
  class Banners < Grape::API
    resource :banners do
      desc "Banner接口", {
        is_array: true,
        entity: V1::Entities::Banner
      }
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        present Banner.all(), with: V1::Entities::Banner
      end
    end
  end
end
