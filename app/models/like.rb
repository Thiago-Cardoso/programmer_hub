class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :post, uniqueness: { scope: :user, message: "You already liked this post" }
  validates :post, :user, presence: true
end
