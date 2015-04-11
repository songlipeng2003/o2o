module V1
  class Products < Grape::API
    resource :products do
      desc "商品列表"
      params do
        optional :city_id, type: Integer, default: 917, desc: '城市编号，默认为917郑州'
        optional :category_id, type: Integer, desc: '分类编号'
        optional :product_type, type: Integer, values: Product::PRODUCT_TYPES.keys, default: 1,
          desc: "商品类型，1为上门商品，2为到店商品，默认为上门"
      end
      get do
        products = Product.where('0=0')
        if params[:city_id]
          products = products.joins(:store).where(stores: { city_id: params[:city_id] })
        end
        if params[:category_id]
          products = products.where(category_id: params[:category_id])
        end
        if params[:product_type]
          products = products.where(product_type: params[:product_type])
        end
        present products, with: V1::Entities::Product
      end
    end
  end
end
