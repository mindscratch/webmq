require 'webmq'

module Webmq
  class Queue < Grape::API

    format :json

    helpers do
      include BackendStrategy

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

      # @param request [Rack::Request]  the request
      # @param resource_name [String]   the name of the resource
      # @param message [Hash]           the message
      # @return [String]
      def build_message_url(request, resource_name, message)
        url = "#{request.scheme}://#{request.host}"
        unless [80, 443].include? request.port
          url.concat(":#{request.port}")
        end
        url.concat "/#{resource_name}/#{message[:queue_name]}/#{message[:id]}"
      end
    end

    desc "Return the list of available queues"
    resource :queues do
      get do
        QueuesFacade.new(backend).names_list
      end
    end

    resource :q do
      desc "Dequeue the first item"
      params do
        requires :queue_name, type: String, desc: "The name of the queue"
      end
      route_param :queue_name do
        get :dequeue do
          queue = QueueFacade.new params[:queue_name], backend
          message = queue.dequeue
          message
        end
      end

      desc "Enqueue an item"
      params do
        requires :queue_name, type: String, desc: "the name of the queue"
        # TODO add headers?
        requires :payload, type: Hash, desc: "the payload to enqueue"
      end
      route_param :queue_name do
        post do
          queue = QueueFacade.new params[:queue_name], backend
          message = queue.enqueue params[:payload]

          request = Rack::Request.new env
          url = build_message_url request, resource_name, message
          header 'Location', url
          message
        end
      end
    end
  end
end
