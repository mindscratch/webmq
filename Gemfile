source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'rails-api'
gem 'puma'

gem 'sqlite3', '~> 1.3.7', :platforms => [ :ruby ]
gem 'activerecord-jdbcsqlite3-adapter', "~> 1.2.9", :platforms => [ :jruby ]

gem 'atomic'

# API
gem 'grape'
gem 'grape-swagger'

group :development, :test do
  gem 'yard'
  gem 'rspec-rails'

  if ENV["CI"]
    # code coverage
    gem "coveralls", require: false
  end
end
