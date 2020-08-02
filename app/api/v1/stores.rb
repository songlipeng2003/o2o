module V1
  class Stores < Grape::API

    resource :stores do
      desc "获取店铺列表"
      params do
        optional :store_type, type: Integer, desc: "店铺类型"
        optional :product_type, type: Integer, desc: "商品类型"
        optional :top_left, type: String, desc: "左上角坐标，例如：40.73,-74.1"
        optional :bottom_right, type: String, desc: "右下角坐标，例如：40.73,-74.1"
      end
      paginate per_page: 10
      get do
        query = {
          query:{
            filtered: {
              query: {
                match_all: {}
              },
              filter: {
              }
            }
          }
        }

        if params[:store_type]
          query[:query][:filtered][:query][:match_all][:match] = { store_type: params[:store_type]}
        end

        if params[:top_left] && params[:bottom_right]
          query[:query][:filtered][:filter][:geo_bounding_box] = {
            location: {
              top_left: params[:top_left],
              bottom_right: params[:bottom_right]
            }
          }
        end

        logger.debug query.to_yaml

        stores = Product.__elasticsearch__.search query
        stores = paginate stores
        stores = stores.map { |store| Store.find(store._source.store_id) }
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

      desc "店铺详情"
      params do
        requires :id, type: String, desc: "店铺编号"
      end
      route_param :id do
        get do
          Store.find(params[:id])
        end
      end
    end
  end
end
