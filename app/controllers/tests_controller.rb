class TestsController < ApplicationController

	def search
		@keyword = params[:search]

		# redirect_to tests_path
 
	end


  def index
  	@keyword = params([:search])
  	request = Vacuum.new('US')
    
    request.configure(
  		aws_access_key_id: 'AKIAJSGIVXTECDP343UQ',
    	aws_secret_access_key: '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',
    	associate_tag: 'compareamazon05-20'
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
