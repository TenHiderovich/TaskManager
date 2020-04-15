FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    password { "" }
    email { "user@mail.ru" }
    avatar { "MyString" }
    type { "" }
  end
end
