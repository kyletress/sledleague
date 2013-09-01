class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :prediction_id
      t.integer :position
      t.integer :athlete_id

      t.timestamps
    end
  end
end
