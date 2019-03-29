FactoryBot.define do
  factory :task_model, class: WhiteRabbit::TaskModel do
    job_class { 'WhitRabbit::MyDummyTask' }
    job_id { 1 }
    interval { '*/1 * * * *' }
    params { '' }
  end
end