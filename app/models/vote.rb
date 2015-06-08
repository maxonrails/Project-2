class Vote < ActiveRecord::Base
	## USERS CAST VOTES FOR POST_ITEMS. WE ARE ABLE TO DETERMINE WHICH ITEMS ARE VOTED
	## HOW MANY TIMES IN EACH POST BY LOOKING AT THI TABLE.
  belongs_to :user
  belongs_to :post_item
end
