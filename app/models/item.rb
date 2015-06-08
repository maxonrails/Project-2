class Item < ActiveRecord::Base
	## MANY TO MANY RELATIONSHIP WIH POSTS. NOTE THE INCLUSION OF BOTH POSTS AND POST_ITEMS.
	has_many :posts, through: :post_items
	has_many :post_items
end
