class TestJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: false

  retry_on StandardError, wait: 1.second

  def perform
    raise StandardError, "sidekiq_options retry: false"
    # 5回実行完了後にraise StandardError
  end
end
