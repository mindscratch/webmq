require 'spec_helper'

describe QueueFacade do
  let(:backend) { ArrayBackend.new }
  let(:queue) { QueueFacade.new 'test', backend}

  describe "#initialize" do
    it "should accept a queue name" do
      expect(queue.queue_name).to eq "test"
    end

    it "should accept a backend" do
      expect(queue.backend).to eq backend
    end
  end

  describe "#enqueue" do
    it "the queue length should increase by 1" do
      expect(queue.count).to eq 0
      queue.enqueue({val: 123})
      expect(queue.count).to eq 1
    end

    it "should return a message" do
      message = queue.enqueue({val: 123})
      expect(message[:id]).to_not be_nil
    end
  end

  describe "#dequeue" do
    context "when there are messages in the queue" do
      it "the queue length should decrease by 1" do
        queue.enqueue({val: 123})
        size = queue.count
        queue.dequeue
        expect(queue.count).to eq (size - 1)
      end

      it "should return a message" do
        queue.enqueue({val: 123})
        size = queue.count
        message = queue.dequeue
        expect(message[:id]).to_not be_nil
      end

      it "should remove the first message from the queue" do
        first = queue.enqueue({val: 123})
        second = queue.enqueue({val: 555})
        message = queue.dequeue
        expect(message).to eq first
      end
    end

    context "when there are no messages in the queue" do
      it "the queue length stays at 0" do
        expect(queue.count).to eq 0
        queue.dequeue
        expect(queue.count).to eq 0
      end
    end
  end
end