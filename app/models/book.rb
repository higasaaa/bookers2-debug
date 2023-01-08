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
  
  #検索機能
  def self.looks(searches, words)
    if searches == "perfect_mach"
      @user = User.where("name LIKE ?", "#{words}%") #whereメソッドとは、テーブル内の条件に一致したレコードを配列の形で取得する
    elsif searches == "forward_match"
      @user = User.where("name Like ?", "%#{words}")
    elsif searches =="backward_match"
      @user = User.where("name LIKE ?", "#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end
end
