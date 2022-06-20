# sidekiq_options retry: 3
# retry_on attempts: 2

class TestJob < ApplicationJob
  queue_as :default

  # sidekiq_options retry: false

  retry_on StandardError, wait: 5.seconds, attempts: 2

  def perform
    raise StandardError, "sidekiq_options retry: false"
    # 合計 5 回実行された
    # - 2回実行完了後にraise StandardError
    #   - Sidekiqでは「予定」に追加され、
    #   - 完了次第「完了」に追加される
    # - Sidekiqで3回リトライ
    #   - こちらは再試行で3回リトライ → 完了に+3
  end
end
