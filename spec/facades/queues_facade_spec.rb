require 'spec_helper'

describe QueuesFacade do
  describe "#initialize" do
    it "should accept no arguments" do
      expect {
        QueuesFacade.new
      }.to_not raise_error
    end
  end

  describe "#names_list" do
    it "should return an Array" do
      expect(subject.names_list).to be_kind_of Array
    end

    context "when no queues exist" do
      it "should return an empty Array" do
        expect(subject.names_list).to be_empty
      end
    end

    context "when queues exist" do
      it "should return all queue names"
    end
  end
end