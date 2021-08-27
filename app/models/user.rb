class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :relationships, foreign_key: "user_id",  dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id",  dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user
  validates :username, presence: true
  validates_acceptance_of :agreement, allow_nil: false, on: :create

  def already_liked?(like, current_user_id)
    like.pluck(:user_id).include?(current_user_id)
  end

  def self.guest
    User.find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "ゲスト"
      user.agreement = true
      user.confirmed_at = Time.now
    end
  end
end
