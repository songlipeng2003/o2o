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
        requires :id, type: Integer, desc: "id"
      end
      route_param :id do
        get do
          Doc.find(params[:id])
        end
      end
    end
  end
end
