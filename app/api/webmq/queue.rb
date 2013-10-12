require 'webmq'

module Webmq
  class Queue < Grape::API
    format :json

    helpers do
      def resource_name
        name = nil
        routes.find do |route|
          resource = route.route_path.split(route.route_prefix).last.match('\/([\w|-]*?)[\.\/\(]').captures.first
          if resource
            name = resource
            break
          end
        end
        name
      end

      # @param [Rack::Request]  request     the request
      # @param [String] resource_name       the name of the resource
      # @param [String] queue_name          the name of the queue
      # @param [String,Numeric] item_id     the ID of the item the URL will reference
      # @return [String]
      def build_item_url(request, resource_name, queue_name, item_id)
        url = "#{request.scheme}://#{request.host}"
        unless [80, 443].include? request.port
          url.concat(":#{request.port}")
        end
        url.concat "/#{resource_name}/#{queue_name}/#{item_id}"
      end
    end

    desc "Return the list of available queues"
    resource :queues do
      get do
        []
      end
    end

    resource :q do
      desc "Dequeue the first item"
      params do
        requires :queue_name, type: String, desc: "The name of the queue"
      end
      route_param :queue_name do
        get :dequeue do
          {val: "foo-#{params[:queue_name]}"}
        end
      end

      desc "Enqueue an item"
      params do
        requires :queue_name, type: String, desc: "The name of the queue"
      end
      route_param :queue_name do
        post do
          request = Rack::Request.new env
          url = build_item_url request, resource_name, params[:queue_name], Webmq.generate_id
          header 'Location', url
          {val: 123}
        end
      end
    end
  end
end
