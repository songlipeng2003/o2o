module V1
  class Products < Grape::API
    resource :products do
      desc "商品列表"
      get do
        products = Product.where('id>2').all
        present products, with: V1::Entities::Product
      end
    end
  end
end
