class User < ActiveRecord::Base
	## HAS MANY VOTES, HAS MANY VOTES
	## HAS SECURE PASSWORD
	## HAS_ATTACHED_FILE CORRELATES TO THE PAPERCLIP GEM. 50X50 IS USED FOR NAVBAR
	## VALIDATES SEVERAL ITEMS WHEN USERS SIGN UP. PRETTY SELF EXPLANITORY.
	has_many :posts
	has_many :votes
	has_secure_password
	has_attached_file :image, styles: {small: "50x50", med: "100x100", large: "200x200" }, :default_url => ""
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  	validates :password, presence: true, confirmation: true, length: { in: 6..20 }
  	validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..20 }
  	validates :fname, presence: true
  	validates :lname, presence: true
end
