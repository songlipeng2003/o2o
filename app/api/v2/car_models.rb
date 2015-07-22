module V1
  class CarModels < Grape::API
    resource :car_models do
      desc "汽车型号接口", hidden: true
      get do
        present CarModel.all, with: V1::Entities::CarModel
      end

      desc "汽车型号详情", hidden: true
      params do
        requires :id, type: Integer, desc: "汽车型号编号"
      end
      route_param :id do
        get do
          present CarModel.find(params[:id]), with: V1::Entities::CarModel
        end
      end
    end
  end
end
