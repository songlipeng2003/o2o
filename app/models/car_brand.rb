class CarBrand < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :first_letter, presence: true

  has_many :car_models

  def self.import
    url = 'http://sta.ganji.com/ng/app/client/app/xiche/pub_page/data/models.json'
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)

    if response.code == "200"
      json = /return(.*)\n\}\);/m.match(response.body)
      json = json[1].gsub(/(\w+):/, '"\1":')
      result = JSON.parse(json)

      result.each do |index, car_brand|
        CarBrand.create({
          id: car_brand['brand_id'],
          name: car_brand['brand_name'],
          first_letter: car_brand['brand_first_char']
        })

        car_brand['seriesList'].each do |index, series|
          CarModel.create({
            id: series['series_id'],
            name: series['series_name'],
            auto_type: series['auto_type'],
            first_letter: series['series_first_char'],
            car_brand_id: car_brand['brand_id']
          })
        end
      end
    else
      logger.error(url+'获取错误')
    end
  end
end
