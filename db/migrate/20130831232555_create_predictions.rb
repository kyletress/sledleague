class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.integer :membership_id
      t.integer :match_id
      t.integer :athlete_id
      t.integer :position

      t.timestamps
    end
  end
end
