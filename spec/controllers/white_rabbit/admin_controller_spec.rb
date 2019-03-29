require 'rails_helper'

SingleCov.covered! uncovered: 4

RSpec.describe WhiteRabbit::AdminController, type: :controller do
  routes { WhiteRabbit::Engine.routes }

  describe 'GET index' do
    it 'returns successfull' do
      get :index

      expect(response.status).to eq(200)
      expect(response.content_type).to eq('text/html')
    end

    it 'returns task_names' do
      allow_any_instance_of(WhiteRabbit::AdminController).to receive(:task_names).and_return('MyTask')

      get :task_types

      expect(response.status).to eq(200)
      expect(response.body).to eq('MyTask')
    end

    it 'creates task with given parameters' do
      params = { frequencyType: 'min', frequency: 1, jobParams: '', jobTypes: 'MyDummyTask' }
      post :create, params: params

      expect(WhiteRabbit::TaskModel.all.count).to eq(1)
    end

    it 'lists all the tasks' do
      task = FactoryBot.create(:task_model)
      get :fetch_jobs
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).first['id']).to eq(task.id.to_s)
    end

    it 'destroys job with given id' do
      task = FactoryBot.create(:task_model)
      double_job = double(unschedule: true, kill: true)
      allow_any_instance_of(Rufus::Scheduler).to receive(:job).and_return(double_job)

      delete :destroy_job, params: { jobId: task.id }
      expect(response.status).to eq(200)
    end

    it 'returns unprocessable entity if job is not exists' do
      delete :destroy_job, params: { jobId: 100 }

      expect(response.status).to eq(422)
    end
  end
end