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
        },
        http_codes: [
         [200, '成功', V1::Entities::OrderList]
        ]
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

      desc "最近订单", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', V1::Entities::Order]
        ]
      }
      get :lastest_order do
        order = current_user.orders.order('id DESC').first
        present order, with: V1::Entities::Order
      end

      desc "计算订单价格接口", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', V1::Entities::OrderPrice]
        ]
      }
      params do
        requires :car_model_id, type: Integer, desc: "车型编号"
        requires :product_id, type: Integer, desc: "商品类型，1为标准洗车,2为标准打蜡,3为标准抛光,4为标准深清"
        requires :is_include_interior, type: Boolean, desc: "是否包含内饰"
        requires :booked_at, type: String, desc: "预约时间，时间格式2014-01-01 01:01:00, 为预约的起始时间"
        optional :license_tag, type: String, desc: "牌照，必须填写"
        optional :coupon_id, type: Integer, desc: "代金券编号"
        optional :service_ticket_code, type: String, desc: "消费券号码"
      end
      get :price do
        order = current_user.orders.new
        order.car_model_id = params[:car_model_id]
        order.product_id = params[:product_id]
        order.is_include_interior = params[:is_include_interior]
        order.coupon_id = params[:coupon_id]
        order.license_tag = params[:license_tag]
        order.booked_at = params[:booked_at]
        service_ticket_code = params[:service_ticket_code]
        service_ticket = ServiceTicket.available.where(code: service_ticket_code).first
        if service_ticket
          order.service_ticket_id = service_ticket.id
        end
        order.cal_total_amount
        {
          original_price: order.original_price,
          total_amount: order.total_amount,
          order_amount: order.order_amount,
          service_ticket_id: order.service_ticket_id,
          month_card_id: order.month_card_id
        }
      end

      desc "订单日期列表", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :product_id, type: Integer, desc: "商品类型，1为标准洗车,2为标准打蜡,3为标准抛光,4为标准深清"
      end
      get :list_available_date do
        dates = 7.times.map do |i|
          case i
          when 0
            text = '今天'
          when 1
            text = '明天'
          when 2
            text = '后天'
          else
            text = i.days.from_now.strftime('%m-%d')
          end
          { date: i.days.from_now.strftime('%Y-%m-%d'), text: text}
        end
        dates
      end

      desc "选择时间列表", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :date, type: String, desc: '日期'
        requires :product_id, type: Integer, desc: "商品类型，1为标准洗车,2为标准打蜡,3为标准抛光,4为标准深清"
        requires :lon, type: Float, desc: "经度"
        requires :lat, type: Float, desc: "纬度"
      end
      get :list_available_time do
        start_time = params[:date] + ' 08:00:00'
        start_time = start_time.to_time
        11.times.map do |i|
          begin_time = start_time + i.hours
          end_time = begin_time + 1.hours
          text = begin_time.strftime('%H:%M') + '-' + end_time.strftime('%H:%M')
          result = Store.can_serviced(params[:lon], params[:lat], begin_time.to_time)
          {
            begin_time: begin_time.strftime('%Y-%m-%d %H:%M:%S'),
            end_time: end_time.strftime('%Y-%m-%d %H:%M:%S'),
            text: text,
            result: result
          }
        end
      end

      desc "订单详情", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', V1::Entities::Order]
        ]
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
        },
        http_codes: [
         [200, '成功', V1::Entities::Order]
        ]
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
          optional :note, type: String, desc: "备注"
        end
        mutually_exclusive :address, :address_id
        requires :booked_at, type: String, desc: "预约时间，时间格式2014-01-01 01:01:00, 为预约的起始时间"
        optional :booked_end_at, type: String, desc: "预约结束时间，时间格式2014-01-01 01:01:00, 为预约的结束时间"
        optional :is_include_interior, type: Boolean, desc: "是否包含内饰"
        requires :product_id, type: Integer, desc: "商品编号，1、2为标准洗车,其他请使用商品列表返回的商品编号"
        optional :is_underground_park, type: Boolean, desc: "是否在地下停车库"
        optional :coupon_id, type: Integer, desc: "代金券编号"
        optional :carport, type: String, desc: "车位号"
        optional :service_ticket_code, type: String, desc: '消费券号码'
        optional :note, type: String, desc: "订单备注"
      end
      post do
        car_params = permitted_params.delete(:car)
        address_params = permitted_params.delete(:address)
        service_ticket_code = permitted_params.delete :service_ticket_code

        order = current_user.orders.new(permitted_params)
        order.product_id = permitted_params[:product_id];
        order.application = current_application

        booked_at = params[:booked_at].to_time
        if !booked_at ||  (booked_at <=> Time.now)<=0
          return {
            code: 1,
            msg: '预定时间错误'
          }
        end

        unless params[:car].blank?
          car_params = clean_params(params).require(:car).permit(:car_model_id, :color, :license_tag)
          car = current_user.cars.where(car_params).first
          unless car
            car = current_user.cars.new(car_params)
            car.application = current_application
          end
          unless car.save
            return {
              code: 1,
              msg: car.errors.values[0][0]
            }
          end
          order.car_id = car.id
        end

        if params[:address].blank?
          address = current_user.addresses.find(params[:address_id])
        else
          address_params = clean_params(params).require(:address).permit(:place, :lon, :lat)
          address = current_user.addresses.where(place: address_params[:place]).first
          unless address
            address = current_user.addresses.new(address_params)
            address.application = current_application
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

        store_user_id = Store.can_serviced_store(address.lon, address.lat, booked_at)

        unless store_user_id
          return {
            code: 1,
            msg: '已经被预约，请预约其他时间'
          }
        end

        if params[:coupon_id]
          coupon = current_user.coupons.find(params[:coupon_id])
          unless coupon.unused?
            return {
              code: 1,
              msg: '当前代金券已经使用'
            }
          end
        end

        if coupon && coupon.system_coupon.product_id && order.coupon_id &&
          coupon.system_coupon.product_id != order.product_id
          return {
            code: 1,
            msg: '当前代金券不满足当前商品'
          }
        end

        if coupon && coupon.system_coupon.product_id && order.coupon_id &&
          coupon.system_coupon.product_type_id != order.product.product_type_id
          return {
            code: 1,
            msg: '当前代金券不满足当前商品类型'
          }
        end

        unless service_ticket_code.blank?
          service_ticket = ServiceTicket.available.where(code: service_ticket_code).first
          if service_ticket
            order.service_ticket_id = service_ticket.id
          else
            return {
              code: 1,
              msg: '当前消费券不可用'
            }
          end
        end

        if order.booked_end_at.blank?
          order.booked_end_at = (order.booked_at + 1.hours)
        end

        order.store_user_id = store_user_id

        if order.save
          return {
            code: 0,
            data: order.reload
          }
         else
          return {
            code: 2,
            msg: order.errors.values[0][0]
          }
        end
      end

      desc "评价", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', V1::Entities::Evaluation]
        ]
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
        optional :score, type: Integer, desc: '评价，0-5分'
        optional :score1, type: Integer, desc: '评价1，0-5分'
        optional :score2, type: Integer, desc: '评价2，0-5分'
        optional :score3, type: Integer, desc: '评价3，0-5分'
        optional :note, type: String, desc: '备注'
        optional :images, type: Array
      end
      route_param :id do
        post 'evaluate' do
          order = current_user.orders.find(params[:id])
          error!("404 Not Found", 404) unless order.finished?
          evaluation = order.build_evaluation({
            score: params[:score],
            score1: params[:score1],
            score2: params[:score2],
            score3: params[:score3],
            note: params[:note],
            store_user_id: order.store_user_id
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

          present evaluation, with: V1::Entities::Evaluation
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

          payment = Payment.where(code: :balance).first
          payment_log = order.payment_logs.where(payment_id: payment.id).order('id DESC').first
          unless payment_log && payment_log.unpayed?
            payment_log = order.payment_logs.build({
              payment: payment,
              name: order.product.name,
              amount: order.total_amount
            })
            payment_log.application = current_application
            payment_log.save
          end

          payment_log.pay

          if payment_log.save
            {
              code: 0
            }
          else
            {
              code: -1,
              msg: '支付失败'
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
        },
        http_codes: [
         [200, '成功', V1::Entities::OrderList]
        ]
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
      end
      route_param :id do
        put :close do
          order = current_user.orders.find(params[:id])
          error!("404 Not Found", 404) unless order.unpayed? || order.payed?
          order.close(current_user)
          order.save

          present order, with: V1::Entities::OrderList
        end
      end

      desc "删除订单", {
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
        delete do
          order = current_user.orders.find(params[:id])
          order.destroy
          status 204
          # { code: 0 }
        end
      end

      desc "选择支付方式", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
        requires :payment_id, type: Integer, desc: "支付编号"
        optional :open_id, type: String, desc: "OpenId, 微信公众号支付时需要"
      end
      route_param :id do
        post :payment do
          order = current_user.orders.find(params[:id])
          error!("404 Not Found", 404) unless order.unpayed?
          payment = Payment.find(params[:payment_id])
          payment_log = order.payment_logs.where(payment_id: params[:payment_id]).order('id DESC').first
          unless payment_log && payment_log.unpayed?
            payment_log = order.payment_logs.build({
              payment: payment,
              name: order.product.name,
              amount: order.total_amount
            })
            payment_log.application = current_application
            payment_log.save
          end

          payment_log.extras = { open_id: params[:open_id] } unless params[:open_id].blank?

          present payment_log, with: V1::Entities::PaymentLog
        end
      end
    end
  end
end
