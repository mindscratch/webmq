class API < Grape::API
  mount Webmq::Queue
end
