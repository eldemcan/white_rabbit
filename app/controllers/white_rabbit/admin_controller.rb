require_dependency "white_rabbit/application_controller"

module WhiteRabbit
  class AdminController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render :index
    end

    def task_types
      render json: task_names || ''
    end

    def create
      SchedulerService.create_task(create_job_params)

      head :ok
    end

    def fetch_jobs
      render json: TaskModelSerializer.new(TaskModel.all).serializable_hash[:data]
    end

    def destroy_job
      res = SchedulerService.kill_task(params_for_destroy_job[:job_id])

      if res
        head :ok
      else
        head :unprocessable_entity
      end
    end

    private

    # cache this one
    def task_names
      root_path = Rails.root.join('white_rabbit', 'app', 'schedule', 'white_rabbit')
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
        :hours,
        :minutes
      ).to_h.to_snake_keys.with_indifferent_access
    end
  end
end
