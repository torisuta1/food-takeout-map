FactoryBot.define do
  factory :post do
    title { "test" }
    content { "hoge_review" }
    association :user, factory: :hoge_user
    association :genre
    after(:create) do |post|
      create_list(:like, 1, post: post, user: create(:user))
    end
  end

  factory :post2, class: Post do
    title { "hoge" }
    content { "fuga_review" }
    association :user, factory: :hoge_user
    association :genre, factory: :genre2
  end

  factory :post3, class: Post do
    title { "piyo" }
    content { "test_review" }
    association :user, factory: :other_user
    association :genre, factory: :genre3
  end
end
