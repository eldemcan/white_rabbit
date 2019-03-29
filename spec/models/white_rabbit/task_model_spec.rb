# frozen_string_literal: true

require 'rails_helper'

SingleCov.covered!

RSpec.describe WhiteRabbit::TaskModel, type: :model do
  describe 'creating task model' do
    it 'creates valid model successfully' do
      task = WhiteRabbit::MyDummyTask.new('*/1 * * * *', '')
      res = WhiteRabbit::TaskModel.save_task(task, 100)
      expect(WhiteRabbit::TaskModel.all.count).to eq(1)
      expect(WhiteRabbit::TaskModel.first.id).to eq(res.id)
    end
  end
end
