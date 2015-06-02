class CreateStatics < ActiveRecord::Migration
  def change
    create_table :statics do |t|
      t.string :home
      t.string :about
      t.string :contact

      t.timestamps null: false
    end
  end
end
