class PostsController < ApplicationController
respond_to :html, :js


  ## SHOWS ALL POSTS
  def index
    @posts = Post.all 
  end


  ## SHOWS ONE POST
  def show
    @post = get_post
    @votes = Vote.all
  end

  ##SUBMITS A QUERY TO AMAZON AND RETURN A HASH OF 10 ITEMS 
  def new
    @post = Post.new
    @items = Item.all
    @keyword = params[:search]
  ## VACUUM IS THE GEM USED FOR AMAZON SEARCH API IN RUBY
      request = Vacuum.new('US')
  ## AWS CONFIGURATION. ASSOCIATE_TAG IS A REFERRAL ID IN THE INSTANCE SOMEONE USES MY LINKS 
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
  ## DEFINES THE REQUEST RETURN
      raw_products = request.item_search(query: params)
      hashed_products = raw_products.to_h
  ## PUTS SPECIFICS OF HASHED SEARCH RESPONSE INTO AN ARRAY
      @products = hashed_products['ItemSearchResponse']['Items']['Item']
    
  end
  ## THIS ACTION CREATES A POST, ITEMS THAT ARE ASSOCIATED WITH THE POST, AND THE POSTITEM ENTRY.
  def createpostitem
    
  ## CREATES A NEW POST WITH THE TITLE TEXXT AND BODY TEXT IN THE NEW POST PAGE ONCE THE SUBMIT BUTTON IS PRESSED 
    @post = Post.create(title: params[:title], body: params[:body], user_id: current_user.id)
  
  ## CREATES AN INSTANCE VARIABLE FOR THE VALUE INSIDE OF THE CHECKBOXES    
    @checked = params[:products]

    # @checked = params[:products]
    # require "pry"
    # binding.pry

  ## ITERATES OVER THE HASH
    @checked.each do |product|

  ## ASSIGNS VARIABLES TO VALUES INSIDE OF THE HASHES
      asin = product["ASIN"]
      name = product['ItemAttributes']['Title']
      url = product["DetailPageURL"]
      image_url = product['SmallImage']['URL']

  ## BUILDS ITEMS (USING THE ASSOCIATION BETWEEN POSTS AND ITEMS) 
      @post.items.build(name: name, url: url, image_url: image_url, asin: asin)
    end
    
  ## REDIRECTS TO THE NEWLY CREATED POST
    redirect_to post_path(@post)

  end

  ## EDITS THE POST
  def edit
    @post = get_post
    @items = Item.all 
    @user = get_post.user_id
      unless current_user && @user == current_user.id
        redirect_to user_path(@user)
      end 
  end

  ## UPDATES THE POST
  def update
    @post = get_post
    @user = get_post.user_id

      if @post.update_attributes(post_params) 
          redirect_to user_path(@user)
      else
          render :edit
      end
  end

  ## DESTROYS THE POST
  def destroy
    @post = get_post
    @user = get_post.user_id
      if @user == current_user.id
        @post.destroy
      end
    redirect_to user_path(@user)
  end

private
    ##CALLBACK THAT REDUCES REDUNDANCY OF CODE
  def get_post
    @post = Post.find(params[:id])
  end
    
  ## POST PARAMS. NOTE THE ITEMS => [] IS NEEDED IN A MANY TO MANY RELATIONSHIP WITH A THROUGH TABLE.
  def post_params
    params.require(:post).permit(:user_id, :title, :body,:items => [])
  end
end 
