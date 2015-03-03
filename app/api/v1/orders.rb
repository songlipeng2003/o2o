module V1
  class Orders < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :orders do
      desc "订单", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        optional :page, type: Integer, desc: "页码"
        optional :per_page, type: Integer, desc: '每页数量'
      end
      paginate per_page: 10
      get do
        orders = paginate current_user.orders
        present orders, with: V1::Entities::OrderList
      end

      desc "计算订单价格接口", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :car_model_id, type: Integer, desc: "车型编号"
        requires :product_id, type: Integer, desc: "商品类型，1为标准洗车,2为标准打蜡,3为标准抛光,4为标准深清"
        requires :is_include_interior, type: Boolean, desc: "是否包含内饰"
        optional :coupon_id, type: Integer, desc: "代金券编号"
      end
      get :price do
        order = current_user.orders.new
        order.car_model_id = params[:car_model_id]
        order.product_id = params[:product_id]
        order.is_include_interior = params[:is_include_interior]
        order.coupon_id = params[:coupon_id]
        order.cal_total_amount
        {
          original_price: order.original_price,
          total_amount: order.total_amount
        }
      end

      desc "订单详情", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
      end
      route_param :id do
        get do
          present current_user.orders.find(params[:id]), with: V1::Entities::Order
        end
      end

      desc "生成订单", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :phone, type: String, desc: "手机"
        optional :car_id, type: Integer, desc: "汽车编号,汽车编号和汽车详情仅需填写一个"
        optional :car, type: Hash do
          optional :car_model_id, type: Integer, desc: "汽车型号编号"
          optional :color, type: String, desc: "汽车颜色"
          optional :license_tag, type: String, desc: "车牌号"
        end
        mutually_exclusive :car_id, :car
        optional :address_id, type: Integer, desc: "地址编号,地址编号和地址信息仅需填写一个"
        optional :address, type: Hash do
          optional :place, type: String, desc: "地址"
          optional :lon, type: String, desc: "经度"
          optional :lat, type: String, desc: "纬度"
        end
        mutually_exclusive :address, :address_id
        requires :booked_at, type: String, desc: "预约时间，时间格式2014-01-01 01:01:00, 为预约的起始时间"
        optional :is_include_interior, type: Boolean, desc: "是否包含内饰"
        optional :product_id, type: Integer, desc: "商品编号，1、2为标准洗车,其他请使用商品列表返回的商品编号"
        optional :is_underground_park, type: Boolean, desc: "是否在地下停车库"
        optional :coupon_id, type: Integer, desc: "代金券编号"
        optional :carport, type: String, desc: "车位号"
        optional :note, type: String, desc: "订单备注"
      end
      post do
        car_params = permitted_params.delete(:car)
        address_params = permitted_params.delete(:address)
        order = current_user.orders.new(permitted_params)
        order.product_id = 1;
        order.application = current_application
        unless params[:car].blank?
          car_params = clean_params(params).require(:car).permit(:car_model_id, :color, :license_tag)
          car = current_user.cars.where(car_params).first
          unless car
            car = current_user.cars.new(car_params)
          end
          car.save
          order.car_id = car.id
        end

        if params[:address].blank?
          address = current_user.addresses.find(params[:address_id])
        else
          address_params = clean_params(params).require(:address).permit(:place, :lon, :lat)
          address = current_user.addresses.where(address_params).first
          unless address
            address = current_user.addresses.new(address_params)
          end
          address.save
          order.address_id = address.id
        end

        result = Store.in_service_scope(address.lon, address.lat)
        if result.count==0
          return {
            code: 1,
            msg: '不在服务范围内'
          }
        end

        store_id = Store.can_serviced_store(address.lon, address.lat, params[:booked_at])

        unless store_id
          return {
            code: 1,
            msg: '已经被预约，请预约其他时间'
          }
        end

        unless params[:coupon_id].blank?
          coupon = current_user.coupons.find(params[:coupon_id])
          unless coupon.unused?
            return {
              code: 1,
              msg: '当前代金券不可用'
            }
          end
        end

        order.store_id = store_id

        if order.save
          return {
            code: 0,
            data: order
          }
         else
          return {
            code: 2,
            msg: '下单错误，请稍后重试',
            error: order.errors
          }
        end
      end

      desc "评价", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
        requires :score, type: Integer, desc: '评价，1-5'
        optional :note, type: String, desc: '备注'
        optional :images, type: Array
      end
      route_param :id do
        put 'evaluate' do
          order = current_user.orders.find(params[:id])
          error!("404 Not Found", 404) unless order.finished?
          evaluation = order.build_evaluation({
            score: params[:score],
            note: params[:note]
          })

          evaluation.application = current_application
          evaluation.save

          if !params[:images].blank?
            params[:images].each do |image|
              img = current_user.images.new
              img.file = File.open(Rails.root.join('public', 'uploads', 'tmp') + image)
              img.item = evaluation
              img.save
            end
          end

          present evaluation
        end
      end

      desc "余额支付", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
        requires :pay_password, type: String, desc: "支付密码"
      end
      route_param :id do
        put 'pay' do
          order = current_user.orders.find(params[:id])
          error!("404 Not Found", 404) unless order.unpayed?
          if current_user.encrypted_pay_password.blank?
            return {
              code: -1,
              msg: '未设置支付密码'
            }
          end

          if !current_user.validate_pay_password(params[:pay_password])
            return {
              code: -2,
              msg: '支付密码错误'
            }
          end

          if current_user.balance<order.total_amount
            return {
              code: -3,
              msg: '余额不足'
            }
          end

          order.pay
          if order.save
            {
              code: 0
            }
          else
            {
              code: -1,
              msg: '支付失败',
              error: order.errors
            }
          end
        end
      end

      desc "关闭订单", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
      end
      route_param :id do
        put :close do
          order = current_user.orders.find(params[:id])
          error!("404 Not Found", 404) unless order.unpayed? || order.payed?
          order.close
          order.save

          present order, with: V1::Entities::OrderList
        end
      end
    end
  end
end
