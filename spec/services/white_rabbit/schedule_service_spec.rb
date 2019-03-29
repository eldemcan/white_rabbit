# frozen_string_literal: true

require 'rails_helper'

SingleCov.covered! uncovered: 6, file: 'app/services/white_rabbit/scheduler_service.rb'

describe WhiteRabbit::SchedulerService do
  let(:params) { { frequency_type: 'min', frequency: 1, job_params: '', job_types: 'MyDummyTask' } }

  before do
    allow(WhiteRabbit::SchedulerService).to receive(:schedule_task).and_return(1)
  end

  it 'creates a task with given parameters' do
    WhiteRabbit::SchedulerService.create_task(params)
    created_job = WhiteRabbit::TaskModel.first

    expect(WhiteRabbit::TaskModel.all.count).to eq(1)
    expect(created_job.interval).to eq('*/1 * * * *')
    expect(created_job.job_id).to eq('1')
    expect(created_job.job_class).to eq('WhiteRabbit::MyDummyTask')
    expect(created_job.params.empty?).to be true
  end

  it 'does not create task with invalid parameters' do
    params = { frequency_type: 'min', frequency: 100, job_params: '', job_types: 'MyDummyTask' }
    WhiteRabbit::SchedulerService.create_task(params)
    created_job = WhiteRabbit::TaskModel.first

    expect(created_job).to be nil
  end

  it 'kills given tasks' do
    described_class.create_task(params)
    double_job = double(unschedule: true, kill: true)
    allow_any_instance_of(Rufus::Scheduler).to receive(:job).with(1).and_return(double_job)

    expect(double_job).to receive(:unschedule)
    expect(double_job).to receive(:kill)

    described_class.kill_task(1)

    expect(WhiteRabbit::TaskModel.all.count).to eq(0)
  end

  it 'cleans tasks' do
    described_class.create_task(params)

    described_class.clean_tasks

    expect(WhiteRabbit::TaskModel.all.count).to eq(0)
  end
end
