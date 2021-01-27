# frozen_string_literal: true

module WhiteRabbit
  class SchedulerService
    class << self
      def create_task(params)
        return unless verify_parameters(params)

        cron_exp = convert_params_to_cron(params)
        job_id = nil
        if Object.const_defined?("WhiteRabbit::#{params[:job_types]}")
          task = Object.const_get("WhiteRabbit::#{params[:job_types]}").new(cron_exp, params[:job_params])
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

          return false unless Object.const_defined?("WhiteRabbit::#{params[:job_types]}")
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

      def verify_parameters(params)
        ranges = {
          minute: 0..59,
          hour: 0..23,
          days: 1..31,
          month: 1..12,
          daysw: 0..6
        }

        time_format = /^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/

        frequency_type = ranges[params[:frequency_type].to_sym]

        return false if frequency_type.nil?

        if params.key?(:time)
          frequency_type.include?(params[:frequency].to_i) && time_format.match?(params[:time])
        else
          frequency_type.include?(params[:frequency].to_i)
        end
      end

      def convert_params_to_cron(params)
        type = params[:frequency_type]
        frequency = params[:frequency].to_i
        exp = if %w[minute hour days].include?(type)
                frequency.to_s + type[0]
              elsif type == 'month'
                %i[jan feb mar apr may jun jul aug sep oct nov dec][frequency]
              else # 'daysw'
                %i[sunday monday tuesday wednesday thursday friday saturday][frequency]
              end

        if params.key?(:time)
          Cronter.convert_to_cron(exp, time: params[:time])
        else
          Cronter.convert_to_cron(exp)
        end
      end
    end
  end
end
