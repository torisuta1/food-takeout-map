# User.all.each do |user|
#   user.posts.create! ([
#     {
#       title: 'テストタイトル',
#       content: 'テストコンテンツ'
#     }
#   ])
# end

# 30.times do |n|
#   Post.create! (
#     {
#     title:"テスト#{n+1}回目",
#     content: "テスト#{n+1}回目の投稿",
#     user_id: '25'
#     }
#   )
# end

5.times do |n|
  User.create! ([
    username: "テスト#{n+1}",
    email: "test#{n+1}@example.com",
    password: "password",
    confirmed_at: Time.current
])
end