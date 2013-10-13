# The QueuesFacade is responsible for working with a collection of queues, as opposed
# to the QueueFacade which deals with a single queue.
class QueuesFacade
  def initialize
  end

  # Get the list of queue names.
  #
  # @return [String]  the queue names
  def names_list
    []
  end
end