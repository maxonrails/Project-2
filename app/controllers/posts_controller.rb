class PostsController < ApplicationController
def index
  @posts = Post.all 
  end

  def show
  @post = Post.find(params[:id])
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
  end

  def update
  @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
        redirect_to posts_path
    else
        render :edit
      end
    end

    def destroy
    @post = Post.find(params[:id]) 
    @post.destroy
    redirect_to posts_path 
    end


end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body)
    end