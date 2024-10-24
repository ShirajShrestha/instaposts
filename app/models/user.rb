class User < ApplicationRecord
  has_one_attached :photo
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :photo
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
