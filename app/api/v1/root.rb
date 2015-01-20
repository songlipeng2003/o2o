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
        NOTE
      },
      models: [V1::Entities::CarBrand, V1::Entities::Car],
      markdown: GrapeSwagger::Markdown::KramdownAdapter
  end
end
