# Add url helpers into Grape -- https://github.com/intridea/grape/wiki/Grape-and-Rails-Path-Helpers
module WebmqGrapeEntitySetup
  extend ActiveSupport::Concern

  module ClassMethods
    include Rails.application.routes.url_helpers
  end
end

module Grape
  class Endpoint
    include Rails.application.routes.url_helpers
    default_url_options[:host] = ::Rails.application.routes.default_url_options[:host]
  end

  class Entity
    include WebmqGrapeEntitySetup
    cattr_accessor :default_url_options do
      { host: ::Rails.application.routes.default_url_options[:host] }
    end
  end
end