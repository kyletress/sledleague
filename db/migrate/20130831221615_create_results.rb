class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :race_id
      t.integer :athlete_id
      t.integer :position

      t.timestamps
    end
  end
end
