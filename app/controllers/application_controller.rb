class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

	def amazon
    request = Vacuum.new('GB')

    request.configure(
  	  aws_access_key_id: 'AKIAJSGIVXTECDP343UQ',
    	aws_secret_access_key: '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',
    	associate_tag: 'compareamazon05-20'
    )

    params = {
      'SearchIndex' => 'Books',
      'Keywords'=> 'Ruby on Rails',
      'ResponseGroup' => "ItemAttributes,Images"
    }

    raw_products = request.item_search(query: params)
    hashed_products = raw_products.to_h
  end
end
