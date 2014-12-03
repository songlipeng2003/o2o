if Rails.env.development?
  ApiTaster.routes do
    desc 'Get doc'
    get '/api/v1/docs/:id', {
      :id => 1
    }
  end
end
