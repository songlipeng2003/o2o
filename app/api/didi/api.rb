module Didi
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    resource :docs do
      get do
        present Doc.all(), with: Didi::Entities::DocList
      end

      desc "Return a doc."
      params do
        requires :key, desc: "key"
      end
      route_param :key do
        get do
          Doc.where('key=?', params[:key])
        end
      end
    end
  end
end
