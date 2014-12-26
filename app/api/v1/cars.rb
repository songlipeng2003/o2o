module V1
  class Cars < Grape::API
    resource :cars do
      desc "汽车"
      get do
        present current_user.cars.all
      end

      desc "汽车详情"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          present current_user.cars.find(params[:id])
        end
      end

      desc "添加汽车"
      params do
        requires :car_model_id, type: Integer, desc: "车型id"
        requires :license_tag, type: String, desc: "拍照"
        requires :buy_date, type: String, desc: "购买日期"
      end
      post do
        present current_user.cars.create(params)
      end

      desc "编辑汽车"
      params do
        # requires :id, type: Integer, desc: "ID"
        requires :car_model_id, type: Integer, desc: "车型id"
        requires :license_tag, type: String, desc: "拍照"
        requires :buy_date, type: String, desc: "购买日期"
      end
      route_param :id do
        post do
          car = current_user.cars.find(params[:id])
          present car.update(params)
        end
      end

      desc "删除汽车"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        delete do
          car = current_user.cars.find(params[:id])
          present car.delete
        end
      end
    end
  end
end
