require 'spec_helper'

describe QueuesFacade do
  let(:backend) { ArrayBackend.new }
  let(:queues) { QueuesFacade.new backend}
  let(:foo_queue) { QueueFacade.new 'foo', backend}
  let(:bar_queue) { QueueFacade.new 'bar', backend}

  describe "#initialize" do
    it "should accept a backend" do
      expect(queues.backend).to eq backend
    end
  end

  describe "#names_list" do
    it "should return an Array" do
      expect(queues.names_list).to be_kind_of Array
    end

    context "when no queues exist" do
      it "should return an empty Array" do
        expect(queues.names_list).to be_empty
      end
    end

    context "when queues exist" do
      it "should return all queue names" do
        foo_queue.enqueue({val: 123})
        bar_queue.enqueue({val: 555})

        names = queues.names_list
        expect(names.size).to eq 2
        expect(names).to include foo_queue.queue_name
        expect(names).to include bar_queue.queue_name
      end
    end
  end
end