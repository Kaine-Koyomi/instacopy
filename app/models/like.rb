class Like
  include Mongoid::Document
  belongs_to :post
  belongs_to :user

  validates :post_id, uniqueness: { scope: :user_id, message: "post já está curtido" }
end
