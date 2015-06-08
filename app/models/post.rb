class Post < ActiveRecord::Base
	## BELONGS TO USER. USER HAS MANY POSTS.
	# MANY TO MANY RELATIONSHIP WIH ITEMS. NOTE THE INCLUSION OF BOTH ITEMSS AND POST_ITEMS.
  belongs_to :user
  has_many :items, through: :post_items
  has_many :post_items
end
