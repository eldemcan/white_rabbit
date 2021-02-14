# frozen_string_literal: true

module WhiteRabbit
  class SchedulerService
    class << self
      def create_task(params)
        return unless verify_cron(params)

        job_id = nil
        if Object.const_defined?("WhiteRabbit::#{params[:job_type]}")
          task = Object.const_get("WhiteRabbit::#{params[:job_type]}").new(params[:cron].chomp, params[:job_params])
          job_id = schedule_task(task)
        else
          root_path = Rails.root.join('app', 'schedule', 'white_rabbit')
          file_names = Dir.entries(root_path)
          file_names.each do |fn|
            if File.extname(fn) == '.rb'
              require fn
              Rails.logger.info("Reloading #{rb}")
            end
          end

          return false unless Object.const_defined?("WhiteRabbit::#{params[:job_type]}")
        end

        WhiteRabbit::TaskModel.save_task(task, job_id)
      end

      def kill_task(job_id)
        job = Rufus::Scheduler.singleton.job(job_id)
        job&.unschedule
        job&.kill
        task = WhiteRabbit::TaskModel.find_by(job_id: job_id)
        task&.destroy
      end

      def clean_tasks
        WhiteRabbit::TaskModel.delete_all
      end

      private

      def schedule_task(task)
        Rufus::Scheduler.singleton.cron(task.interval, task)
      end

      def verify_cron(params)
        cron_exp = params[:cron].chomp

        return false if cron_exp.blank?

        begin
          Rufus::Scheduler.parse(cron_exp)
        rescue ArgumentError
          false
        end
      end
    end
  end
end
