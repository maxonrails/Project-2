class Item < ActiveRecord::Base
	has_many :posts, through: :post_items
	has_many :post_items
end
