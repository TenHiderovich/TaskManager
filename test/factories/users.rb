# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name
    last_name
    password
    email
    avatar

    trait :developer do
      type { 'Developer' }
    end

    trait :manager do
      type { 'Manager' }
    end

    trait :admin do
      type { 'Admin' }
    end
  end
end
