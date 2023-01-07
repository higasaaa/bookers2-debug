class Relationship < ApplicationRecord
 belongs_to :follower, class_name: "User"
 belongs_to :followed, class_name: "User"
# followerのみだとfollowersテーブルを参照しにいってしまうため、エラーになるその為クラス名（モデル名）を指定
end
