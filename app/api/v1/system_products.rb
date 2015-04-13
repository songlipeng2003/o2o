module V1
  class SystemProducts < Grape::API
    resource :system_products do
      desc "系统商品列表"
      params do
        optional :category_id, type: Integer, desc: '分类编号'
      end
      get do
        system_products = SystemProduct.where('0=0')
        if params[:category_id]
          system_products = system_products.where(category_id: params[:category_id])
        end
        present system_products, with: V1::Entities::SystemProduct
      end
    end
  end
end
