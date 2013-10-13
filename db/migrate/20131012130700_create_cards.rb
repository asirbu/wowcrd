class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :tag
      t.string :message
      t.string :image
      t.string :sound
      t.string :r_name
      t.string :r_email
      t.string :track_id

      t.timestamps
    end
  end
end
