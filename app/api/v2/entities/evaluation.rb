module V1
  module Entities
    class Evaluation < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :score, documentation: { type: Integer, desc: '分数' }
      expose :score1, documentation: { type: Integer, desc: '分数1' }
      expose :score2, documentation: { type: Integer, desc: '分数2' }
      expose :score3, documentation: { type: Integer, desc: '分数3' }
      expose :note, documentation: { type: String, desc: '备注' }
      expose :created_at, documentation: { type: String, desc: '评价时间' }
      expose :images, documentation: { type: Array, desc: '图片' } do |evaluation|
        images = []
        evaluation.images.each do |image|
          images << image.file.url
        end
        images
      end
    end
  end
end
