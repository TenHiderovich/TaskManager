# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'create' do
    task = create :task
    assert task.persisted?
  end
end
