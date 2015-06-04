class VotesController < ApplicationController
  def create
  	vote = Vote.new(vote_params)
	vote.user = current_user
	post_items = Post_items.find(params[:post_items_id])
	vote.post_items = post_items
	vote.save
	render :new

  end

  def update
  end

  def destroy
  end

private
	def vote_params
		params.require(:vote).permit(:post_item_id, :user_id)
	end

end
