# sidekiq_options retry: 3
# sidekiq_options retry: false
# retry_on attempts: 2

class TestJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: false

  retry_on StandardError, wait: 5.seconds, attempts: 2

  def perform
    raise StandardError, "sidekiq_options retry: false, retry_on: 2"
    # 合計 2 回実行された
    # - 2回実行完了後にraise StandardError
    #   - Sidekiqでは「予定」に追加され、
    #   - 完了次第「完了」に追加される
    # - Sidekiqではリトライされない
    #   - 毎回raise error
  end
end

