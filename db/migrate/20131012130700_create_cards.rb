class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :tag
      t.string :message
      t.string :image
      t.string :sound

      t.timestamps
    end
  end
end
