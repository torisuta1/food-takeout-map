FactoryBot.define do
  factory :post do
    title { "test" }
    content { "hoge_review" }
    association :user
    association :genre
    after(:create) do |post|
      create_list(:like, 1, post: post, user: create(:user))
    end
  end

  factory :post2, class: Post do
    title { "hoge" }
    content { "fuga_review" }
    association :user
    association :genre, factory: :genre2
  end
end
