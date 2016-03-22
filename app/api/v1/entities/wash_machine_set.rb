module V1
  module Entities
    class WashMachineSet < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名称' }
      expose :price, documentation: { type: Float, desc: '价格' }
      expose :image, documentation: { type: String, desc: '图片' } do |wash_machine_set|
        wash_machine_set.image.thumb.url
      end
      expose :description, documentation: { type: String, desc: '描述' }
    end
  end
end
