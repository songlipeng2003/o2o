module V1
  class Areas < Grape::API
    resource :areas do
      desc "区域接口"
      get do
        present Area.arrange_serializable({ order: 'id' })
      end
    end
  end
end
