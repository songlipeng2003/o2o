module V1
  class Products < Grape::API
    resource :products do
      desc "商品列表", {
        is_array: true,
        entity: V1::Entities::Product
      }
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :city_id, type: Integer, default: 917, desc: "城市编号, 默认值917为郑州"
        optional :category_id, type: Integer, default: 2, desc: "商品分类, 1为洗车，2为美容"
        optional :product_type, type: Integer, values: Product::PRODUCT_TYPES.keys, default: 1,
          desc: "商品类型，1为上门商品，2为到店商品，默认为上门"
      end
      get do
        products = Product
        if params[:city_id]
          products = products.where(city_id: params[:city_id])
        end

        if params[:product_type]
          products = products.where(product_type: params[:product_type])
        end

        if params[:category_id]
          products = products.where(category_id: params[:category_id])
        end
        present products, with: V1::Entities::Product
      end
    end
  end
end
