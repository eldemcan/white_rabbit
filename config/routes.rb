# frozen_string_literal: true

WhiteRabbit::Engine.routes.draw do
  get 'index', action: :index, controller: 'admin'
  get 'tasks', action: :task_types, controller: 'admin'
  post 'create', action: :create, controller: 'admin'
  post 'run_job', action: :run_job, controller: 'admin'
  post 'destroy_job', action: :destroy_job, controller: 'admin'
  get 'scheduled_jobs', action: :fetch_jobs, controller: 'admin'
end
