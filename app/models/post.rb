class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 40 }

  def self.search(search, genre)
    if search.blank? && genre.blank?
      Post.preload(:user, :images, :likes)
    elsif search.blank?
      Post.preload(:user, :images, :likes).where(genre_id: genre)
    else
      Post.preload(:user, :images, :likes).where(["title LIKE ? or content LIKE ? ", "%#{search}%", "%#{search}%"]).or(Post.where(genre_id: genre))
    end
  end
end
