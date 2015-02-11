module V1
  class Stores < Grape::API

    resource :stores do
      desc "根据经纬度获取是否提供服务"
      params do
        requires :lon, type: Float, desc: "经度"
        requires :lat, type: Float, desc: "纬度"
      end
      get 'in_service_scope' do
        result = Store.in_service_scope(params[:lon], params[:lat])
        {
          result: result.count>0
        }
      end

      desc "根据经纬度和服务时间获取是否提供服务"
      params do
        requires :lon, type: Float, desc: "经度"
        requires :lat, type: Float, desc: "纬度"
        requires :booked_at, type: String, desc: "服务时间,时间格式2015-02-11 00:00:00，为服务开始时间"
      end
      get 'can_serviced' do
        result = Store.can_serviced(params[:lon], params[:lat], params[:booked_at])
        {
          result: result
        }
      end
    end
  end
end
