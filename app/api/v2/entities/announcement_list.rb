module V1
  module Entities
    class AnnouncementList < Grape::Entity
      expose :id
      expose :title
      expose :created_at
    end
  end
end
