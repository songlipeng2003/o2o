module V1
  class WashMachineSets < Grape::API
    resource :wash_machine_sets do
      desc "洗车机套餐接口", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', V1::Entities::WashMachineSet]
        ]
      }
      params do
        requires :code, type: Integer, desc: "洗车机设备码"
        optional :city_id, type: Integer, default: 917, desc: "城市编号, 默认值917为郑州"
      end
      get do
        present WashMachineSet.all(), with: Entities::WashMachineSet
      end
    end
  end
end
