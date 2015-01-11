module V1
  class Cars < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :cars do
      desc "汽车", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      get do
        present current_user.cars.all
      end

      desc "汽车详情", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          present current_user.cars.find(params[:id])
        end
      end

      desc "添加汽车", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :car_model_id, type: Integer, desc: "车型id"
        requires :license_tag, type: String, desc: "牌照"
        requires :buy_date, type: String, desc: "购买日期, 格式： 2014-01-01"
        requires :color, type: String, desc: "颜色,直接使用中文名称"
      end
      post do
        present current_user.cars.create(permitted_params)
      end

      desc "编辑汽车", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "ID"
        requires :car_model_id, type: Integer, desc: "车型id"
        requires :license_tag, type: String, desc: "牌照"
        requires :buy_date, type: Date, desc: "购买日期, 格式： 2014-01-01"
        requires :color, type: String, desc: "颜色"
      end
      route_param :id do
        put do
          car = current_user.cars.find(params[:id])
          present car.update(permitted_params)
        end
      end

      desc "删除汽车", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
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
