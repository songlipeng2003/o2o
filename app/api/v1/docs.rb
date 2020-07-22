module V1
  class Docs < Grape::API
    resource :docs do
      desc "文档接口",
        is_array: true,
        entity: V1::Entities::DocList
      get do
        present Doc.all(), with: V1::Entities::DocList
      end

      desc "文档详情接口"
      params do
        requires :key, type: String, desc: "Key"
      end
      route_param :key do
        get do
          Doc.where('key=?', params[:key])
        end
      end
    end
  end
end
