# frozen_string_literal: true

module WhiteRabbit
  class JobService
    class << self
      def run_job(job_name, job_params)
        # extract requiring logic to common module and added here service
        return false unless Object.const_defined?(job_name)

        task = Object.const_get(job_name).new(job_params)
        task.call(nil, nil)
      end
    end
  end
end
