class CreatePostItems < ActiveRecord::Migration
  def change
    create_table :post_items do |t|
      t.belongs_to :post, index: true, foreign_key: true
      t.belongs_to :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
