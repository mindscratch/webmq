module BackendStrategy
  def backend
    Rails.configuration.backend
  end
end