require 'grape-swagger'

module Didi
  class API < Grape::API
    version 'v1', using: :path
    default_format :json
    format :json

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    helpers do
      def logger
        API.logger
      end
    end

    resource :areas do
      desc "区域接口"
      get do
        present Area.arrange_serializable({ order: 'id' })
      end
    end

    resource :car_brands do
      desc "汽车品牌接口"
      get do
        present CarBrand.order(:first_letter).all
      end

      desc "汽车品牌详情"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          CarBrand.find(params[:id])
        end
      end
    end

    resource :car_models do
      desc "汽车型号接口"
      get do
        present CarModel.all, with: Didi::Entities::CarModelList
      end

      desc "汽车型号详情"
      params do
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        get do
          CarModel.find(params[:id])
        end
      end
    end

    resource :docs do
      desc "文档接口"
      get do
        present Doc.all(), with: Didi::Entities::DocList
      end

      desc "文档详情接口"
      params do
        requires :key, type: String, desc: "编号"
      end
      route_param :key do
        get do
          Doc.where('key=?', params[:key])
        end
      end
    end

    resource :banners do
      desc "Banner接口"
      get do
        present Banner.all(), with: Didi::Entities::Banner
      end
    end

    resource :announcements do
      desc "公告接口"
      get do
        present Announcement.order('id DESC').all(), with: Didi::Entities::AnnouncementList
      end

      desc "公告详情"
      params do
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        get do
          Announcement.find(params[:id])
        end
      end
    end

    resource :communities do
      desc "社区接口"
      params do
        optional :keyword, type: String, desc: "关键词"
      end
      get do
        query = {
           query:
            {
              bool: {
              should: [
                {
                  multi_match:{
                    query: params[:keyword],
                    fields: [:name, :address],
                    operator: 'and',
                  }
                }
              ]
            }
          },
          filter: {
            # location: {
            #   distance: "20000km",
            #   'pin.location' => "40, 70"
            # }
          },
          facets: {},
          # sort: {
          #   "_geo_distance"=>{
          #     'pin.location' => "40, 70",
          #     order: "asc",
          #     unit: "km"
          #   }
          # }
        }

        logger.debug query.to_yaml

        @communities = Community.__elasticsearch__.search(query)
        # @communities = Community.search(params[:keyword])
      end
    end

    resource :auth_code do
      desc '发送邮件验证码'
      params do
        requires :phone, type: String, desc: "手机号"
      end
      post do
        phone = params[:phone]
        code = AuthCode.generate phone
        tpl_params = { code: code, company: '嘀嘀去哪儿' }
        ChinaSMS.to phone, tpl_params, tpl_id: 1
      end
    end

    resource :users do
      desc "注册"
      params do
        requires :phone, type: String, desc: "手机号"
        requires :code, type: String, desc: "验证码"
        requires :password, type: String, desc: "密码"
      end
      post 'register' do
        is_valid = AuthCode.validate_code(params[:phone], params[:code])

        if is_valid
          user = User.new({
            email: User.random_email,
            phone: params[:phone],
            password: params[:password],
            password_confirmation: params[:password]
          })

          if user.save
            user
          else
            {
              message: user.errors
            }
          end
        else
          {
            message: '验证码失败'
          }
        end
      end
    end

    add_swagger_documentation hide_documentation_path: true,
      base_path: '/api',
      api_version: 'v1'
  end
end
