module V1
  class CarBrands < Grape::API
    resource :car_brands do
      desc "汽车品牌接口"
      get do
        present CarBrand.order(:first_letter).all
      end

      desc "汽车品牌详情"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          CarBrand.find(params[:id])
        end
      end
    end
  end
end
