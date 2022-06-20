class TestJob < ApplicationJob
  queue_as :default

  retry_on StandardError

  def perform
    raise StandardError
    # このコードでも6回以上再試行された
    # 考えうることとしては、、、
    # -  毎回raise error のたびにリトライ（5回）が実行されるため、
    #    同じエラーが出続ける限り無限に再試行される
  end
end
