module V1
  module Entities
    class Address < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :place, documentation: { type: String, desc: '地点' }
      expose :lat, documentation: { type: String, desc: '经度' }
      expose :lon, documentation: { type: String, desc: '纬度' }
      expose :name, documentation: { type: String, desc: '名称' }
      expose :note, documentation: { type: String, desc: '备注' }
    end
  end
end
