module V1
  module Entities
    class Evaluation < Grape::Entity
      expose :id
      expose :score
      expose :note
      expose :created_at
      expose :images do |evaluation|
        images = []
        evaluation.images.each do |image|
          images << image.file.url
        end
        images
      end
    end
  end
end
