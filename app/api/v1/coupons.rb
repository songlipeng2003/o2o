module V1
  class Coupons < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :coupons do
      desc "代金券接口", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      get do
        coupons = current_user.coupons.unused.select('*, COUNT(*) AS count').group(:system_coupon_id)
        present coupons, with: V1::Entities::Coupon
      end

      desc "下单前，查询可用代金券接口", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :product_id, type: Integer, desc: "商品编号"
      end
      get :order do
        coupons = current_user.coupons.includes(:system_coupon)
          .where(system_coupons: {product_id: params[:product_id]}).unused
        present coupons, with: V1::Entities::Coupon
      end
    end
  end
end
