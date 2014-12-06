module Didi
  module Entities
    class AnnouncementList < Grape::Entity
      expose :title
      expose :created_at
    end
  end
end
