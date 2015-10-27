source 'https://rubygems.org'
gem "audited-activerecord", "~> 3.0"

gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'devise'
gem 'annotate'
gem 'jasper-rails', :git => 'https://github.com/Mahaswami/jasper-rails'
gem 'aasm'
gem 'exception_notification', git: 'git://github.com/alanjds/exception_notification.git'
gem 'cancan'
gem "aws-ses", "~> 0.4.4", :require => 'aws/ses'
gem "spawn", :git => 'git://github.com/rfc2822/spawn'
gem 'dalli'
gem 'prawn'
gem 'whenever', :require => false
gem 'auto-session-timeout'

#A session store that avoids the pitfalls usually associated with concurrent access to the session
gem 'smart_session', :git => 'https://github.com/fcheung/smart_session_store.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'execjs'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
gem 'netzke-core', :git => 'https://github.com/Mahaswami/netzke-core.git', :branch => 'deliver_component_fixes'
#gem 'netzke-core', :path => '/Users/karthik/.rvm/gems/ruby-1.9.2-p290@fasternotes/bundler/gems/netzke-core-d95172bb935b'
#gem 'netzke-core', :path => '/Users/karthik/workspace/netzke_core'

gem 'netzke-basepack', :git => 'https://github.com/Mahaswami/netzke-basepack.git', :branch => 'perf_improv'#, :ref => 'ab98dcb2bb4114322487f25f4d61ca4f25af4293'
gem 'netzke-persistence', :git => 'https://github.com/nomadcoder/netzke-persistence.git'
gem 'netzke-communitypack', :git => 'https://github.com/netzke/netzke-communitypack.git', :tag => 'v0.7.0'
gem 'paperclip'
gem 'paper_trail', '~> 3.0.5'
#gem 'rb-readline'
group :development do
  gem "rails-erd"
end
group :development, :test do
  gem "rspec-rails"
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
end

gem 'flatten_record'

gem 'rainbow'
gem "lograge"
gem 'ruby-geometry'
gem 'geocoder'
gem 'savon'
# FIXME Temporarily commenting out while troubleshooting  related issue 
gem 'stupidedi', :git => 'https://github.com/Mahaswami/stupidedi.git'
#gem 'stupidedi', :path => "~/workspace/stupidedi"
gem 'browser-timezone-rails'
gem 'validation_reflection', :git => 'https://github.com/ncri/validation_reflection.git'
gem 'term-ansicolor', "~> 1.0.7"
gem "rake", "0.9.2"

group :test do
  gem 'cucumber-rails'
  gem 'pickle'
  gem "rspec"
  gem "cucumber"
  gem "watir-webdriver"
  gem "database_cleaner"
end

gem 'newrelic_rpm'
gem 'rubyzip'
