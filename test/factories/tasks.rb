# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name
    description
    expired_at { nil }

    association :author, factory: :manager
    association :assignee, factory: :developer
  end
end
