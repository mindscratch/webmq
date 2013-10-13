# The Queue facade is responsible for performing queue related operations using an appropriate strategy
class QueueFacade
  attr_reader :queue_name

  def initialize(queue_name)
    @queue_name = queue_name
  end

  # Enqueue a message
  #
  # @param payload [Hash] the data for the message
  #
  # @return [Hash] the message  #TODO this could return an actual Message object
  def enqueue(payload)
    message_id = Webmq.generate_id
    message = {id: message_id, queue_name: queue_name, payload: payload}
    message
  end

  def dequeue(message_id)
  end
end