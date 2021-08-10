class Post < ApplicationRecord
  belongs_to:user
  belongs_to:genre
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
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
