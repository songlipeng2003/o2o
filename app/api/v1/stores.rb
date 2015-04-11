module V1
  class Stores < Grape::API

    resource :stores do
      desc "获取店铺列表"
      params do
        optional :store_type, type: Integer, desc: "店铺类型"
        optional :system_product_id, type: Integer, desc: "系统商品Id"
        optional :range, type: String, desc: "范围"
      end
      paginate per_page: 10
      get do
        stores = Store.all
        stores = paginate stores
        present stores, with: V1::Entities::Store
      end


      desc "根据经纬度获取是否提供服务"
      params do
        requires :lon, type: Float, desc: "经度"
        requires :lat, type: Float, desc: "纬度"
      end
      get 'in_service_scope' do
        result = StoreUserServiceArea.in_service_scope(params[:lon], params[:lat])
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
        booked_at = params[:booked_at].to_time
        if !booked_at ||  (booked_at <=> Time.now)<=0
          return {
            result: false
          }
        end
        result = StoreUserServiceArea.can_serviced(params[:lon], params[:lat], booked_at)
        {
          result: result
        }
      end
    end
  end
end
