module V1
  class Products < Grape::API
    resource :products do
      desc "商品列表", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', V1::Entities::Product]
        ]
      }
      params do
        optional :city_id, type: Integer, default: 917, desc: "城市编号, 默认值917为郑州"
        optional :category_id, type: Integer, default: 2, desc: "商品分类, 1为洗车，2为美容"
      end
      get do
        products = Product
        if params[:city_id]
          products = products.where(city_id: params[:city_id])
        end

        if params[:category_id]
          products = products.where(category_id: params[:category_id])
        end
        present products, with: V1::Entities::Product
      end
    end
  end
end
