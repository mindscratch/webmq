require 'grape-swagger'

class API < Grape::API
  mount Webmq::Queue
  add_swagger_documentation
end
