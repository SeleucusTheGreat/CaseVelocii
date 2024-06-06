FactoryBot.define do
    factory :user do
      sequence(:email) { |n| "user#{n}@example.com" }
      sequence(:full_name) { |n| "user#{n}name" }
      provider {"email"}
      password { "password" }
      password_confirmation { "password" }
    end
  end