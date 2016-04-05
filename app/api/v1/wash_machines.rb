module V1
  class WashMachines < Grape::API
    resource :wash_machines do
      desc "洗车机查询接口", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', V1::Entities::WashMachine]
        ]
      }
      params do
        requires :code, type: String, desc: "洗车机设备码"
      end
      get do
        list =  WashMachine.where(code: params[:code]).all()

        present list, with: Entities::WashMachine
      end
    end
  end
end
