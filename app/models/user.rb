class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed #フォロー・フォロワーの一覧画面で、user.followersという記述でフォロワーを表示
  has_many :followers, through: :reverse_of_relationships, source: :follower #throughでスルーするテーブル、sourceで参照するカラムを指定

  # belongs_to :books User:Bookが、多:1になっている

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
    # redirect_to 
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
    #redirect_to 
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
end
