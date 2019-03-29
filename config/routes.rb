# frozen_string_literal: true

WhiteRabbit::Engine.routes.draw do
  get 'index', action: :index, controller: 'admin'
  get 'tasks', action: :task_types, controller: 'admin'
  get 'fetch_jobs', action: :fetch_jobs, controller: 'admin'
  post 'create', action: :create, controller: 'admin'
  post 'destroy_job', action: :destroy_job, controller: 'admin'
end
