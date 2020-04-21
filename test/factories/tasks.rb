# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { generate :string }
    description { generate :string }
    author_id { 1 }
    assignee_id { 1 }
    state { generate :string }
    expired_at { '2020-04-09' }
  end
end
