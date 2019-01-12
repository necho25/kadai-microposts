class User < ApplicationRecord
  before_save {self.email.downcase!} #保存する前に全ての文字を小文字に変換
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, #emailを表す正規表現
            uniqueness: {case_sensitive: false} #大文字と小文字の区別をせず同じものと見なす
  
  has_secure_password
  
  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  has_many :favorites
  has_many :favos, through: :favorites, source: :micropost
  # has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'micropost_id'
  # has_many :favoers, through: :reverses_of_favorite, source: :user
  
  def like(other_micropost)
   # unless self == other_micropost #micropost.user_idを参照させる？
    self.favorites.find_or_create_by(micropost_id: other_micropost.id)
   #end
  end
  
  def unlike(other_micropost)
    favorite = self.favorites.find_by(micropost_id: other_micropost.id) #other_micropostが引数だから検索もother_micropost
    favorite.destroy if favorite
  end
  
  def favos?(other_micropost) #has_manyで設定したfavosがあるかどうか
    self.favos.include?(other_micropost)
  end
end