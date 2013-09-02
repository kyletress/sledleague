class AddIndexToResults < ActiveRecord::Migration
  def change
  	add_index :results, :race_id
  	add_index :results, :athlete_id
  end
end
