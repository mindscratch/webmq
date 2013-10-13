require 'spec_helper'

describe QueueFacade do
  describe "#initialize" do
    it "should accept a queue name" do
      queue = QueueFacade.new "test"
      expect(queue.queue_name).to eq "test"
    end
  end

  describe "#enqueue" do
    it "the queue length should increase by 1"
    it "should add an item to the queue"
    it "should return a message"
  end

  describe "#dequeue" do
    it "the queue length should decrease by 1"
    it "should remove the first item from the queue"
    it "should return a message"
  end
end