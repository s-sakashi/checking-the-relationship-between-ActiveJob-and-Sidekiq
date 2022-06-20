# sidekiq_options retry: 3
# retry_on attempts: 2

class AnotherJob < ApplicationJob
  queue_as :default

  # sidekiq_options retry: false

  retry_on StandardError, wait: 5.seconds, attempts: 2

  def perform
    raise StandardError, "sidekiq_options retry: 3, retry_on attempts: 3"
    # 合計 5 回実行された
    # - 2回実行完了後にraise StandardError
    # - Sidekiqでは3回リトライ
  end
end

