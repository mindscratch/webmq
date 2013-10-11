require 'spec_helper'

describe Webmq::Queue do
  describe "GET /queues" do
    it "returns an empty array" do
      get "/queues"
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to be_empty
    end
  end

  describe "GET /q/:queue/dequeue" do
    it "dequeues the first item in the queue" do
      get "/q/bar/dequeue"
      expect(response.status).to eq 200
      expect(response.body).to eq({val: "foo-bar"}.to_json)
    end
  end

  describe "POST /q/:queue" do
    let(:data) { {val: 123} }
    let(:queue_name) { "bar" }

    it "enqueues the given data"

    it "sets the Location header" do
      id = 1234
      Webmq.should_receive(:generate_id).and_return { id }

      post "/q/#{queue_name}", data

      location = response.headers['Location']
      expect(location).to match /q\/#{queue_name}\/#{id}/
    end
  end
end