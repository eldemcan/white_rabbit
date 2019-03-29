# frozen_string_literal: true

module WhiteRabbit
  class MyTask
    attr_reader :interval, :job, :params

    def initialize(interval = '', params)
      @interval = interval
      @params = params
    end

    # duck type
    def call(job, _time)
      @job = job
      Rails.logger.info("[HELLO WORLD] #{params}")
      p "Hello world, Job_id: #{job.id}"
    end
  end
end
