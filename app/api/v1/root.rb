module V1
  class Root < Grape::API
    default_format :json
    format :json
    # error_formatter :json, V1::ErrorFormatter

    version 'v1', using: :path

    before do
      error!("401 Unauthorized", 401) unless current_application
    end

    helpers do
      def logger
        API.logger
      end

      def permitted_params
        @permitted_params ||= declared(params, include_missing: false)
      end

      def clean_params(params)
        ActionController::Parameters.new(params)
      end

      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated? :scope => :user
        access_token = params[:access_token] || request.headers['X-Access-Token'];
        access_token && @user = User.find_by_authentication_token(access_token)
      end

      def authenticate!
        error!("401 Unauthorized", 401) unless authenticated
      end

      def current_user
        # warden.user :scope => :user || @user
        @user
      end

      def current_application
        api_key = params[:api_key] || request.headers['X-Api-Key']
        @application ||= Application.where(token: api_key).first
      end

      def client_ip
        env['action_dispatch.remote_ip'].to_s
      end
    end

    mount V1::Accounts
    mount V1::Addresses
    mount V1::Announcements
    mount V1::Areas
    mount V1::AuthCodes
    mount V1::Banners
    mount V1::CarBrands
    mount V1::CarModels
    mount V1::Cars
    mount V1::Coupons
    mount V1::Docs
    mount V1::Feedbacks
    mount V1::Files
    mount V1::MonthCardOrders
    mount V1::MonthCards
    mount V1::Orders
    mount V1::PaymentLogs
    mount V1::Payments
    mount V1::Products
    mount V1::RechargePolicies
    mount V1::Recharges
    mount V1::Stores
    mount V1::SystemMonthCards
    mount V1::SystemProducts
    mount V1::TradingRecords
    mount V1::Users
    mount V1::WashMachines

    add_swagger_documentation hide_documentation_path: true,
      base_path: '/api',
      api_version: 'v1',
      schemes: ['http'],
      # security_definitions: {
      #   api_key: {
      #     type: 'apiKey',
      #     name: 'api_key',
      #     in: 'query'
      #   },
      # },
      info: {
        title: '用户端接口文档',
        contact: {
          name: 'Thinking Song',
          url: 'http://wmstars.com',
          email: 'songlipeng2003@gmail.com'
        },
        description: <<-NOTE
          本接口完全按照REST设计规范进行设计

          [RESTful API 设计指南](http://www.ruanyifeng.com/blog/2014/05/restful_api.html)

          ## 应用key说明
          所有接口调用必须添加api_key,但暂时为了兼容性可以不传，但以后必须所有的接口都传。

          api_key是一个应用的标示，用来统计接口访问情况和添加数据来源等

          api_key 使用方式

          1. 使用header X-Api-Key
          2. 使用url参数 api_key

          ## 登录权限验证

          /accounts/login登录成功后返回用户信息，用户信息中的authentication_token是授权Token
          当访问需要授权的接口时，需要添加token

          token有两种使用方式

          1. 使用header X-Access-Token
          2. 使用url参数 access_token

          当访问需要授权接口时，没有使用授权Tokexn，返回401 Unauthorized
          API测试工具中所有需要授权接口，使用header方式访问

          ## 分页返回header头说明

          ~~~~~~~
          Link: <http://localhost:3000/orders?page=1>; rel="first",
            <http://localhost:3000/orders?page=173>; rel="last",
            <http://localhost:3000/orders?page=6>; rel="next",
            <http://localhost:3000/orders?page=4>; rel="prev"
          Total: 4321
          ~~~~~~~

          ## 状态码（Status Codes）

          * 200 OK - [GET]：服务器成功返回用户请求的数据，该操作是幂等的（Idempotent）。
          * 201 CREATED - [POST/PUT/PATCH]：用户新建或修改数据成功。
          * 204 NO CONTENT - [DELETE]：用户删除数据成功。
          * 400 INVALID REQUEST - [POST/PUT/PATCH]：用户发出的请求有错误，服务器没有进行新建或修改数据的操作，该操作是幂等的。
          * 401 Unauthorized - [*]：表示用户没有权限（令牌、用户名、密码错误）。
          * 403 Forbidden - [*] 表示用户得到授权（与401错误相对），但是访问是被禁止的。
          * 404 NOT FOUND - [*]：用户发出的请求针对的是不存在的记录，服务器没有进行操作，该操作是幂等的。
          * 406 Not Acceptable - [GET]：用户请求的格式不可得（比如用户请求JSON格式，但是只有XML格式）。
          * 410 Gone -[GET]：用户请求的资源被永久删除，且不会再得到的。
          * 422 Unprocesable entity - [POST/PUT/PATCH] 当创建一个对象时，发生一个验证错误。
          * 500 INTERNAL SERVER ERROR - [*]：服务器发生错误，用户将无法判断发出的请求是否成功。

          ## URL说明

          所有返回url全部使用全路径


          ## 返回数据中code说明

          code为0表示争取，其他表示失败
        NOTE
      }
      # models: [V1::Entities::CarBrand, V1::Entities::Car],
      # markdown: GrapeSwagger::Markdown::KramdownAdapter.new
  end
end
