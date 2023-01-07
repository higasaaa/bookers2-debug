class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, scope: :user_id #userは1つの投稿に対して１つしかいいねをつけられないようにするため
end
