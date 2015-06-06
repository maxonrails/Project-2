class TestsController < ApplicationController


  def index
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
	 
	    @products = []
	    
	    hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
	      product = OpenStruct.new
	      product.name = item['ItemAttributes']['Title']
	      product.url = item['DetailPageURL']
	      product.image_url = item['SmallImage']['URL']
	      
	      @products << product 
	    end
	 end
end


