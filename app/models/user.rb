class User < ApplicationRecord
  before_save {self.email.downcase!} #保存する前に全ての文字を小文字に変換
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, #emailを表す正規表現
            uniqueness: {case_sensitive: false} #大文字と小文字の区別をせず同じものと見なす
  
  has_secure_password
  has_many :microposts
end
