FactoryBot.define do
  factory :genre do
    id {1}
    genre { "1500円以下" }
  end

  factory :genre2, class: 'Genre' do
    id {2}
    genre { "1500円以上" }
  end
end
