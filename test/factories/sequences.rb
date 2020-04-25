# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  sequence :first_name do |n|
    "first_name#{n}"
  end

  sequence :password do |n|
    "password#{n}"
  end

  sequence :last_name do |n|
    "last_name#{n}"
  end

  sequence :avatar do |n|
    "avatar#{n}"
  end

  sequence :name do |n|
    "name#{n}"
  end

  sequence :description do |n|
    "description#{n}"
  end

  sequence :expired_at do |n|
    "expired_at#{n}"
  end
end
