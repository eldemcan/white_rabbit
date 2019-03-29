Rails.logger.info('Cleaning existing tasks')
if ActiveRecord::Base.connection.data_source_exists? WhiteRabbit::TaskModel.table_name
  WhiteRabbit::SchedulerService.clean_tasks
else
  Rails.logger.info("#{WhiteRabbit::TaskModel.table_name} is not exists yet")
end