require 'grape-swagger'

module Didi
  class API < Grape::API
    version 'v1', using: :path
    default_format :json
    format :json

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    helpers do
      def logger
        API.logger
      end
    end

    resource :docs do
      desc "文档接口"
      get do
        present Doc.all(), with: Didi::Entities::DocList
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

    resource :banners do
      desc "Banner接口"
      get do
        present Banner.all(), with: Didi::Entities::Banner
      end
    end

    resource :announcements do
      desc "公告接口"
      get do
        present Announcement.order('id DESC').all(), with: Didi::Entities::AnnouncementList
      end

      desc "公告详情"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          Announcement.find(params[:id])
        end
      end
    end

    resource :communities do
      desc "社区接口"
      params do
        optional :keyword, type: String, desc: "关键词"
      end
      get do
        query = {
           query:
            {
              bool: {
              should: [
                {
                  multi_match:{
                    query: params[:keyword],
                    fields: [:name, :address],
                    operator: 'and',
                  }
                }
              ]
            }
          },
          filter: {
            # location: {
            #   distance: "20000km",
            #   'pin.location' => "40, 70"
            # }
          },
          facets: {},
          # sort: {
          #   "_geo_distance"=>{
          #     'pin.location' => "40, 70",
          #     order: "asc",
          #     unit: "km"
          #   }
          # }
        }

        logger.debug query.to_yaml

        @communities = Community.__elasticsearch__.search(query)
        # @communities = Community.search(params[:keyword])
      end
    end

    add_swagger_documentation hide_documentation_path: true,
      base_path: '/api',
      api_version: 'v1'
  end
end
