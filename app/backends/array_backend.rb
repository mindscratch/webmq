require 'atomic'


class ArrayBackend
  def initialize
    @messages = Atomic.new([])
    @queue_names = Atomic.new({})
  end

  # Store a message
  #
  # @param [Hash] message
  #
  # @return [Hash]  the message that was stored
  def store(message)
    @messages.update { |arr| arr.push message }
    @queue_names.update { |hash|
      key = message[:queue_name]
      count = hash[key] || 0
      hash[key] = count + 1
      hash
    }
    message
  end

  # Remove the first item in the backend and return it
  #
  # @return [Hash]  the first message or nil  #TODO not sure about returning nil, might use a 'empty' message
  def first
    @messages.value.shift
  end

  # Return the number of messages
  #
  # @return [Numeric] the number of messages
  def count(queue_name=nil)
    if queue_name
      @queue_names.value[queue_name]
    else
      @messages.value.size
    end
  end

  def queue_names
    @queue_names.value.keys.dup
  end
end