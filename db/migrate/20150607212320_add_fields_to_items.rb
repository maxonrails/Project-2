class AddFieldsToItems < ActiveRecord::Migration
  def change
    add_column :items, :image_url, :string
    add_column :items, :asin, :string
    add_column :items, :url, :string
  end
end
