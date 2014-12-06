module Didi
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    resource :docs do
      desc "文档接口"
      get do
        present Doc.all(), with: Didi::Entities::DocList
      end

      desc "文档详情接口"
      params do
        requires :key, desc: "Key"
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
        requires :id, desc: "ID"
      end
      route_param :id do
        get do
          Announcement.find(params[:id])
        end
      end
    end
  end
end
