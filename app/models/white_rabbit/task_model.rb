# frozen_string_literal: true
module WhiteRabbit
  class TaskModel < ApplicationRecord
    validates :interval, presence: true
    validates :job_id, presence: true
    validates :job_class, presence: true

    def self.save_task(task, job_id)
      create(
        job_class: task.class.to_s,
        job_id: job_id,
        interval: task.interval,
        params: task.params
      )
    end
  end
end
