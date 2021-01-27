require_dependency 'white_rabbit/application_controller'

module WhiteRabbit
  class AdminController < ApplicationController
    def index
      @jobs = task_names
      @scheduled_jobs = TaskModel.all
      render :index
    end

    def create
      task = SchedulerService.create_task(create_job_params)

      if task
        redirect_to :index, flash: { notice: 'Task Created' }
      else
        redirect_to :index, flash: { error: 'Couldn\'t create issue' }
      end
    end

    def fetch_jobs
      render json: TaskModel.all.to_json.camelize
    end

    def destroy_job
      res = SchedulerService.kill_task(params_for_destroy_job[:job_id])

      if res
        redirect_to :index
      else
        redirect_to :index, flash: { error: "Couldn't kill the task" }
      end
    end

    private

    # TODO: cache this one
    def task_names
      root_path = Rails.root.join('app', 'schedule', 'white_rabbit')

      return [] unless Pathname.new(root_path).exist?

      file_names = Dir.entries(root_path)
      file_names
        .select { |fn| File.extname(fn) == '.rb' }
        .map { |fn| fn.gsub('.rb', '').camelize }
    end

    def params_for_destroy_job
      params.permit(:jobId).to_h.to_snake_keys.with_indifferent_access
    end

    def create_job_params
      params.permit(
        :frequencyType,
        :frequency,
        :jobParams,
        :jobTypes,
        :time,
        :authenticity_token,
        :commit
      ).to_h.to_snake_keys.with_indifferent_access
    end
  end
end
