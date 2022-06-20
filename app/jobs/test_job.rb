# 条件に応じてリトライ回数を変えたい場合は以下のようにする
# - sidekiq_options のリトライをfalseにする
# - エラーに応じてretry_on attempts の数値を変える


class RetryOnceError < StandardError; end
class RetryTwiceError < StandardError; end

class TestJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: false

  retry_on RetryOnceError, wait: 5.seconds, attempts: 1
  retry_on RetryTwiceError, wait: 5.seconds, attempts: 2

  def perform
    raise RetryTwiceError, "sidekiq_options retry: false, retry_on: 2"
  end
end

