module V1
  class Announcements < Grape::API
    resource :announcements do
      desc "公告接口"
      get do
        present Announcement.order('id DESC').all(), with: Entities::AnnouncementList
      end

      desc "公告详情"
      params do
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        get do
          Announcement.find(params[:id])
        end
      end
    end
  end
end
