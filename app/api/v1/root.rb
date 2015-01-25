module V1
  class Root < Grape::API
    default_format :json
    format :json
    # error_formatter :json, V1::ErrorFormatter

    version 'v1', using: :path

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    helpers do
      def logger
        API.logger
      end

      def permitted_params
        @permitted_params ||= declared(params, include_missing: false, include_parent_namespaces: false)
      end

      def clean_params(params)
        ActionController::Parameters.new(params)
      end

      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated? :scope => :user
        $access_token = params[:access_token] || request.headers['X-Access-Token'];
        $access_token && @user = User.find_by_authentication_token($access_token)
      end

      def authenticate!
        error!("401 Unauthorized", 401) unless authenticated
      end

      def current_user
        # warden.user :scope => :user || @user
        @user
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
    # mount V1::Communities
    mount V1::Docs
    mount V1::Files
    mount V1::Orders
    mount V1::RechargePolicies
    mount V1::Recharges
    mount V1::Stores
    mount V1::TradingRecords
    mount V1::Users

    add_swagger_documentation hide_documentation_path: true,
      base_path: '/api',
      api_version: 'v1',
      info: {
        title: '嘀嘀去哪儿接口文档',
        contact: 'songlipeng2003@gmail.com',
        description: <<-NOTE
          本接口完全按照REST设计规范进行设计

          [RESTful API 设计指南](http://www.ruanyifeng.com/blog/2014/05/restful_api.html)

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
        NOTE
      },
      models: [V1::Entities::CarBrand, V1::Entities::Car],
      markdown: GrapeSwagger::Markdown::KramdownAdapter
  end
end
