# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { generate :string }
    last_name { generate :string }
    password { '' }
    email { generate :email }
    avatar { generate :string }
    type { '' }
  end
end
