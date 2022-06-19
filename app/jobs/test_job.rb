class TestJob < ApplicationJob
  queue_as :default

  retry_on StandardError, attempts: 2, wait: 3.seconds

  def perform
    raise StandardError
  end
end
