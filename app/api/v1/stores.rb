module V1
  class Stores < Grape::API

    resource :stores do
      desc "根据经纬度获取能够提供服务的店铺,未实现，暂时返回第一个店铺"
      params do
        requires :lon, type: Float, desc: "经度"
        requires :lat, type: Float, desc: "纬度"
      end
      get 'search' do
        present Store.page(1).per(1)
      end
    end
  end
end
