class User < ActiveRecord::Base
	has_many :posts
	has_many :votes
	has_secure_password
	validates_uniqueness_of :username, case_sensitive: false
	validates :username, presence: true, length: { minimum: 2, maximum: 25 }
	has_attached_file :image, styles: {small: "50x50", med: "100x100", large: "200x200" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	
end
