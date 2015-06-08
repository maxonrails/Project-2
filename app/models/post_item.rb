class PostItem < ActiveRecord::Base
	## THIS IS A JOIN TABLE FOR POSTS AND ITEMS. EACH POST_ITEM CAN HAVE VOTES.
  belongs_to :post
  belongs_to :item
  has_many :votes
end
