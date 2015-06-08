class PostsController < ApplicationController
respond_to :html, :js



  def index
    @posts = Post.all 
  end

  def show
    @post = get_post
    @votes = Vote.all
  end

  def new
    @post = Post.new
    @items = Item.all
    @keyword = params[:search]

      request = Vacuum.new('US')
      
      request.configure(
      aws_access_key_id: ENV['aws_access_key_id'],
      aws_secret_access_key: ENV['aws_secret_access_key'],
      associate_tag: ENV['associate_tag']
      )
      
      params = {
        'SearchIndex' => 'All',
        'Keywords'=> @keyword,
        'ResponseGroup' => "ItemAttributes,Images"
      }
   
      raw_products = request.item_search(query: params)
      hashed_products = raw_products.to_h
   
      @products = hashed_products['ItemSearchResponse']['Items']['Item']
    

      # hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
      #   product = OpenStruct.new
      #   product.name = item['ItemAttributes']['Title']
      #   product.url = item['DetailPageURL']
      #   product.image_url = item['MediumImage']['URL']
      #   product.asin = item['ASIN']
      #   @products << product 
      # end
  end

  def createpostitem
   
    @post = Post.create(title: params[:title], body: params[:body], user_id: current_user.id)
    @checked = params[:products]
    require "pry"
    binding.pry
    @checked.each.as_json do |product|

    asin = product["ASIN"]
    name = product['ItemAttributes']['Title']
    url = product["DetailPageURL"]
    image_url = product['SmallImage']['URL']

    @post.items.build(name: name, url: url, image_url: image_url, asin: asin)
      # end
    end

    if @post.save
      redirect_to post_path(@post)
    end

  end

  # def create

  #   @post = Post.new(post_params)
  #   @post.user_id = current_user.id


  #     if @post.save
  #         redirect_to posts_path
  #     else
  #       render :new
  #     end
  # end

  def edit
    @post = get_post
    @items = Item.all 
    @user = get_post.user_id
      unless current_user && @user == current_user.id
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
      if @user == current_user.id
        @post.destroy
      end
    redirect_to user_path(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_post
      @post = Post.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body,:items => [])
    end
end 
