source 'https://ruby.taobao.org/'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use sqli  te3 as the database for Active Record
# gem 'pg', '~> 0.17.1'
# gem 'activerecord-postgis-adapter', '~> 2.2.1'
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
group :development do
  gem 'capistrano', '~> 3.3.3'
  gem 'capistrano-rails', '~> 1.1.2'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-thin'
  gem 'capistrano-sidekiq'
  # gem 'capistrano-nvm', require: false
  # gem 'capistrano-npm'
end

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'factory_girl_rails', '~> 4.3.0'
  gem 'capybara', '~> 2.2.0'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'did_you_mean', '~> 0.9.4'

  gem 'binding_of_caller', '~> 0.7.2'
  gem 'better_errors', '~> 2.0.0'
end

# assets
gem 'bootstrap-generators', '~> 3.2.0'
gem "font-awesome-rails", "~> 4.3.0"
gem "bower-rails", "~> 0.9.2"

# disable assets log
gem 'quiet_assets', '~> 1.0.3', group: :development

# 表单
gem 'simple_form', '~> 3.0.1'

# rails i18n
gem 'rails-i18n', '~> 4.0.0'

# 登陆
gem 'devise', '~> 3.2.2'

# 分页
# gem 'will_paginate', '~> 3.0'
# gem 'will_paginate-bootstrap', '~> 1.0.0'

# tree
gem 'ancestry', '~> 2.1.0'

# admin
gem 'activeadmin', github: 'activeadmin'
gem "active_admin-sortable_tree"

# api
gem 'grape', '~> 0.9.0'
gem 'grape-entity', '~> 0.4.4'
gem 'grape-swagger', '~> 0.9.0'
gem 'api-pagination'
gem 'kramdown'
gem 'grape-swagger-rails', github: 'fabn/grape-swagger-rails', branch: 'grape-swagger-0.8'

# upload
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 3.7.0'

# thin server
gem 'thin', '~> 1.6.3'

# fulltext
gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'elasticsearch-rails', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'

# SMS
gem 'china_sms', '~> 0.0.7'

# asynchronous task
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'sidekiq', '~> 3.3.0'

# 地理坐标系转化
gem 'evil_transform'

# defualt value for model
gem "default_value_for", "~> 3.0.0"

# model version
gem 'paper_trail', '~> 3.0.6'

# alipay
gem 'alipay', '~> 0.3.0'

# status
gem 'aasm', '~> 4.0.8'

gem 'rack-raw-upload', '~> 1.1.1'

# crontab
gem 'whenever', :require => false

# ckeditor
gem 'ckeditor'

# nested forms
gem "cocoon"

gem "rack-cors"

# soft delete
gem "paranoia", "~> 2.0"
