FactoryBot.define do
  factory :user do
    username {"hoge"}
    sequence(:email) { |n| "hoge#{n}@example.com"}
    password {"password"}
    password_confirmation {"password"}
    agreement {true}
  end

  factory :other_user, class: 'User' do
    username {"hoge2"}
    sequence(:email) { |n| "hogehoge#{n}@example.com"}
    password {"password2"}
    password_confirmation {"password2"}
    agreement {true}
  end

  factory :hoge_user, class: 'User' do
    username {"hoge3"}
    sequence(:email) { |n| "hogefuga1@example.com"}
    password {"password2"}
    password_confirmation {"password2"}
    agreement {true}
    confirmed_at {Time.now}
  end
end
