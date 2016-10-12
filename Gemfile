ruby '2.2.5'
source 'https://rubygems.org'

# Setup Rails and API
gem 'rails', '>= 5.0.x'
gem 'pg'

# Setup server
gem 'puma'

# Asset compilation and NPM modules
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'

# Setup react and dependencies
gem 'mini_racer'

# Setup Octokit and HTTP cache
gem 'httparty'
gem 'sidekiq'
gem 'redis'
gem 'redis-namespace'

# Setup caching and Marshalling
gem 'readthis'
gem 'hiredis'
gem 'oj'
gem 'dalli'

# Throttle Malacious requests
gem 'rack-attack'

# Speed up links
gem 'turbolinks', '~> 5.0.x'

# Omniauth login
gem 'omniauth-github'
gem 'devise'

# CORS
gem 'rack-cors', :require => 'rack/cors'

# Slim rails
gem 'slim-rails'

# Client side routes
gem 'js-routes'

# Graphql
gem 'graphql'

# Auth token
gem 'jwt'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'graphiql-rails'
  gem 'spring'
  gem 'foreman'
  gem 'figaro'
end
