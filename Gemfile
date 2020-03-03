
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'
# Use mysql as the database for Active Record
# gem 'mysql2', '>= 0.4.4'
gem 'sqlite3'
gem 'haml'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'

end

group :test do
  gem 'capybara', '>= 2.15'

  gem 'webdrivers'

  gem 'webmock'
  gem 'vcr'
  gem 'simplecov', require: false
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "spring-commands-rspec"
  gem 'rspec_junit_formatter'
  gem 'rspec-json_expectations'
  gem 'rspec-html-matchers'
  gem 'shoulda-matchers'

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]



gem "dotenv-rails"
gem "devise"
gem 'omniauth-twitch'
gem 'omniauth-mixer'
gem 'omniauth-streamelements', github: "krtschmr/omniauth-streamelements"
gem 'omniauth-streamlabs'

gem "bitcore_rpc", github: "krtschmr/bitcore_rpc"

gem "simple_form"
gem 'rails-erd', group: :development

gem 'twitch-api', :git => 'https://github.com/mauricew/ruby-twitch-api'
gem "money"
gem 'money-open-exchange-rates'

gem 'rqrcode', github: "krtschmr/rqrcode", branch: "render_method_AS_CSS"

gem 'react-rails'
gem 'state_machines-activerecord'
gem "whenever"
