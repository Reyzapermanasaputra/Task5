class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  before_create :default_status
  validates :content, presence: true, length: {minimum: 10}
  
  def default_status
    self.status = "not active"
  end
end
