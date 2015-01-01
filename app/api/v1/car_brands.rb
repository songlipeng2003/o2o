module V1
  class CarBrands < Grape::API
    resource :car_brands do
      desc "汽车品牌接口"
      get do
        present CarBrand.order(:first_letter).all, with: V1::Entities::CarBrand
      end

      desc "汽车品牌详情", hidden: true
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          present CarBrand.find(params[:id]), with: V1::Entities::CarBrand
        end
      end
    end
  end
end
