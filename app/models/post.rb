class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :photo

  validates :photo, :description, presence: true
  acts_as_votable
end
