class Book < ApplicationRecord
  # has_many :user
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user) #引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる
    favorites.exists?(user_id: user.id)
  end
end
