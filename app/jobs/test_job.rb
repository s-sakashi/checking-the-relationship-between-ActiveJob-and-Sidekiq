class TestJob < ApplicationJob
  queue_as :default

  retry_on StandardError, attempts: 2, wait: 3.seconds

  def perform
    # raise StandardError
    Rails.logger.warn("Test!!!!!!!!!!")
    retry_job wait: 3.seconds, attempts: 2
  end
end
