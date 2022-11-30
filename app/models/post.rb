class Post
  include Mongoid::Document
  include Mongoid::Paperclip
  
  field :body, type: String


  validates :body, presence:  true 

  belongs_to :created_by, class_name: "User"
  has_many :comments
  has_many :likes
  has_mongoid_attached_file :photo
  validates_attachment :photo, presence: true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "image/jfif"] }

  def liked_by?(user)
    likes.where(user: user).exists?
  end
end
