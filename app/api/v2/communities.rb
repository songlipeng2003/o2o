module V1
  class Communities < Grape::API
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
  end
end
