# 最初の1回失敗のみ

class RetryOnceError < StandardError; end
class RetryTwiceError < StandardError; end

class TestJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: false

  # retry_on RetryOnceError, wait: 5.seconds, attempts: 1
  # retry_on RetryTwiceError, wait: 5.seconds, attempts: 2

  def perform
    raise RetryTwiceError, "sidekiq_options retry: false"
  end
end

