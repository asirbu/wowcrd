class CreateThemes < ActiveRecord::Migration
  def change
  	create_table :themes do |t|
      t.string :name
      t.string :tags

      t.timestamps
 	end
  end
end
