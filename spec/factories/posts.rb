FactoryBot.define do
  factory :post do
    title { "test" }
    content { "hoge_review" }
    user_id {1}
    genre_id {1}
    association :user
    association :genre
    after(:create) do |post|
      create_list(:like, 1, post: post, user: create(:user))
    end
  end

  factory :post2, class: Post do
    title { "hoge" }
    content { "fuga_review" }
    genre_id {1}
    association :user
    association :genre
    after(:create) do |post2|
      create_list(:like, 1, post: post2, user: create(:user))
    end
  end
end
