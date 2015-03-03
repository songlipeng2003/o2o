module V1
  module Entities
    class CarBrandCarModel < Grape::Entity
      expose :id, documentation: { type: 'integer', desc: '编号' }
      expose :first_letter, documentation: { type: 'integer', desc: '首字母' }
      expose :name, documentation: { type: 'integer', desc: '名称' }
    end

    class CarBrand < Grape::Entity
      expose :id, documentation: { type: 'integer', desc: '编号' }
      expose :first_letter, documentation: { type: 'integer', desc: '首字母' }
      expose :name, documentation: { type: 'integer', desc: '名称' }
      expose :car_models, using: V1::Entities::CarBrandCarModel,
        documentation: { type: 'V1::Entities::CarBrandCarModel', desc: '汽车型号', is_array: true }
    end
  end
end
