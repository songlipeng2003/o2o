module V1
  class Announcements < Grape::API
    resource :announcements do
      desc "公告接口",
        is_array: true,
        entity: V1::Entities::AnnouncementList
      paginate per_page: 10
      get do
        announcements = paginate Announcement.order('id DESC')
        present announcements, with: V1::Entities::AnnouncementList
      end

      desc "公告详情",
        entity: V1::Entities::Announcement
      params do
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        get do
          present Announcement.find(params[:id]), with: V1::Entities::Announcement
        end
      end
    end
  end
end
