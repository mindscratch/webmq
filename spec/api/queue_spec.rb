require 'spec_helper'

describe Webmq::Queue do
  describe "api helpers" do
    let(:api) { obj = Object.new; obj.extend Webmq::Queue.helpers; obj}

    describe "#build_message_url" do
      context "when port is 80" do
        it "should not include the port in the URL" do
          request = double "request"
          request.stub(:scheme) { "http" }
          request.stub(:host) { "example.com" }
          request.stub(:port) { 80 }
          message = {queue_name: :foo, id: 123}
          url = api.build_message_url request, 'q', message
          expect(url).to_not match /80/
        end
      end

      context "when port is 443" do
        it "should not include the port in the URL" do
          request = double "request"
          request.stub(:scheme) { "http" }
          request.stub(:host) { "example.com" }
          request.stub(:port) { 443 }
          message = {queue_name: :foo, id: 123}
          url = api.build_message_url request, 'q', message
          expect(url).to_not match /443/
        end
      end

      context "when port is anything but 80 or 443" do
        it "should not include the port in the URL" do
          request = double "request"
          request.stub(:scheme) { "http" }
          request.stub(:host) { "example.com" }
          request.stub(:port) { 8080 }
          message = {queue_name: :foo, id: 123}
          url = api.build_message_url request, 'q', message
          expect(url).to match /8080/
        end
      end
    end
  end

  describe "GET /queues" do
    it "responsds with a 200" do
      get "/queues"
      expect(response.status).to eq 200
    end

    it "returns an empty array" do
      get "/queues"
      expect(JSON.parse(response.body)).to be_empty
    end

    it "should invoke QueuesFacade#names_list" do
      QueuesFacade.any_instance.should_receive(:names_list).and_call_original
      get "/queues"
    end
  end

  describe "GET /q/:queue/dequeue" do
    let(:queue_name) { "bar" }
    it "dequeues the first item in the queue" do
      message = {id: 1234, payload: {}, queue_name: queue_name}
      QueueFacade.any_instance.should_receive(:dequeue).with(no_args).and_return(message)

      get "/q/#{queue_name}/dequeue"

      expect(response.status).to eq 200
      expect(response.body).to eq(message.to_json)
    end
  end

  describe "POST /q/:queue" do
    let(:data) { {val: 123} }
    let(:queue_name) { "bar" }

    it "enqueues the given data" do
      QueueFacade.any_instance.should_receive(:enqueue).with(an_instance_of(Hashie::Mash)).and_call_original
      post "/q/#{queue_name}", payload: data
    end

    it "sets the Location header" do
      message = {id: 1234, payload: {}, queue_name: queue_name}
      QueueFacade.any_instance.should_receive(:enqueue).and_return(message)
      post "/q/#{queue_name}", payload: data

      location = response.headers['Location']
      expect(location).to match /q\/#{message[:queue_name]}\/#{message[:id]}/
    end
  end
end