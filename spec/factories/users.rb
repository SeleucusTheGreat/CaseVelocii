FactoryBot.define do 
    factory :user do 
        sequence(:email) { |i| "foo_#{i}@email.com"}
        password {"123456"}
    end
end