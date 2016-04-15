module V1
  module Entities
    class Announcement < Grape::Entity
      expose :id
      expose :title
      expose :content
      expose :created_at
      expose :updated_at
    end
  end
end
