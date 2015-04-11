module V1
  class SystemProducts < Grape::API
    resource :system_products do
      desc "系统商品列表"
      params do
        optional :category_id, type: Integer, desc: '分类编号'
        optional :product_type, type: Integer, values: Product::PRODUCT_TYPES.keys, default: 1,
          desc: "商品类型，1为上门商品，2为到店商品，默认为上门"
      end
      get do
        system_products = SystemProduct.where('0=0')
        if params[:category_id]
          system_products = system_products.where(category_id: params[:category_id])
        end
        # if params[:product_type]
        #   system_products = system_products.where(product_type: params[:product_type])
        # end
        present system_products, with: V1::Entities::SystemProduct
      end
    end
  end
end
