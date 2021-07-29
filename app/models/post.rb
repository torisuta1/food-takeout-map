class Post < ApplicationRecord
  belongs_to:user
  belongs_to:genre
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 40}

  def self.search(search, genre)
    if search.blank? && genre.blank?
      return Post.includes(:user)
    elsif search.blank?
      Post.where(genre_id: genre)
    else
      Post.where(['title LIKE ? or content LIKE ? ' , "%#{search}%", "%#{search}%"]).or(Post.where(genre_id: genre)) 
    end
  end
end
