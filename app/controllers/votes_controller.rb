class VotesController < ApplicationController
  def create
  	if current_user.votes.where(:post_item_id =>params[:post_item_id]).count == 0
	  	@vote = Vote.create(:user_id => current_user.id, :post_item_id =>params[:post_item_id])

	end
	redirect_to posts_path()
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
