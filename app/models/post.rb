class Post < ApplicationRecord
  belongs_to:user
  belongs_to:genre
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 40}
end
