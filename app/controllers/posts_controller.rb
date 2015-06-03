class PostsController < ApplicationController
def index
  @posts = Post.all 
  end

  def show
  @post = get_post
  end

  def new
  @post = Post.new
  end

  def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id
    if @post.save
        redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  @post = Post.find(params[:id])
  @user = Post.find(params[:id]).user_id
    unless @post.user.id == current_user.id 
      redirect_to user_path(@user)
    end
  end

  def update
  @post = get_post
  @user = get_post.user_id
    
      if @post.update_attributes(post_params) 
          redirect_to user_path(@user)
      else
          render :edit
      end
   
  end

  def destroy
    @post = get_post
    @user = get_post.user_id
    @post.destroy
    redirect_to user_path(@user)
  end


end
  private
    # Use callbacks to share common setup or constraints between actions.
    def get_post
      @post = Post.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body)
    end