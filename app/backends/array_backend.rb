require 'atomic'


class ArrayBackend
  def initialize
    @messages = Atomic.new([])
  end

  # Store a message
  #
  # @param [Hash] message
  #
  # @return [Hash]
  def store(message)
    @messages.update { |arr| arr.push message }
    message
  end

end