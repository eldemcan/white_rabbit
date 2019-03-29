# frozen_string_literal: true

module WhiteRabbit
  class SchedulerService
    class << self
      def create_task(params)
        return unless verify_parameters(params)

        cron_exp = convert_params_to_cron(params)
        task = Object.const_get("WhiteRabbit::#{params[:job_types]}").new(cron_exp, params[:job_params])
        job_id = schedule_task(task)
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
          min: 0..59,
          hour: 0..23,
          days: 1..31,
          month: 1..12,
          daysw: 0..6
        }

        frequency_type = ranges[params[:frequency_type].to_sym]

        !frequency_type.nil? &&
          frequency_type.include?(params[:frequency].to_i) &&
          ranges[:min].include?(params[:minutes].to_i) &&
          ranges[:hour].include?(params[:hours].to_i)
      end

      def convert_params_to_cron(params)
        type = params[:frequency_type]
        frequency = params[:frequency].to_i
        exp = if %w[min hour days].include?(type)
                frequency.to_s + type[0]
              elsif type == 'month'
                %i[jan feb mar apr may jun jul aug sep oct nov dec][frequency]
              else # 'daysw'
                %i[sunday monday tuesday wednesday thursday friday saturday][frequency]
              end

        if params.key?(:hours) && params.key?(:minutes)
          time_format = "#{params[:hours]}:#{params[:minutes]}"
          Cronter.convert_to_cron(exp, time: time_format)
        else
          Cronter.convert_to_cron(exp)
        end
      end
    end
  end
end
