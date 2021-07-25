User.all.each do |user|
  user.posts.create! ([
    {
      title: 'テストタイトル',
      content: 'テストコンテンツ'
    }
  ])
end

30.times do |n|
  Post.create! (
    {
    title:"テスト#{n+1}回目",
    content: "テスト#{n+1}回目の投稿",
    user_id: '25'
    }
  )
end