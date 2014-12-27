module V1
  class Root < Grape::API
    default_format :json
    format :json
    error_formatter :json, V1::ErrorFormatter

    version 'v1', using: :path

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    helpers do
      def logger
        API.logger
      end
    end

    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    helpers do
      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated?
        params[:access_token] && @user = User.find_by_authentication_token(params[:access_token])
      end

      def current_user
        warden.user || @user
      end
    end

    mount V1::Announcements
    mount V1::Areas
    mount V1::AuthCodes
    mount V1::Banners
    mount V1::CarBrands
    mount V1::CarModels
    mount V1::Cars
    mount V1::Communities
    mount V1::Docs
    mount V1::Orders

    add_swagger_documentation hide_documentation_path: true,
      base_path: '/api',
      api_version: 'v1'
  end
end
