module V1
  class WashMachines < Grape::API
    resource :wash_machines do
      desc "洗车机查询接口", {
        is_array: true,
        entity: V1::Entities::WashMachine
      }
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :code, type: String, desc: "洗车机设备码"
      end
      get do
        list =  WashMachine.where(code: params[:code]).all()

        present list, with: Entities::WashMachine
      end
    end
  end
end
