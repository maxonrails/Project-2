class ItemsController < ApplicationController
  
  def destroy
      @item = Item.find(params[:id]) 
      @item.destroy
      redirect_to items_path 
  end

private

  def item_params
    params.require(:item).permit(:name, :category, :price,:post_ids => [])
  end
end
