class VotesController < ApplicationController

	## CREATES A NEW VOTE AND ASSOCIATES THE CURRENT USER TO THE VOTE.
	## ALSO NOTE THAT THE VOTE ENTRY IS CREATED ONLY IF THE USER HAS NOT CREATED
	## A VOTE FOR THIS PARTICULAR POST_ITEM BEFORE. THIS STILL NEEDS REFACTORING.
  def create
  	if current_user.votes.where(:post_item_id =>params[:post_item_id]).count == 0
	  	@vote = Vote.create(:user_id => current_user.id, :post_item_id =>params[:post_item_id])
	end
		redirect_to posts_path()
  end

  ## NOT SURE IF I NEED THIS. WILL REEVALUATE.
  def update
  end

  ## DESTROYS THE VOTE. HAS NOT BEEN CODED IN YET. I AM NOT SURE IF I WANT TO DELETE 
  ## VOTES AT THE MOMENT. WILL RECONSIDER.
  def destroy
  end

private
	
	## VOTE PARAMS
	def vote_params
		params.require(:vote).permit(:post_item_id, :user_id)
	end

end
