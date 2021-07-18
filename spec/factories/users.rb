FactoryBot.define do
  factory :user do
    username {"hoge"}
    sequence(:email) { |n| "hoge#{n}@example.com"}
    password {"password"}
    password_confirmation {"password"}
   
  
  

  factory :other_user do
    username {"hoge2"}
    sequence(:email) { |n| "hogehoge#{n}@example.com"}
    password {"password2"}
    password_confirmation {"password2"}
  end
end
end
