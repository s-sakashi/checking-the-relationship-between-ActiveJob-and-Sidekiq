class TestJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: false

  retry_on StandardError, wait: 1.second, attempts: 2

  def perform
    raise StandardError, "sidekiq_options retry: false"
    # 2回実行完了後にraise StandardError
  end
end
