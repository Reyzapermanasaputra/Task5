class Article < ActiveRecord::Base
  #relationship
  has_many :comments
  
  #avatar
  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.jpg"
  validates_attachment :avatar, presence: true, size: {less_than: 1.megabytes}, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"]}
  #validation
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :status, presence: true
  scope :status_active, -> {where(status: 'active')}
end
