class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  
  has_many :favorites
  has_many :users, through: :favorites
end
