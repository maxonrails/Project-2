class Post < ActiveRecord::Base
  belongs_to :user
  has_many :items, through: :post_items
  has_many :post_items
end
