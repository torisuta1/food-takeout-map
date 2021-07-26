class Genre < ApplicationRecord
  validates :genre, presence: true
  has_many :posts, dependent: :destroy
end
